//
//  NoteView.swift
//
//
//  Created by Kei on 2024/07/15.
//

import Entities
import SettingsFeature
import SwiftUI

public struct NoteView: View {
  @EnvironmentObject var settings: AppSettingsService
  // @State public var noteItem: NoteItem
  
  @State private var editedItem: NoteItem
  
  
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
    // self.noteItem = noteItem
    self._editedItem = State(initialValue: noteItem)
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
          TextField("Title", text: $editedItem.title)
            .font(.custom(settings.fontType.rawValue, size: 24).bold())
            .padding()
            .focused($focusedField, equals: .title)
            .onSubmit {
              focusedField = .content
            }
            .padding(.leading, 4)

          // アイコン
          Button {
            isShowIconEditView = true
          } label: {
            Image(systemName: editedItem.systemIconName)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .foregroundStyle(editedItem.color.foregroundColor)
              .padding(12)
          }
          .frame(width: 48, height: 48)
          .background(editedItem.color)
          .clipShape(.rect(cornerRadius: 8))
          .padding(.horizontal, 32)
        }
        .padding(.top, 32)

        // 本文入力
        ZStack(alignment: .topLeading) {
          TextEditor(text:$editedItem.content)
            .padding()
            .font(.custom(settings.fontType.rawValue, size: 16))
            .focused($focusedField, equals: .content)
          if editedItem.content.isEmpty {
            Text("Content")
              .font(.custom(settings.fontType.rawValue, size: 16).italic())
              .foregroundStyle(Color.gray.opacity(0.6))
              .padding(24)
              .padding(.leading, -2)
          }
        }

        if isEditNote {
          HStack {
            Spacer()
            Button {
              // TODO: 削除確認アラートを表示
              onDelete(editedItem)
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
            // TODO: 保存されませんアラートを表示（表示しないオプション付き）
            onCancel()
          } label: {
            Text("Cancel")
          }
        }
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            onSave(editedItem)
          } label: {
            Text("Save")
          }
        }
      }
    }
    .sheet(isPresented: $isShowIconEditView) {
      EditIconView(noteItem: editedItem)
    }
    .onAppear {
      if !isEditNote {
        focusedField = .title
      }
    }
  }
}
