//
//  NoteItem.swift
//  
//
//  Created by Kei on 2024/07/13.
//

import Foundation
import SwiftUI
import SwiftData

@Model
public class NoteItem: Identifiable {
  public let id = UUID()
  public var title: String
  public var content: String
  public var noteColor: NoteColor
  public var systemIconName: String
  public var type: NoteType

  public init(title: String, content: String, noteColor: NoteColor, systemIconName: String, type: NoteType) {
    self.title = title
    self.content = content
    self.noteColor = noteColor
    self.systemIconName = systemIconName
    self.type = type
  }

  public enum NoteType: Codable {
    case note, add, setting
  }

  public enum NoteColor: Codable {
    case black
    case blue
    case red
    case yellow
  
    public var color: Color {
      switch self {
      case .black:
          .black
      case .blue:
          .blue
      case .red:
          .red
      case .yellow:
          .yellow
      }
    }
  }
}

@Observable
public class NoteItemStore {
  public var notes: [NoteItem] = []

  public init() {
    // TODO: 仮
    self.notes = [
      .init(title: "", content: "", noteColor: .blue, systemIconName: "plus", type: .add),
      .init(title: "", content: "", noteColor: .yellow, systemIconName: "gearshape", type: .setting),
      .init(title: "Title1", content: "Content1", noteColor: .yellow, systemIconName: "house", type: .note),
      .init(title: "Title2", content: "Content2", noteColor: .red, systemIconName: "house", type: .note),
    ]
  }

  public func addItem(_ item: NoteItem) {
    notes.append(item)
  }

  public func deleteItem(_ item: NoteItem) {
    notes.removeAll(where: { $0.id == item.id })
  }
}
