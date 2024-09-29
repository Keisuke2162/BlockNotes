//
//  HomeView.swift
//  
//
//  Created by Kei on 2024/07/14.
//

import AdFeature
import CustomViewFeature
import Entities
import Extensions
import Foundation
import InAppPurchaseFeature
import MotionFeature
import NoteFeature
import SettingsFeature
import SwiftUI
import SwiftData

public struct HomeView: View {
  @EnvironmentObject var purchaseManager: InAppPurchaseManager

  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var settings: AppSettingsService
  private var blockSize: AppSettingsService.BlockSizeType = .medium

  @State private var navigationPath = NavigationPath()
  @State private var isFirstAppear = true

  @Query private var notes: [NoteItem]
  @State private var isAddingNote = false {
    didSet {
      isAddingNote ? motionManager.finishDeviceMotionUpdates() : motionManager.startDeviceMotionUpdates()
    }
  }
  @State private var editingNoteItem: NoteItem? {
    didSet {
      editingNoteItem != nil ? motionManager.finishDeviceMotionUpdates() : motionManager.startDeviceMotionUpdates()
      beforeChangeItem = editingNoteItem
    }
  }
  @State private var beforeChangeItem: NoteItem?
  @State private var blockViews: [UIView] = []

  @StateObject private var motionManager = MotionManager()
  
  public init() {
  }

  public var body: some View {
    GeometryReader { geometry in
      NavigationStack(path: $navigationPath) {
        VStack {
          GravityView(animationViews: $blockViews,
                      angle: $motionManager.angle,
                      viewWidth: geometry.size.width,
                      viewHeight: geometry.size.height,
                      isPurchaseProduct: purchaseManager.isPurchasedProduct)
          
          if !purchaseManager.isPurchasedProduct {
            // バナー広告
            BannerAdView()
              .frame(height: 50, alignment: .center)
          }
        }
        .onAppear {
          if isFirstAppear {
            initBlockViews()
            isFirstAppear = false
          }
          motionManager.startDeviceMotionUpdates()
          // TODO: 初回起動時はtutorial用のブロックを追加する（SwiftDataにも追加）
//          if settings.isFirstLaunch {
//            addTutorialBlock()
//            settings.isFirstLaunch = false
//          }
        }
        .fullScreenCover(item: $editingNoteItem) { item in
          // 既存Itemの編集
          NoteView(noteItem: item, isEditNote: true) { newItem in
            saveItem(newItem)
            editingNoteItem = nil
          } onCancel: {
            saveItem(beforeChangeItem)
            editingNoteItem = nil
          } onDelete: { item in
            removeBlockView(item: item)
            deleteNote(item)
            editingNoteItem = nil
          }
        }
        .fullScreenCover(isPresented: $isAddingNote) {
          // 新規Itemの追加
          let initialItem: NoteItem = .init(
            title: "",
            content: "",
            hue: 0.5,
            saturation: 1,
            brightness: 1, systemIconName: "pencil", blockType: .note)
          NoteView(noteItem: initialItem, isEditNote: false) { newItem in
            saveItem(newItem)
            addBlockViews(item: newItem)
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
    }
    .onChange(of: settings.blockSizeType, { _, _ in
      removeAllBlock()
      initBlockViews()
    })
    .onReceive(NotificationCenter.default.publisher(for: .deviceDidShakeNotification), perform: { _ in
      if settings.isEnableShake {
        removeAllBlock()
        initBlockViews()
      }
    })
    .preferredColorScheme(settings.isDarkMode ? .dark : .light)
  }
}

// MARK: NoteItemの管理
extension HomeView {
  func saveItem(_ item: NoteItem?) {
    guard let item else { return }
    if let noteItem = notes.first(where: { $0.id == item.id }) {
      noteItem.title = item.title
      noteItem.content = item.content
      noteItem.hue = item.hue
      noteItem.saturation = item.saturation
      noteItem.brightness = item.brightness
      noteItem.systemIconName = item.systemIconName
      noteItem.blockTypeValue = item.blockTypeValue
    } else {
      modelContext.insert(item)
    }

    do {
      try modelContext.save()
    } catch {
      print("Failed to save data: \(error)")
    }
  }

  func deleteNote(_ item: NoteItem) {
    modelContext.delete(item)
    do {
      try modelContext.save()
    } catch {
      print("Failed to save data: \(error)")
    }
  }
}

// MARK: Bloviewの管理
extension HomeView {
  // BlockViewを初期作成
  public func initBlockViews() {
    let blockFrame = settings.getBlockFrame()
    // Item追加Block
    let addItem: NoteItem = .init(title: "", content: "", hue: 0, saturation: 1, brightness: 1, systemIconName: "ic-plus", blockType: .add)
    let addItemView = BlockItemView(item: addItem) { _ in
      self.editingNoteItem = nil
      self.isAddingNote = true
    }
    if let blockView = UIHostingController(rootView: addItemView).view {
      blockView.frame = CGRect(x: CGFloat.random(in: 0...300), y:200, width: blockFrame, height: blockFrame)
      blockView.backgroundColor = .clear
      blockViews.append(blockView)
    }

    // Setting遷移Block
    let settingItem: NoteItem = .init(title: "",  content: "", hue: 0, saturation: 1, brightness: 1, systemIconName: "ic-gearshape", blockType: .setting)
    let settingItemView = BlockItemView(item: settingItem) { _ in
      navigationPath.append(SettingView())
    }
    if let blockView = UIHostingController(rootView: settingItemView).view {
      blockView.frame = CGRect(x: CGFloat.random(in: 0...300), y: 200, width: blockFrame, height: blockFrame)
      blockView.backgroundColor = .clear
      blockViews.append(blockView)
    }

    // 保存ずみのItem
    for item in notes {
      let blockItemView = BlockItemView(item: item) { noteItem in
        self.editingNoteItem = noteItem
      }
      if let blockView = UIHostingController(rootView: blockItemView).view {
        blockView.frame = CGRect(x: CGFloat.random(in: 0...300), y: 100, width: blockFrame, height: blockFrame)
        blockView.backgroundColor = .clear
        blockViews.append(blockView)
      }
    }
  }
  
  // 追加したItemのBlockViewを追加
  public func addBlockViews(item: NoteItem) {
    let blockFrame = settings.getBlockFrame()
    let blockItemView = BlockItemView(item: item) { noteItem in
      self.editingNoteItem = noteItem
    }
    if let blockView = UIHostingController(rootView: blockItemView).view {
      blockView.frame = CGRect(x: CGFloat.random(in: 0...300), y: 0, width: blockFrame, height: blockFrame)
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

  // チュートリアル用
  public func addTutorialBlock() {
    let tutorialItem: NoteItem = .init(title: String(localized: "tutorial_title"), content: "", hue: 0.5, saturation: 1, brightness: 1, systemIconName: "book", blockType: .tutorial)
    saveItem(tutorialItem)
    addBlockViews(item: tutorialItem)
  }
}
