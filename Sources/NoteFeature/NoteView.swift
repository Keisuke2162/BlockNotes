//
//  NoteView.swift
//
//
//  Created by Kei on 2024/07/15.
//

import Entities
import SwiftUI

public struct NoteView: View {
  @Bindable public var noteItem: NoteItem
  @FocusState private var focusedField: Field?
  @State private var isShowIconEditView = false
  let isEditNote: Bool
  let onSave: (NoteItem) -> Void
  let onCancel: () -> Void
  let onDelete: (NoteItem) -> Void
  
  
  public enum Field: Hashable {
    case title, content
  }
  
  public init(noteItem: NoteItem,
              isEditNote: Bool,
              onSave: @escaping (NoteItem) -> Void,
              onCancel: @escaping () -> Void,
              onDelete: @escaping (NoteItem) -> Void) {
    self.noteItem = noteItem
    self.isEditNote = isEditNote
    self.onSave = onSave
    self.onCancel = onCancel
    self.onDelete = onDelete
  }

  public var body: some View {
    NavigationStack {
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

          // アイコン
          Button {
            // TODO: アイコン設定ページに飛ばす
            isShowIconEditView = true
          } label: {
            Image(systemName: noteItem.systemIconName)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .foregroundStyle(Color(uiColor: noteItem.uiColor.textColor()))
              .padding(12)
          }
          .frame(width: 48, height: 48)
          .background(noteItem.color)
          .clipShape(.rect(cornerRadius: 8))
          .padding(.horizontal, 32)
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

        if isEditNote {
          HStack {
            Spacer()
            Button {
              onDelete(noteItem)
            } label: {
              Image(systemName: "trash")
            }
            .frame(width: 40, height: 40)
            .foregroundStyle(Color.red)
          }
          .padding(.horizontal, 32)
          .padding(.bottom, 16)
        }
      }
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button {
            onCancel()
          } label: {
            Text("Cancel")
          }
        }
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            onSave(noteItem)
          } label: {
            Text("Save")
          }
          .disabled(noteItem.title.isEmpty && noteItem.content.isEmpty)
        }
      }
    }
    .sheet(isPresented: $isShowIconEditView) {
      EditIconView(noteItem: noteItem)
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
