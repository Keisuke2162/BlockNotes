//
//  NoteView.swift
//
//
//  Created by Kei on 2024/07/15.
//

import Entities
import SwiftUI

public struct NoteView: View {
  @Binding var noteItem: NoteItem
  @FocusState private var focusedField: Field?
  
  enum Field: Hashable {
    case title, content
  }

  public init(noteItem: NoteItem) {
    self.noteItem = noteItem
  }
  
  public var body: some View {
    VStack {
      // タイトル入力
      TextField("Title", text: $noteItem.title)
        .font(.title)
        .padding()
        .focused($focusedField, equals: .title)
        .onSubmit {
          focusedField = .content
        }
        .padding(.leading, 4)

      // 本文入力
      ZStack(alignment: .topLeading) {
        TextEditor(text:$noteItem.content)
          .padding()
          .focused($focusedField, equals: .content)
        if noteItem.content.isEmpty {
          Text("Content")
            .font(.title3)
            .foregroundStyle(Color.gray.opacity(0.8))
            .padding(24)
        }
      }
    }
  }
}

#Preview {
  let item: NoteItem = .init(title: "Title1", content: "Content1", themeColor: .yellow, systemIconName: "house")
  NoteView(noteItem: item)
}
