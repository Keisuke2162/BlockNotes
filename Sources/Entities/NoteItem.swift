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
  public var type: NoteType

  public init(title: String, content: String, themeColor: Color, systemIconName: String, type: NoteType) {
    self.title = title
    self.content = content
    self.themeColor = themeColor
    self.systemIconName = systemIconName
    self.type = type
  }

  public enum NoteType {
    case note, add, setting
  }
}

@Observable
public class NoteItemStore {
  public var notes: [NoteItem] = []

  public init() {
    // TODO: 仮
    self.notes = [
      .init(title: "", content: "", themeColor: .indigo, systemIconName: "plus", type: .add),
      .init(title: "", content: "", themeColor: .cyan, systemIconName: "gearshape", type: .setting),
      .init(title: "Title1", content: "Content1", themeColor: .yellow, systemIconName: "house", type: .note),
      .init(title: "Title2", content: "Content2", themeColor: .gray, systemIconName: "house", type: .note),
    ]
  }

  public func addItem(_ item: NoteItem) {
    notes.append(item)
  }

  public func deleteItem(_ item: NoteItem) {
    notes.removeAll(where: { $0.id == item.id })
  }
}
