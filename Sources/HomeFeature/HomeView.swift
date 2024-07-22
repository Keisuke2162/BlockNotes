//
//  HomeView.swift
//  
//
//  Created by Kei on 2024/07/14.
//

import CustomView
import Entities
import Foundation
import NoteFeature
import SwiftUI
import SwiftData

public struct HomeView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var notes: [NoteItem]
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
      initBlockViews()
    }
    .fullScreenCover(item: $editNoteItem) { item in
      NoteView(noteItem: item, isEditNote: true) { _ in
        editNoteItem = nil
      } onCancel: {
        editNoteItem = nil
      } onDelete: { _ in
        removeBlockView(item: item)
        deleteNote(item)
        editNoteItem = nil
      }
    }
    .fullScreenCover(isPresented: $isAddingNote) {
      let initialItem: NoteItem = .init(title: "", content: "", redComponent: 100, greenComponent: 100, blueComponent: 0, systemIconName: "house")
      NoteView(noteItem: initialItem, isEditNote: false) { item in
        addNote(item)
        addBlockViews(item: item)
        isAddingNote = false
      } onCancel: {
        isAddingNote = false
      } onDelete: { item in
        isAddingNote = false
      }
    }
  }
}

// MARK: NoteItemの管理
extension HomeView {
  func addNote(_ item: NoteItem) {
    modelContext.insert(item)
  }

  func deleteNote(_ item: NoteItem) {
    modelContext.delete(item)
  }
}

// MARK: Bloviewの管理
extension HomeView {
  // BlockViewを初期作成
  public func initBlockViews() {
    // Item追加Block
    let addItem: NoteItem = .init(title: "", content: "", redComponent: 0, greenComponent: 0, blueComponent: 200, systemIconName: "plus")
    let addItemView = BlockItemView(item: addItem) { _ in
      self.isAddingNote = true
    }
    if let blockView = UIHostingController(rootView: addItemView).view {
      blockView.frame = CGRect(x: CGFloat.random(in: 0...300), y: 10, width: 48, height: 48)
      blockView.backgroundColor = .clear
      blockViews.append(blockView)
    }
    
    // Setting遷移Block
    let settingItem: NoteItem = .init(title: "", content: "", redComponent: 100, greenComponent: 100, blueComponent: 100, systemIconName: "gearshape")
    let settingItemView = BlockItemView(item: settingItem) { _ in
      // TODO: 設定画面へ
    }
    if let blockView = UIHostingController(rootView: settingItemView).view {
      blockView.frame = CGRect(x: CGFloat.random(in: 0...300), y: 10, width: 48, height: 48)
      blockView.backgroundColor = .clear
      blockViews.append(blockView)
    }

    for item in notes {
      let blockItemView = BlockItemView(item: item) { noteItem in
        self.editNoteItem = noteItem
      }
      if let blockView = UIHostingController(rootView: blockItemView).view {
        blockView.frame = CGRect(x: CGFloat.random(in: 0...300), y: 10, width: 48, height: 48)
        blockView.backgroundColor = .clear
        blockViews.append(blockView)
      }
    }
  }
  
  // 追加したItemのBlockViewを追加
  public func addBlockViews(item: NoteItem) {
    let blockItemView = BlockItemView(item: item) { noteItem in
      self.editNoteItem = noteItem
    }
    if let blockView = UIHostingController(rootView: blockItemView).view {
      blockView.frame = CGRect(x: CGFloat.random(in: 0...300), y: 10, width: 48, height: 48)
      blockView.backgroundColor = .clear
      blockViews.append(blockView)
    }
  }
  
  // 削除したItemのBlockViewを削除
  public func removeBlockView(item: NoteItem) {
    if let index = notes.firstIndex(where: { $0.id == item.id }) {
      // FIXME: 追加ボタン、設定ボタン分の+2
      blockViews.remove(at: index + 2)
    }
  }
}
