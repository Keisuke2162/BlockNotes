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
  public var redComponent: Double
  public var greenComponent: Double
  public var blueComponent: Double
  public var systemIconName: String
  public var blockTypeValue: String

  public var uiColor: UIColor {
    UIColor(red: CGFloat(redComponent), green: CGFloat(greenComponent), blue: CGFloat(blueComponent), alpha: 1)
  }

  public var color: Color {
    Color(uiColor: uiColor)
  }

  public var blockType: BlockType {
    get {
      BlockType(rawValue: blockTypeValue) ?? .other
    }
    set {
      blockTypeValue = newValue.rawValue
    }
  }

  public init(title: String, content: String, redComponent: Double, greenComponent: Double, blueComponent: Double, systemIconName: String, blockType: BlockType) {
    self.title = title
    self.content = content
    self.redComponent = redComponent
    self.greenComponent = greenComponent
    self.blueComponent = blueComponent
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
