//
//  BlockSettingView.swift
//  
//
//  Created by Kei on 2024/07/26.
//

import SwiftUI

public struct BlockSettingView: View {
  @EnvironmentObject var settings: AppSettingsService

  public init() {
  }

  public var body: some View {
    VStack(spacing: 32) {
      Group {
        VStack {
          // アイコン
          Text("\(Int(settings.blockFrame))")
          Button {
          } label: {
            Image(systemName: "house")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .foregroundStyle(.black)
              .padding(16)
          }
          .frame(width: settings.blockFrame, height: settings.blockFrame)
          .background(Color.gray)
          .clipShape(.rect(cornerRadius: 8))
          .overlay {
            RoundedRectangle(cornerRadius: 8)
              .stroke(lineWidth: 2)
              .fill(
                settings.isShowBlockBorder ? (settings.isDarkMode ? .white : .black) : .clear
              )
          }
        }
      }
      .frame(width: 200, height: 200)
      // サイズ
      HStack {
        Text("32")
        Slider(value: $settings.blockFrame, in: 32...160)
        Text("160")
      }
      .padding(.horizontal, 32)
      // 枠線
      Toggle("枠線の表示", isOn: $settings.isShowBlockBorder)
        .padding(.horizontal, 32)
    }
  }
}
