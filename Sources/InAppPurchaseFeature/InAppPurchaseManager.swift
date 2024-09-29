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
  @Published public var isPurchasedProduct: Bool = UserDefaults.standard.bool(forKey: "isPurchasedProduct")

  private var product: Product?

  public init() {
  }

  // 商品を取得
  public func fetchProducts() async {
    do {
      let products = try await Product.products(for: ["premium_mode"])
      self.product = products.first
    } catch {
      print("Failed to fetch products: \(error)")
    }
  }

  // 商品を購入
  public func buyProduct() async {
    guard let product else { return }
    do {
      // TODO: Transaction.updatesのリッスン
      let result = try await product.purchase()
      switch result {
      case .success(let verificationResult):
        switch verificationResult {
        case .unverified(let signedType, let verificationError):
          print("Transaction verification failed: \(verificationError)")
          
        case .verified(let transaction):
          print("テスト3")
          UserDefaults.standard.set(true, forKey: "isPurchasedProduct")
          isPurchasedProduct = true
          await transaction.finish()
        }
      case .userCancelled:
        print("User cancelled the purchase.")
      case .pending:
        print("Purchase is pending.")
      @unknown default:
        print("Unknown result.")
      }
    } catch {
      print("Purchase failed: \(error)")
    }
  }

  // 商品の購入を復元
  public func restorePurchases() async {
    do {
      for await result in Transaction.currentEntitlements {
        switch result {
        case .verified(let transaction):
          UserDefaults.standard.set(true, forKey: "isPurchasedProduct")
          isPurchasedProduct = true
          await transaction.finish()
        case .unverified:
          // Handle unverified transactions if needed
          break
        }
      }
    } catch {
      print("Failed to restore purchases: \(error)")
    }
  }
}
