//
//  FontSettingView.swift
//
//
//  Created by Kei on 2024/08/02.
//

import SwiftUI

public struct FontSettingView: View {
  @EnvironmentObject var settings: AppSettingsService
  @State private var selectedFontType: AppFontType = .system

  public init() {
  }

  public var body: some View {
    VStack {
      Text("Sample Text")
        .font(.custom(selectedFontType.fontName, size: 24))
        .padding()
      List {
        ForEach(AppFontType.allCases, id: \.self) { font in
          HStack {
            Text(font.fontName)
            Spacer()
            if font == selectedFontType {
              Image(systemName: "checkmark")
                .foregroundColor(.blue)
            }
          }
          .contentShape(Rectangle())
          .onTapGesture {
            selectedFontType = font
          }
        }
      }
    }
    .onAppear {
      self.selectedFontType = settings.fontType
    }
    .onDisappear {
      settings.fontType = self.selectedFontType
    }
  }
}
