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

  private var appIconImageName: String {
    "AppIconImage\(settings.largeIconColor.colorSymbol)\(settings.mediumIconColor.colorSymbol)\(settings.smallIconColor.colorSymbol)"
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
        Section(String(localized: "settings")) {
          // DarkMode
          Toggle(String(localized: "dark_mode"), isOn: $settings.isDarkMode)
          // Shake
          Toggle(String(localized: "shake_phone"), isOn: $settings.isEnableShake)
          // BlockSize
          NavigationLink {
            BlockSettingView()
          } label: {
            HStack {
              Text(String(localized: "setting_block"))
                .foregroundStyle(settings.isDarkMode ? .white : .black)
            }
          }
          // AddBlock
          NavigationLink {
            PlusBlockSettingView()
          } label: {
            HStack {
              Text("\(Image(systemName: "plus"))\(String(localized: "setting_block"))")
                .foregroundStyle(settings.isDarkMode ? .white : .black)
            }
          }
          // SettingBlock
          NavigationLink {
            SettingBlockSettingView()
          } label: {
            HStack {
              Text("\(Image(systemName: "gearshape"))\(String(localized: "setting_block"))")
                .foregroundStyle(settings.isDarkMode ? .white : .black)
            }
          }
          // FontSetting
          NavigationLink {
            FontSettingView()
          } label: {
            HStack {
              Text(String(localized: "setting_font"))
                .foregroundStyle(settings.isDarkMode ? .white : .black)
            }
          }
          // ChangeAppIcon
          NavigationLink {
            SetAppIconView()
          } label: {
            HStack {
              // TODO: Localize
              Text("Change App Icon")
                .foregroundStyle(settings.isDarkMode ? .white : .black)
            }
          }
        }
        // 課金
        Button {
          // TODO: プレミアム訴求シートを表示
          Task {
            isLoading = true
            try await purchaseManager.purchase()
            isLoading = false
          }
        } label: {
          Text(String(localized: "remove_ads"))
        }
        .disabled(purchaseManager.isPurchasedProduct)

        Button {
          Task {
            isLoading = true
            try await purchaseManager.restorePurchases()
            isLoading = false
          }
        } label: {
          Text(String(localized: "restore_premium"))
        }
        .disabled(purchaseManager.isPurchasedProduct)
      }

      VStack() {
        Spacer()
        VStack(spacing: 4) {
          Image(appIconImageName)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .frame(width: 48, height: 48)
            .clipShape(.rect(cornerRadius: 8))
          Text(appVersion)
            .foregroundStyle(.gray)
        }
        .padding(.bottom, 8)
      }

      if isLoading {
        Color.black.opacity(0.5)
        ProgressView()
      }
    }
    .preferredColorScheme(settings.isDarkMode ? .dark : .light)
  }
}
