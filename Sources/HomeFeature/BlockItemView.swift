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
    Button(action: {
      buttonTapAction(item)
    }, label: {
      Image(systemName: item.systemIconName)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .foregroundColor(Color(uiColor: item.uiColor.textColor()))
        .padding(12)
    })
    .frame(width: blockFrame, height: blockFrame)
    .background(item.color)
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
