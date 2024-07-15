//
//  NoteView.swift
//
//
//  Created by Kei on 2024/07/15.
//

import Entities
import SwiftUI

public struct NoteView: View {
  @Binding public var noteItem: NoteItem
  @FocusState private var focusedField: Field?
  
  public enum Field: Hashable {
    case title, content
  }

  public init(noteItem: Binding<NoteItem>) {
    self._noteItem = noteItem
    self.focusedField = .title
  }

  public var body: some View {
    VStack {
      HStack {
        // タイトル入力
        TextField("Title", text: $noteItem.title)
          .font(.title)
          .padding()
          .focused($focusedField, equals: .title)
          .onSubmit {
            focusedField = .content
          }
          .padding(.leading, 4)
        
        //
        Button {
          // TODO: アイコン設定ページに飛ばす
        } label: {
          Image(systemName: noteItem.systemIconName)
            .foregroundStyle(Color.black)
        }
        .frame(width: 48, height: 48)
        .background(noteItem.themeColor)
        .padding(.trailing, 32)

      }
      .padding(.top, 32)
      

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

//#Preview {
//  struct PreviewView: View {
//    @State private var item: NoteItem = .init(title: "Title1", content: "Content1", themeColor: .yellow, systemIconName: "house")
//    
//    var body: some View {
//      NoteView(noteItem: $item)
//    }
//  }
//  return PreviewView()
//}
