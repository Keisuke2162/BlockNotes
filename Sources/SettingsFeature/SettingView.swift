//
//  SettingView.swift
//  
//
//  Created by Kei on 2024/07/23.
//

import SwiftUI

public struct SettingView: View, Hashable {
  @EnvironmentObject var settings: AppSettingsService
  
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
    Form {
      Section("設定") {
        // DarkMode
        Toggle("ダークモード", isOn: $settings.isDarkMode)
        // BlockSize
        NavigationLink {
          BlockSettingView()
        } label: {
          HStack {
            Text("Blockのカスタム")
              .foregroundStyle(settings.isDarkMode ? .white : .black)
          }
        }
        // AddBlock
        NavigationLink {
          PlusBlockSettingView()
        } label: {
          HStack {
            Text("+Blockをカスタム")
              .foregroundStyle(settings.isDarkMode ? .white : .black)
          }
        }
        // SettingBlock
        NavigationLink {
          SettingBlockSettingView()
        } label: {
          HStack {
            Text("SettingBlockをカスタム")
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
      // TODO: チュートリアル
      // TODO: 利用規約
      // TODO: バージョン
    }
    .preferredColorScheme(settings.isDarkMode ? .dark : .light)
  }
}
