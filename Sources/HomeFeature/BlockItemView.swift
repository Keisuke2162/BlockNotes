//
//  BlockItemView.swift
//
//
//  Created by Kei on 2024/07/13.
//

import Entities
import Foundation
import SettingsFeature
import SwiftUI

public struct BlockItemView: View {
  @EnvironmentObject var settings: AppSettingsService

  @State private var isBlinking = false
  let item: NoteItem
  let buttonTapAction: (NoteItem) -> Void

  public init(item: NoteItem, buttonTapAction: @escaping (NoteItem) -> Void) {
    self.item = item
    self.buttonTapAction = buttonTapAction
  }

  public var body: some View {
    let blockFrame = settings.getBlockFrame()
    let padding = settings.getBlockImagePadding()
    Button(action: {
      buttonTapAction(item)
    }, label: {
      Image(systemName: item.systemIconName)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .foregroundColor(getForegroundColor(item: item))
        .padding(padding)
        .opacity(item.blockType == .tutorial && isBlinking ? 0 : 1)
        .animation(item.blockType == .tutorial ? Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true) : .bouncy, value: isBlinking)
        .onAppear {
          if item.blockType == .tutorial {
            isBlinking = true
          }
        }
    })
    .frame(width: blockFrame, height: blockFrame)
    .background(getBackgroundColor(item: item))
    .clipShape(.rect(cornerRadius: 8))
    .overlay {
      RoundedRectangle(cornerRadius: 8)
        .stroke(lineWidth: 2)
        .fill(
          settings.isShowBlockBorder ? (settings.isDarkMode ? .white : .black) : .clear
        )
    }
  }

  private func getForegroundColor(item: NoteItem) -> Color {
    switch item.blockType {
    case .note, .tutorial:
      return item.color.foregroundColor
    case .add:
      return Color(hue: settings.plusBlockHue,
                   saturation: settings.plusBlockSaturation,
                   brightness: settings.plusBlockBrightness).foregroundColor
    case .setting:
      return Color(hue: settings.settingBlockHue,
                   saturation: settings.settingBlockSaturation,
                   brightness: settings.settingBlockBrightness).foregroundColor
    case .other:
      return settings.isDarkMode ? .black : .white
    }
  }

  private func getBackgroundColor(item: NoteItem) -> Color {
    switch item.blockType {
    case .note, .tutorial:
      return item.color
    case .add:
      return Color(hue: settings.plusBlockHue, saturation: settings.plusBlockSaturation, brightness: settings.plusBlockBrightness)
    case .setting:
      return Color(hue: settings.settingBlockHue, saturation: settings.settingBlockSaturation, brightness: settings.settingBlockBrightness)
    case .other:
      return settings.isDarkMode ? .white : .black
    }
  }
}
