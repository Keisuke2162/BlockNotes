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
import SettingsFeature
import SwiftUI
import SwiftData

public struct HomeView: View {
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var settings: AppSettingsService

  @State private var navigationPath = NavigationPath()
  @State private var isFirstAppear = true

  @Query private var notes: [NoteItem]
  @State private var isAddingNote = false
  @State private var editNoteItem: NoteItem?
  @State private var blockViews: [UIView] = []
  
  public init() {
  }

  public var body: some View {
    NavigationStack(path: $navigationPath) {
      GeometryReader { geometry in
        GravityView(animationViews: $blockViews, viewSize: geometry.size)
          .padding(.bottom, geometry.safeAreaInsets.bottom)
      }
      .onAppear {
        if isFirstAppear {
          initBlockViews()
          isFirstAppear = false
        }
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
        let initialColorComponent: CGFloat = settings.isDarkMode ? 255 : 0
        let initialItem: NoteItem = .init(title: "",
                                          content: "",
                                          redComponent: initialColorComponent,
                                          greenComponent: initialColorComponent,
                                          blueComponent: initialColorComponent,
                                          systemIconName: "house",
                                          blockType: .note)
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
      .navigationDestination(for: SettingView.self) { view in
        view
      }
    }
    .onChange(of: [settings.plusBlockRedComponent, settings.plusBlockGreenComponent, settings.plusBlockBlueComponent,
                   settings.settingBlockRedComponent, settings.settingBlockGreenComponent, settings.settingBlockBlueComponent], { _, _ in
      // initBlockViews()
    })
    .preferredColorScheme(settings.isDarkMode ? .dark : .light)
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
    let blockFrame = settings.getBlockFrame()
    // Item追加Block
    let addItem: NoteItem = .init(title: "",
                                  content: "",
                                  redComponent: 0,
                                  greenComponent: 0,
                                  blueComponent: 0,
                                  systemIconName: "plus",
                                  blockType: .add)
    let addItemView = BlockItemView(item: addItem) { _ in
      self.isAddingNote = true
    }
    if let blockView = UIHostingController(rootView: addItemView).view {
      blockView.frame = CGRect(x: CGFloat.random(in: 0...300), y: 100, width: blockFrame, height: blockFrame)
      blockView.backgroundColor = .clear
      blockViews.append(blockView)
    }

    // Setting遷移Block
    let settingItem: NoteItem = .init(title: "", 
                                      content: "",
                                      redComponent: 0,
                                      greenComponent: 0,
                                      blueComponent: 0,
                                      systemIconName: "gearshape",
                                      blockType: .setting)
    let settingItemView = BlockItemView(item: settingItem) { _ in
      navigationPath.append(SettingView())
    }
    if let blockView = UIHostingController(rootView: settingItemView).view {
      blockView.frame = CGRect(x: CGFloat.random(in: 0...300), y: 100, width: blockFrame, height: blockFrame)
      blockView.backgroundColor = .clear
      blockViews.append(blockView)
    }

    for item in notes {
      let blockItemView = BlockItemView(item: item) { noteItem in
        self.editNoteItem = noteItem
      }
      if let blockView = UIHostingController(rootView: blockItemView).view {
        blockView.frame = CGRect(x: CGFloat.random(in: 0...300), y: 10, width: blockFrame, height: blockFrame)
        blockView.backgroundColor = .clear
        blockViews.append(blockView)
      }
    }
  }
  
  // 追加したItemのBlockViewを追加
  public func addBlockViews(item: NoteItem) {
    let blockFrame = settings.getBlockFrame()
    let blockItemView = BlockItemView(item: item) { noteItem in
      self.editNoteItem = noteItem
    }
    if let blockView = UIHostingController(rootView: blockItemView).view {
      blockView.frame = CGRect(x: CGFloat.random(in: 0...300), y: 10, width: blockFrame, height: blockFrame)
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

  // Blockを全て削除
  public func removeAllBlock() {
    blockViews.removeAll()
  }
}
