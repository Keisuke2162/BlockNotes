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
  @State private var editNoteItem: NoteItem?
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
      updateBlockViews()
    }
    .fullScreenCover(item: $editNoteItem) { item in
      let noteItem: Binding<NoteItem> = Binding(
        get: {
          item
        }, set: { newValue in
          if let index = noteStore.notes.firstIndex(where: { $0.id == item.id }) {
            noteStore.notes[index] = newValue
          }
        }
      )
      
      NoteView(noteItem: noteItem) { _ in
        editNoteItem = nil
      } onCancel: {
        editNoteItem = nil
      } onDelete: { _ in
        removeBlockView(item: item)
        noteStore.deleteItem(item)
        editNoteItem = nil
      }
    }
    .fullScreenCover(isPresented: $isAddingNote) {
      let initialItem: NoteItem = .init(
        title: "",
        content: "",
        themeColor: .green,
        systemIconName: "house",
        type: .note
      )
      NoteView(noteItem: .constant(initialItem)) { item in
        noteStore.addItem(item)
        isAddingNote = false
        addBlockViews(item: item)
      } onCancel: {
        isAddingNote = false
      } onDelete: { item in
        isAddingNote = false
      }
    }
  }
}

extension HomeView {
  // BlockViewを初期作成
  public func updateBlockViews() {
    for item in noteStore.notes {
      let blockItemView = BlockItemView(item: item) { noteItem in
        switch noteItem.type {
        case .add:
          self.isAddingNote = true
          break
        case .note:
          self.editNoteItem = noteItem
        case .setting:
          // TODO: 設定画面へ
          break
        }
      }
      if let blockView = UIHostingController(rootView: blockItemView).view {
        blockView.frame = CGRect(x: CGFloat.random(in: 0...300), y: 10, width: 48, height: 48)
        blockViews.append(blockView)
      }
    }
  }
  
  // 追加したItemのBlockViewを追加
  public func addBlockViews(item: NoteItem) {
    let blockItemView = BlockItemView(item: item) { noteItem in
      switch noteItem.type {
      case .add:
        self.isAddingNote = true
        break
      case .note:
        self.editNoteItem = noteItem
      case .setting:
        // TODO: 設定画面へ
        break
      }
    }
    if let blockView = UIHostingController(rootView: blockItemView).view {
      blockView.frame = CGRect(x: CGFloat.random(in: 0...300), y: 10, width: 48, height: 48)
      blockViews.append(blockView)
    }
  }
  
  // 削除したItemのBlockViewを削除
  public func removeBlockView(item: NoteItem) {
    if let index = noteStore.notes.firstIndex(where: { $0.id == item.id }) {
      print("テスト \(index)")
      blockViews.remove(at: index)
    }
  }
}
