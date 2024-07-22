//
//  BlockItemView.swift
//
//
//  Created by Kei on 2024/07/13.
//

import Entities
import Foundation
import SwiftUI

public struct BlockItemView: View {
  let item: NoteItem
  let buttonTapAction: (NoteItem) -> Void

  public init(item: NoteItem, buttonTapAction: @escaping (NoteItem) -> Void) {
    self.item = item
    self.buttonTapAction = buttonTapAction
  }

  public var body: some View {
    Button(action: {
      buttonTapAction(item)
    }, label: {
      Image(systemName: item.systemIconName)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .foregroundColor(Color(uiColor: item.uiColor.textColor()))
        .padding(16)
    })
    .frame(width: 48, height: 48)
    .background(item.color)
    .clipShape(.rect(cornerRadius: 8))
  }
}
