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

  public init(item: NoteItem) {
    self.item = item
  }

  public var body: some View {
    Image(systemName: "house")
  }
}

#Preview {
  BlockItemView(item: .init(title: "Title1", content: "Content1", symbol: "house"))
}
