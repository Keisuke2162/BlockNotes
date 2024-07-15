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
    .init(title: "Title1", content: "Content1", themeColor: .yellow, systemIconName: "house"),
    .init(title: "Title2", content: "Content2", themeColor: .gray, systemIconName: "house"),
  ]

  public init() {}

  public var body: some View {
    HomeView(noteItems: items)
  }
}
