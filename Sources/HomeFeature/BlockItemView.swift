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
    case .note:
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
    case .note:
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
