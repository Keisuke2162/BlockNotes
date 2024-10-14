//
//  InAppPurchaseManager.swift
//  BlockNotes
//
//  Created by Kei on 2024/08/09.
//

import Foundation
import StoreKit

@MainActor
public class InAppPurchaseManager: ObservableObject {
  @Published public var isPurchasedProduct: Bool = false
  private var updateListenerTask: Task<Void, Error>?
  private var product: Product?
  private let productID: String = "premium_mode"
  
  public init() {
    updateListenerTask = listenForTransactions()
    isPurchasedProduct = UserDefaults.standard.bool(forKey: "isPurchasedProduct")
  }
  
  deinit {
    updateListenerTask?.cancel()
  }

  // アプリ起動時に呼び出して実行
  public func initialize() async {
    await fetchProduct()
    await updatePurchaseStatus()
  }

  // 商品情報を取得する
  private func fetchProduct() async {
    do {
      let products = try await Product.products(for: [productID])
      if let product = products.first {
        self.product = product
      }
    } catch {
      print("Failed to fetch product: \(error)")
    }
  }
  
  // 購入の状態を更新する
  private func updatePurchaseStatus() async {
    for await result in Transaction.currentEntitlements {
      do {
        let transaction = try await checkVerified(result)
        if transaction.productID == productID {
            await processPurchase(transaction)
        }
      } catch {
        print("Failed to verify transaction: \(error)")
      }
    }
  }
  
  // トランザクションのリスニング
  private func listenForTransactions() -> Task<Void, Error> {
    return Task.detached {
      for await result in Transaction.updates {
        do {
          let transaction = try await self.checkVerified(result)
          await self.processPurchase(transaction)
          await transaction.finish()
        } catch {
          print("Transaction failed verification: \(error)")
        }
      }
    }
  }
  
  // 購入処理
  private func processPurchase(_ transaction: Transaction) async {
    if transaction.productID == productID {
      isPurchasedProduct = (transaction.revocationDate == nil)
      updateUserDefaults()
    }
  }

  // UserDefaultsの更新
  private func updateUserDefaults() {
      UserDefaults.standard.set(isPurchasedProduct, forKey: "isPurchasedProduct")
  }

  // トランザクションの検証
  private func checkVerified<T>(_ result: VerificationResult<T>) async throws -> T {
      switch result {
      case .unverified(_, let error):
          throw error
      case .verified(let safe):
          return safe
      }
  }

  // 商品の購入
  public func purchase() async throws {
    guard let product = product else {
      throw StoreKitError.productNotFound
    }
    
    let result = try await product.purchase()
    
    switch result {
    case .success(let verificationResult):
      let transaction = try await checkVerified(verificationResult)
      await processPurchase(transaction)
      await transaction.finish()
    case .userCancelled:
      throw StoreKitError.userCancelled
    case .pending:
      throw StoreKitError.purchasePending
    @unknown default:
      throw StoreKitError.unknown
    }
  }

  // 購入の復元
  public func restorePurchases() async throws {
    try await AppStore.sync()
    await updatePurchaseStatus()
  }
}

enum StoreKitError: Error {
  case failedVerification
  case productNotFound
  case userCancelled
  case purchasePending
  case unknown
}
