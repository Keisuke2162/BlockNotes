//
//  BlockItemView.swift
//
//
//  Created by Kei on 2024/07/13.
//

import ComposableArchitecture
import Entities
import Foundation
import SwiftUI

@Reducer
public struct BlockItem {
  @ObservableState
  public struct State: Equatable {
    public let item: NoteItem

    public init(item: NoteItem) {
      self.item = item
    }
  }
  
  public enum Action {
    case tapItem(NoteItem)
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .tapItem:
        return .none
      }
    }
  }
}

public struct BlockItemView: View {
  public let store: StoreOf<BlockItem>
  
  public init(store: StoreOf<BlockItem>) {
    self.store = store
  }

  public var body: some View {
    Image(systemName: "house")
  }
}

#Preview {
  BlockItemView(store: .init(
    initialState: BlockItem.State(item: .init(title: "AA", content: "BB", symbol: "CC")),
    reducer: {
      BlockItem()
    }
  ))
}
