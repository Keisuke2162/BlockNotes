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
  @State private var blockViews: [UIView] = []
  private var noteItems: [NoteItem] = []

  public init(noteItems: [NoteItem]) {
    self.noteItems = noteItems
  }

  public var body: some View {
    GeometryReader { geometry in
      GravityView(animationViews: $blockViews, viewSize: geometry.size)
        .background(Color.blue)
        .padding(.bottom, geometry.safeAreaInsets.bottom)
    }
    .onAppear {
      for item in noteItems {
        let blockItemView = BlockItemView(item: item)
        if let blockView = UIHostingController(rootView: blockItemView).view {
          blockView.frame = CGRect(x: 10, y: 10, width: 48, height: 48)
          blockViews.append(blockView)
        }
      }
    }
  }
}
