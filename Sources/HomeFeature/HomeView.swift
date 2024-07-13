//
//  HomeView.swift
//  
//
//  Created by Kei on 2024/07/14.
//

import ComposableArchitecture
import BlockItemFeature
import CustomView
import Entities
import Foundation
import SwiftUI

@Reducer
public struct Home {
  @ObservableState
  public struct State: Equatable {
    public let items: [NoteItem]

    public init(items: [NoteItem]) {
      self.items = items
    }
  }
  
  public enum Action {
    case onAppear
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .none
      }
    }
  }
}

public struct HomeView: View {
  public let store: StoreOf<Home>
  
  public init(store: StoreOf<Home>) {
    self.store = store
  }

  public var body: some View {
    HStack {
      GravityView(items: store.items)
//      Image(systemName: "house")
//        .resizable()
//        .frame(width: 100, height: 100)
//        .background(Color.blue)
//        .padding(24)
    }
  }
}

#Preview {
  let items: [NoteItem] = [
    .init(title: "Title1", content: "Content1", symbol: "house"),
    .init(title: "Title2", content: "Content2", symbol: "house"),
    .init(title: "Title3", content: "Content3", symbol: "house"),
  ]
  return HomeView(store: .init(initialState: Home.State(items: items), reducer: {
    Home()
  }))
}
