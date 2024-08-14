//
//  SettingView.swift
//  
//
//  Created by Kei on 2024/07/23.
//

import InAppPurchaseFeature
import SwiftUI

public struct SettingView: View, Hashable {
  @EnvironmentObject var purchaseManager: InAppPurchaseManager
  @EnvironmentObject var settings: AppSettingsService
  
  @State var isLoading: Bool = false
  
  var appVersion: String {
    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
      return "version \(version)"
    }
    return ""
  }
  
  let id = UUID()
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  public static func == (lhs: SettingView, rhs: SettingView) -> Bool {
    lhs.id == rhs.id
  }

  public init() {
  }

  public var body: some View {
    ZStack {
      Form {
        Section("設定") {
          // DarkMode
          Toggle(String(localized: "dark_mode"), isOn: $settings.isDarkMode)
          // BlockSize
          NavigationLink {
            BlockSettingView()
          } label: {
            HStack {
              Text("ボタンのカスタム")
                .foregroundStyle(settings.isDarkMode ? .white : .black)
            }
          }
          // AddBlock
          NavigationLink {
            PlusBlockSettingView()
          } label: {
            HStack {
              Text("\(Image(systemName: "plus"))ボタンをカスタム")
                .foregroundStyle(settings.isDarkMode ? .white : .black)
            }
          }
          // SettingBlock
          NavigationLink {
            SettingBlockSettingView()
          } label: {
            HStack {
              Text("\(Image(systemName: "gearshape"))ボタンをカスタム")
                .foregroundStyle(settings.isDarkMode ? .white : .black)
            }
          }
          // FontSetting
          NavigationLink {
            FontSettingView()
          } label: {
            HStack {
              Text("フォント設定")
                .foregroundStyle(settings.isDarkMode ? .white : .black)
            }
          }
        }
        
        // 課金
        Button {
          // TODO: プレミアム訴求シートを表示
          Task {
            isLoading = true
            await purchaseManager.fetchProducts()
            await purchaseManager.buyProduct()
            isLoading = false
          }
        } label: {
          Text("プレミアムモード")
        }
        .disabled(purchaseManager.isPurchasedProduct)

        Button {
          Task {
            isLoading = true
            await purchaseManager.restorePurchases()
            isLoading = false
          }
        } label: {
          Text("購入を復元する")
        }
        .disabled(purchaseManager.isPurchasedProduct)

        // TODO: チュートリアル
        // TODO: 利用規約
      }
      
        VStack {
          Spacer()
          Text(appVersion)
            .foregroundStyle(.gray)
            .frame(height: 48)
        }
    }
    .preferredColorScheme(settings.isDarkMode ? .dark : .light)
  }
}
