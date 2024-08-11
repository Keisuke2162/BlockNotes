//
//  EditIconView.swift
//
//
//  Created by Kei on 2024/07/16.
//

import CustomViewFeature
import Entities
import Extensions
import SwiftUI

public struct EditIconView: View {
  @Environment(\.dismiss) var dismiss
  @Bindable public var noteItem: NoteItem

  @State private var hue: Double = 0
  @State private var saturation: Double = 1
  @State private var brightness: Double = 1
  
  @State private var systemImageString: String = ""

  private var backGroundColor: Color {
    Color(hue: hue, saturation: saturation, brightness: brightness)
  }
  private var hexColorText: String {
    UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1).toHexString()
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
          Image(systemName: systemImageString)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(20)
            .foregroundStyle(Color(uiColor: UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1).textColor()))
        }
        .frame(width: 80, height: 80)
        .background(backGroundColor)
        .clipShape(.rect(cornerRadius: 8))
        .padding(.trailing, 32)
        // カラーピッカー
        ColorPickerView(hue: $hue, saturation: $saturation, brightness: $brightness)
        // アイコン選択
        SymbolSelectView(selectedSymbol: $systemImageString)
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
            noteItem.hue = hue
            noteItem.saturation = saturation
            noteItem.systemIconName = systemImageString
            dismiss()
          } label: {
            Text("Save")
          }
        }
      }
    }
    .onAppear {
      hue = noteItem.hue
      saturation = noteItem.saturation
      systemImageString =  noteItem.systemIconName
    }
  }
}
