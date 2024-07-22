//
//  AppSettingsService.swift
//  
//
//  Created by Kei on 2024/07/23.
//

import SwiftUI

class AppSettingsService: ObservableObject {
  // HomeView
  @Published var isDarkMode: Bool
  @Published var blockFrame: CGFloat
  // NoteView
//  @Published var fontSize: CGFloat
//  // AddIcon
//  @Published var addIconRedComponent: CGFloat
//  @Published var addIconGreenComponent: CGFloat
//  @Published var addIconBlueComponent: CGFloat
//  // SettingIcon
//  @Published var settingIconRedComponent: CGFloat
//  @Published var settingIconGreenComponent: CGFloat
//  @Published var settingIconBlueComponent: CGFloat

  private var userDefaults: UserDefaults

  init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
    self.isDarkMode = userDefaults.bool(forKey: "isDarkMode")
    self.blockFrame = userDefaults.object(forKey: "blockFrame") as? CGFloat ?? 48
  }

  func saveSettings() {
    userDefaults.set(isDarkMode, forKey: "isDarkMode")
    userDefaults.set(blockFrame, forKey: "blockFrame")
  }
}
