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

  public init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
    self.isDarkMode = userDefaults.bool(forKey: "isDarkMode")
    print("テスト \(userDefaults.string(forKey: "blockSizeType") ?? "failed")")
    self.blockSizeType = BlockSizeType(rawValue: userDefaults.string(forKey: "blockSizeType") ?? "medium") ?? .medium
    self.isShowBlockBorder = userDefaults.bool(forKey: "isShowBlockBorder")
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

// Color保存したい時に使う
/*
 extension UserDefaults {
     func setColor(_ color: Color, forKey key: String) {
         let uiColor = UIColor(color)
         self.set(uiColor.encode(), forKey: key)
     }
     
     func color(forKey key: String) -> Color? {
         guard let data = self.data(forKey: key),
               let uiColor = UIColor.decode(data) else { return nil }
         return Color(uiColor)
     }
 }

 extension UIColor {
     func encode() -> Data? {
         try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
     }
     
     static func decode(_ data: Data) -> UIColor? {
         try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
     }
 }
 */
