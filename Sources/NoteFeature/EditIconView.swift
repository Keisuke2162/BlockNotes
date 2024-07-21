//
//  EditIconView.swift
//
//
//  Created by Kei on 2024/07/16.
//

import Entities
import Extensions
import SwiftUI

public struct EditIconView: View {
  @Environment(\.dismiss) var dismiss
  @Bindable public var noteItem: NoteItem

  @State private var redComponent: Double = 0
  @State private var greenComponent: Double = 0
  @State private var blueComponent: Double = 0
  private var backGroundColor: Color {
    Color(uiColor: UIColor(red: redComponent, green: greenComponent, blue: blueComponent, alpha: 1))
  }
  private var hexColorText: String {
    UIColor(red: redComponent, green: greenComponent, blue: blueComponent, alpha: 1).toHexString()
  }

  public init(noteItem: NoteItem) {
    self.noteItem = noteItem
  }

  public var body: some View {
    NavigationStack {
      VStack(alignment: .center, spacing: 32) {
        Spacer()
        // アイコン
        Button {
        } label: {
          Image(systemName: noteItem.systemIconName)
            .foregroundStyle(Color.black)
        }
        .frame(width: 80, height: 80)
        .background(backGroundColor)
        .padding(.trailing, 32)
        
        // Red
        HStack {
          Text("Red")
            .frame(width: 48, alignment: .trailing)
          Slider(value: $redComponent, in: 0...1) { _ in
          }
        }
        
        // Green
        HStack {
          Text("Green")
            .frame(width: 48, alignment: .trailing)
          Slider(value: $greenComponent, in: 0...1) { _ in
          }
        }
        
        // Blue
        HStack {
          Text("Blue")
            .frame(width: 48, alignment: .trailing)
          Slider(value: $blueComponent, in: 0...1) { _ in
          }
        }
        
        // Hex
        HStack {
          Spacer()
          Text("#\(hexColorText)")
        }

        Spacer()
      }
      .padding(.horizontal, 32)
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
            noteItem.redComponent = redComponent
            noteItem.greenComponent = greenComponent
            noteItem.blueComponent = blueComponent
            dismiss()
          } label: {
            Text("Save")
          }
          .disabled(noteItem.title.isEmpty && noteItem.content.isEmpty)
        }
      }
    }
    .onAppear {
      redComponent = noteItem.redComponent
      greenComponent = noteItem.greenComponent
      blueComponent = noteItem.blueComponent
    }
  }
}
