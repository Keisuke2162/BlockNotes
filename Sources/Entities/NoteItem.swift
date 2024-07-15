//
//  NoteItem.swift
//  
//
//  Created by Kei on 2024/07/13.
//

import Foundation
import SwiftUI

@Observable
public class NoteItem: Identifiable {
  public let id = UUID()
  public var title: String
  public var content: String
  public var themeColor: Color
  public var systemIconName: String

  public init(title: String, content: String, themeColor: Color, systemIconName: String) {
    self.title = title
    self.content = content
    self.themeColor = themeColor
    self.systemIconName = systemIconName
  }
}

@Observable
public class NoteItemStore {
  public var notes: [NoteItem] = []

  public func addItem(_ item: NoteItem) {
    notes.append(item)
  }

  public func deleteItem(at offsets: IndexSet) {
    notes.remove(atOffsets: offsets)
  }
}
