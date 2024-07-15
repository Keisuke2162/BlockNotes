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
import NoteFeature
import SwiftUI

public struct HomeView: View {
  @State private var noteStore = NoteItemStore()
  @State private var isAddingNote = false
  @State private var noteItem: NoteItem?
  @State private var blockViews: [UIView] = []
  
  public init() {
  }

  public var body: some View {
    GeometryReader { geometry in
      GravityView(animationViews: $blockViews, viewSize: geometry.size)
        .background(Color.blue)
        .padding(.bottom, geometry.safeAreaInsets.bottom)
    }
    .onAppear {
      for item in noteStore.notes {
        let blockItemView = BlockItemView(item: item) { noteItem in
          self.noteItem = noteItem
        }
        if let blockView = UIHostingController(rootView: blockItemView).view {
          blockView.frame = CGRect(x: 10, y: 10, width: 48, height: 48)
          blockViews.append(blockView)
        }
      }
    }
    .sheet(item: $noteItem) { item in
      NoteView(noteItem: Binding(
        get: {
          item
        }, set: { newValue in
          if let index = noteStore.notes.firstIndex(where: { $0.id == item.id }) {
            noteStore.notes[index] = newValue
          }
        }
      ))
    }
  }
}
