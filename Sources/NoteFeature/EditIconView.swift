//
//  EditIconView.swift
//
//
//  Created by Kei on 2024/07/16.
//

import CustomViewFeature
import Entities
import Extensions
import SettingsFeature
import SwiftUI

public struct EditIconView: View {
  @EnvironmentObject var settings: AppSettingsService
  @Environment(\.dismiss) var dismiss
  @Bindable public var noteItem: NoteItem

  @State private var hue: Double = 0
  @State private var saturation: Double = 1
  @State private var brightness: Double = 1
  
  @State private var systemImageString: String = ""

  private var backGroundColor: Color {
    Color(hue: hue, saturation: saturation, brightness: brightness)
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
          Image(systemImageString)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(settings.getBlockImagePadding())
            .foregroundStyle(backGroundColor.foregroundColor)
        }
        .frame(width: settings.getBlockFrame(), height: settings.getBlockFrame())
        .background(backGroundColor)
        .clipShape(.rect(cornerRadius: 8))
        .overlay {
          RoundedRectangle(cornerRadius: 8)
            .stroke(lineWidth: 2)
            .fill(
              settings.isShowBlockBorder ? (settings.isDarkMode ? .white : .black) : .clear
            )
        }
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
