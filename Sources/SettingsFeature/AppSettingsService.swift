//
//  AppSettingsService.swift
//  
//
//  Created by Kei on 2024/07/23.
//

import SwiftUI

public class AppSettingsService: ObservableObject {
  // FirstLaunch
  @Published public var isFirstLaunch: Bool {
    didSet {
      userDefaults.set(isFirstLaunch, forKey: "isFirstLaunch")
    }
  }
  // HomeView
  @Published public var isDarkMode: Bool {
    didSet {
      userDefaults.set(isDarkMode, forKey: "isDarkMode")
    }
  }

  @Published public var blockSizeType: BlockSizeType {
    didSet {
      userDefaults.set(blockSizeType.rawValue, forKey: "blockSizeType")
    }
  }

  @Published public var isShowBlockBorder: Bool {
    didSet {
      userDefaults.set(isShowBlockBorder, forKey: "isShowBlockBorder")
    }
  }

  // PlusBlockColor
  @Published public var plusBlockHue: Double {
    didSet {
      userDefaults.set(plusBlockHue, forKey: "plusBlockHue")
    }
  }
  @Published public var plusBlockSaturation: Double {
    didSet {
      userDefaults.set(plusBlockSaturation, forKey: "plusBlockSaturation")
    }
  }
  @Published public var plusBlockBrightness: Double {
    didSet {
      userDefaults.set(plusBlockBrightness, forKey: "plusBlockBrightness")
    }
  }
  
  // SettingBlockColor
  @Published public var settingBlockHue: Double {
    didSet {
      userDefaults.set(settingBlockHue, forKey: "settingBlockHue")
    }
  }
  @Published public var settingBlockSaturation: Double {
    didSet {
      userDefaults.set(settingBlockSaturation, forKey: "settingBlockSaturation")
    }
  }
  @Published public var settingBlockBrightness: Double {
    didSet {
      userDefaults.set(settingBlockBrightness, forKey: "settingBlockBrightness")
    }
  }

  // Font
  @Published public var fontType: AppFontType {
    didSet {
      userDefaults.set(fontType.rawValue, forKey: "fontType")
    }
  }

  private var userDefaults: UserDefaults

  public init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
    // 初期値設定
    userDefaults.register(defaults: [
      "isFirstLaunch" : true,
      "plusBlockHue" : 0.5,
      "plusBlockSaturation" : 1.0,
      "plusBlockBrightness" : 1.0,
      "settingBlockHue" : 0.5,
      "settingBlockSaturation" : 1.0,
      "settingBlockBrightness": 1.0
    ])
    // 設定値取り出し
    self.isFirstLaunch = userDefaults.bool(forKey: "isFirstLaunch")
    self.isDarkMode = userDefaults.bool(forKey: "isDarkMode")
    self.blockSizeType = BlockSizeType(rawValue: userDefaults.string(forKey: "blockSizeType") ?? "medium") ?? .medium
    self.isShowBlockBorder = userDefaults.bool(forKey: "isShowBlockBorder")
    // PlusBlockColor
    self.plusBlockHue = userDefaults.double(forKey: "plusBlockHue")
    self.plusBlockSaturation = userDefaults.double(forKey: "plusBlockSaturation")
    self.plusBlockBrightness = userDefaults.double(forKey: "plusBlockBrightness")
    // SettingBlockColor
    self.settingBlockHue = userDefaults.double(forKey: "settingBlockHue")
    self.settingBlockSaturation = userDefaults.double(forKey: "settingBlockSaturation")
    self.settingBlockBrightness = userDefaults.double(forKey: "settingBlockBrightness")

    self.fontType = AppFontType(rawValue: userDefaults.string(forKey: "fontType") ?? "system") ?? .system
  }

  public enum BlockSizeType: String {
    case small
    case medium
    case large
  }

  public func getBlockFrame() -> CGFloat {
    switch blockSizeType {
    case .small:
      40
    case .medium:
      56
    case .large:
      72
    }
  }

  public func getBlockImagePadding() -> CGFloat {
    switch blockSizeType {
    case .small:
      12
    case .medium:
      16
    case .large:
      20
    }
  }
}

public enum AppFontType: String, CaseIterable {
  case arial
  case courier
  case georgia
  case helvetica
  case timesNewRoman
  case verdana
  case system

  var fontName: String {
    switch self {
    case .arial:
      "Arial"
    case .courier:
      "Courier"
    case .georgia:
      "Georgia"
    case .helvetica:
      "Helvetica"
    case .timesNewRoman:
      "Times New Roman"
    case .verdana:
      "Verdana"
    case .system:
      "System"
    }
  }
}
