//
//  File.swift
//  
//
//  Created by Kei on 2024/07/29.
//

import Extensions
import SwiftUI

public struct SettingBlockSettingView: View {
  @EnvironmentObject var settings: AppSettingsService
  @State private var redComponent: Double = 0
  @State private var greenComponent: Double = 0
  @State private var blueComponent: Double = 0

  private var backGroundColor: Color {
    Color(uiColor: UIColor(red: redComponent, green: greenComponent, blue: blueComponent, alpha: 1))
  }
  private var hexColorText: String {
    UIColor(red: redComponent, green: greenComponent, blue: blueComponent, alpha: 1).toHexString()
  }

  public init() {
  }
  
  public var body: some View {
    VStack(alignment: .center, spacing: 32) {
      // アイコン
      Button {
      } label: {
        Image(systemName: "gearshape")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(24)
          .foregroundStyle(Color(uiColor: UIColor(red: redComponent, green: greenComponent, blue: blueComponent, alpha: 1).textColor()))
      }
      .frame(width: 80, height: 80)
      .background(backGroundColor)
      .clipShape(.rect(cornerRadius: 8))
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
    }
    .padding(.horizontal, 32)
    .onAppear {
      self.redComponent = settings.settingBlockRedComponent
      self.greenComponent = settings.settingBlockGreenComponent
      self.blueComponent = settings.settingBlockBlueComponent
    }
    .onDisappear {
      settings.settingBlockRedComponent = redComponent
      settings.settingBlockGreenComponent = greenComponent
      settings.settingBlockBlueComponent = blueComponent
    }
  }
}
