//
//  HomeView.swift
//  
//
//  Created by Kei on 2024/07/14.
//

import BlockItemFeature
import CustomView
import Entities
import Foundation
import SwiftUI

public struct HomeView: View {
  @State public var items: [NoteItem]
  @State public var buttons: [UIHostingController<BlockItemView>] = []
  
  public init(items: [NoteItem]) {
    self.items = items
  }

  public var body: some View {
    GravityView(noteItemViews: $buttons)
    .background(Color.red)
    .onAppear {
      self.buttons = items.map {
        let view: UIHostingController<BlockItemView> = .init(rootView: .init(item: $0))
        view.view.frame = CGRect(x: 48, y: 48, width: 48, height: 48)
        return view
      }
    }
  }
}

#Preview {
  let items: [NoteItem] = [
    .init(title: "Title1", content: "Content1", symbol: "house"),
    .init(title: "Title2", content: "Content2", symbol: "house"),
    .init(title: "Title3", content: "Content3", symbol: "house"),
  ]

  HomeView(items: items)
}
