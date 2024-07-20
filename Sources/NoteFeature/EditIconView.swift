//
//  EditIconView.swift
//
//
//  Created by Kei on 2024/07/16.
//

import Entities
import SwiftUI

public struct EditIconView: View {
  @Environment(\.dismiss) var dismiss
  @Bindable public var noteItem: NoteItem

  public init(noteItem: NoteItem) {
    self.noteItem = noteItem
  }

  public var body: some View {
    NavigationStack {
      VStack {
        Text(noteItem.title)
      }
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button {
            dismiss()
          } label: {
            Text("Cancel")
          }
        }
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            dismiss()
          } label: {
            Text("Save")
          }
          .disabled(noteItem.title.isEmpty && noteItem.content.isEmpty)
        }
      }
    }
  }
}
