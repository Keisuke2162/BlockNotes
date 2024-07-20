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
  public var redComponent: Double
  public var greenComponent: Double
  public var blueComponent: Double
  public var systemIconName: String

  public var color: Color {
    Color(uiColor: UIColor(red: CGFloat(redComponent), green: CGFloat(greenComponent), blue: CGFloat(blueComponent), alpha: 1))
  }

  public init(title: String, content: String, redComponent: Double, greenComponent: Double, blueComponent: Double, systemIconName: String) {
    self.title = title
    self.content = content
    self.redComponent = redComponent
    self.greenComponent = greenComponent
    self.blueComponent = blueComponent
    self.systemIconName = systemIconName
  }
}
//
//@Observable
//public class NoteItemStore {
//  public var notes: [NoteItem] = []
//
//  public init() {
//    // TODO: 仮
//    self.notes = [
//      .init(title: "", content: "", noteColor: .blue, systemIconName: "plus", type: .add),
//      .init(title: "", content: "", noteColor: .yellow, systemIconName: "gearshape", type: .setting),
//      .init(title: "Title1", content: "Content1", noteColor: .yellow, systemIconName: "house", type: .note),
//      .init(title: "Title2", content: "Content2", noteColor: .red, systemIconName: "house", type: .note),
//    ]
//  }
//
//  public func addItem(_ item: NoteItem) {
//    notes.append(item)
//  }
//
//  public func deleteItem(_ item: NoteItem) {
//    notes.removeAll(where: { $0.id == item.id })
//  }
//}
