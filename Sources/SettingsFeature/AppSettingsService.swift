//
//  AppSettingsService.swift
//  
//
//  Created by Kei on 2024/07/23.
//

import SwiftUI

public class AppSettingsService: ObservableObject {
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
  @Published public var plusBlockRedComponent: Double {
    didSet {
      userDefaults.set(plusBlockRedComponent, forKey: "plusBlockRedComponent")
    }
  }
  @Published public var plusBlockGreenComponent: Double {
    didSet {
      userDefaults.set(plusBlockGreenComponent, forKey: "plusBlockGreenComponent")
    }
  }
  @Published public var plusBlockBlueComponent: Double {
    didSet {
      userDefaults.set(plusBlockBlueComponent, forKey: "plusBlockBlueComponent")
    }
  }
  
  // SettingBlockColor
  @Published public var settingBlockRedComponent: Double {
    didSet {
      userDefaults.set(settingBlockRedComponent, forKey: "settingBlockRedComponent")
    }
  }
  @Published public var settingBlockGreenComponent: Double {
    didSet {
      userDefaults.set(settingBlockGreenComponent, forKey: "settingBlockGreenComponent")
    }
  }
  @Published public var settingBlockBlueComponent: Double {
    didSet {
      userDefaults.set(settingBlockBlueComponent, forKey: "settingBlockBlueComponent")
    }
  }

  private var userDefaults: UserDefaults

  public init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
    self.isDarkMode = userDefaults.bool(forKey: "isDarkMode")
    self.blockSizeType = BlockSizeType(rawValue: userDefaults.string(forKey: "blockSizeType") ?? "medium") ?? .medium
    self.isShowBlockBorder = userDefaults.bool(forKey: "isShowBlockBorder")
    // PlusBlockColor
    self.plusBlockRedComponent = userDefaults.object(forKey: "plusBlockRedComponent") as? Double ?? 0
    self.plusBlockGreenComponent = userDefaults.object(forKey: "plusBlockGreenComponent") as? Double ?? 0
    self.plusBlockBlueComponent = userDefaults.object(forKey: "plusBlockBlueComponent") as? Double ?? 0
    // SettingBlockColor
    self.settingBlockRedComponent = userDefaults.object(forKey: "settingBlockRedComponent") as? Double ?? 0
    self.settingBlockGreenComponent = userDefaults.object(forKey: "settingBlockGreenComponent") as? Double ?? 0
    self.settingBlockBlueComponent = userDefaults.object(forKey: "settingBlockBlueComponent") as? Double ?? 0
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
}
