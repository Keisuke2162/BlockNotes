//
//  NoteItem.swift
//  
//
//  Created by Kei on 2024/07/13.
//

import Foundation
import SwiftUI

public struct NoteItem {
  let title: String
  let content: String
  let symbol: String

  public init(title: String, content: String, symbol: String) {
    self.title = title
    self.content = content
    self.symbol = symbol
  }
}
