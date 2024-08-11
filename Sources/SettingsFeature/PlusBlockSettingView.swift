//
//  PlusBlockSettingView.swift
//
//
//  Created by Kei on 2024/07/28.
//

import CustomViewFeature
import Extensions
import SwiftUI

public struct PlusBlockSettingView: View {
  @EnvironmentObject var settings: AppSettingsService
  @State private var hue: Double = 0
  @State private var saturation: Double = 1
  @State private var brightness: Double = 1

  private var selectedColor: Color {
    Color(hue: hue, saturation: saturation, brightness: brightness)
  }

  public init() {
  }
  
  public var body: some View {
    VStack(alignment: .center, spacing: 32) {
      // アイコン
      Button {
      } label: {
        Image(systemName: "plus")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(24)
          .foregroundStyle(selectedColor.foregroundColor)
      }
      .frame(width: 80, height: 80)
      .background(selectedColor)
      .clipShape(.rect(cornerRadius: 8))
      .padding(.trailing, 32)

      // カラーピッカー
      ColorPickerView(hue: $hue, saturation: $saturation, brightness: $brightness)
    }
    .padding(.horizontal, 32)
    .onAppear {
      self.hue = settings.plusBlockHue
      self.saturation = settings.plusBlockSaturation
      self.brightness = settings.plusBlockBrightness
    }
    .onDisappear {
      settings.plusBlockHue = hue
      settings.plusBlockSaturation = saturation
      settings.plusBlockBrightness = brightness
    }
  }
}
