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
    VStack(alignment: .center, spacing: 32) {
      // TODO: アイコンサイズは小・中・大の選択式にする
      HStack(alignment: .center, spacing: 16) {
        // small
        blockTypeView(type: .small)
        
        // medium
        blockTypeView(type: .medium)

        // large
        blockTypeView(type: .large)
      }
      .padding(.horizontal, 16)
      // 枠線
      Toggle("枠線の表示", isOn: $settings.isShowBlockBorder)
        .padding(.horizontal, 32)
    }
  }
  
  
  @ViewBuilder
  private func blockTypeView(type: AppSettingsService.BlockSizeType) -> some View {
    var blockWidth: CGFloat {
      switch type {
      case .small:
        40
      case .medium:
        56
      case .large:
        72
      }
    }
  
    var bottomPadding: CGFloat {
      switch type {
      case .small:
        48
      case .medium:
        32
      case .large:
        16
      }
    }
  
    Button {
      settings.blockSizeType = type
    } label: {
      VStack {
        Image(systemName: "checkmark")
          .resizable()
          .frame(width: 24, height: 24)
          .aspectRatio(contentMode: .fill)
          .foregroundStyle(
            settings.blockSizeType == type ? (settings.isDarkMode ? .white : .black) : .clear
          )
          .padding(16)
        Group {
          Image(systemName: "house")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundStyle(.black)
            .padding(12)
        }
        .frame(width: blockWidth, height: blockWidth)
        .background(Color.gray)
        .clipShape(.rect(cornerRadius: 8))
        .overlay {
          RoundedRectangle(cornerRadius: 8)
            .stroke(lineWidth: 2)
            .fill(
              settings.isShowBlockBorder ? (settings.isDarkMode ? .white : .black) : .clear
            )
        }
        .padding(.bottom, bottomPadding)
        Text(type.rawValue)
          .foregroundStyle(settings.isDarkMode ? .white : .black)
      }
      .padding(8)
      .frame(height: 200)
    }
  }
}
