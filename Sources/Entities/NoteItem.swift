//
//  NoteItem.swift
//  
//
//  Created by Kei on 2024/07/13.
//

import Foundation
import SwiftUI

public struct NoteItem: Equatable, Identifiable {
  public let id = UUID()
  public let title: String
  public let content: String
  public let themeColor: Color
  public let systemIconName: String

  public init(title: String, content: String, themeColor: Color, systemIconName: String) {
    self.title = title
    self.content = content
    self.themeColor = themeColor
    self.systemIconName = systemIconName
  }
}
