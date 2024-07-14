//
//  RootView.swift
//  
//
//  Created by Kei on 2024/07/14.
//

import Entities
import HomeFeature
import SwiftUI

public struct RootView: View {
  let items: [NoteItem] = [
    .init(title: "Title1", content: "Content1", symbol: "Symbol1")
  ]

  public init() {}

  public var body: some View {
    HomeView(items: items)
  }
}
