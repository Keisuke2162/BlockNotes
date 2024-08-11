//
//  NoteItem.swift
//  
//
//  Created by Kei on 2024/07/13.
//

import Foundation
import SwiftUI
import SwiftData
import UIKit

@Model
public class NoteItem: Identifiable {
  public let id = UUID()
  public var title: String
  public var content: String
  
  public var hue: Double
  public var saturation: Double
  
  public var systemIconName: String
  public var blockTypeValue: String

  public var uiColor: UIColor {
    UIColor(hue: CGFloat(hue), saturation: CGFloat(saturation), brightness: 1, alpha: 1)
  }

  public var color: Color {
    Color(hue: hue, saturation: saturation, brightness: 1)
  }

  public var blockType: BlockType {
    get {
      BlockType(rawValue: blockTypeValue) ?? .other
    }
    set {
      blockTypeValue = newValue.rawValue
    }
  }

  public init(title: String, content: String, hue: Double, saturation: Double, systemIconName: String, blockType: BlockType) {
    self.title = title
    self.content = content
    self.hue = hue
    self.saturation = saturation
    self.systemIconName = systemIconName
    self.blockTypeValue = blockType.rawValue
  }
}

public enum BlockType: String, CaseIterable {
  case note
  case add
  case setting
  case other
}
