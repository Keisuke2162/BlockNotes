//
//  ColorPickerView.swift
//
//
//  Created by Kei on 2024/08/11.
//

import Foundation
import SwiftUI

struct ColorSlider: View {
  @Binding var hue: Double
  let height: CGFloat

  init(hue: Binding<Double>, height: CGFloat) {
    self._hue = hue
    self.height = height
  }

  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        LinearGradient(gradient: Gradient(colors: (0..<100).map { Color(hue: Double($0) / 100.0, saturation: 1, brightness: 1)}), startPoint: .leading, endPoint: .trailing)
          .overlay(
            RoundedRectangle(cornerRadius: height / 2)
              .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 4)
          )
        
        ZStack(alignment: .center) {
          Circle()
            .fill(.white)
            .frame(width: height, height: height)
          Circle()
            .fill(Color(hue: hue, saturation: 1, brightness: 1))
            .frame(width: height - 8, height: height - 8)
        }
        .offset(x: height / 2)
        .position(x: CGFloat(self.hue) * (geometry.size.width - height), y: geometry.size.height / 2)
        .gesture(
          DragGesture()
            .onChanged { gesture in
              let newValue = gesture.location.x / geometry.size.width
              self.hue = min(max(Double(newValue), 0), 1)
            }
        )
      }
    }
  }
}

public struct SaturationSlider: View {
  @Binding var hue: Double
  @Binding var saturation: Double
  let height: CGFloat

  init(hue: Binding<Double>, saturation: Binding<Double>, height: CGFloat) {
    self._hue = hue
    self._saturation = saturation
    self.height = height
  }

  public var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        LinearGradient(gradient: Gradient(colors: (0..<100).map { Color(hue: hue, saturation: Double($0) / 100.0, brightness: 1)}), startPoint: .leading, endPoint: .trailing)
          .overlay(
            RoundedRectangle(cornerRadius: height / 2)
              .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 4)
          )
        
        ZStack(alignment: .center) {
          Circle()
            .fill(.white)
            .frame(width: height, height: height)
          Circle()
            .fill(Color(hue: hue, saturation: saturation, brightness: 1))
            .frame(width: height - 8, height: height - 8)
        }
        .offset(x: height / 2)
        .position(x: CGFloat(self.saturation) * (geometry.size.width - height), y: geometry.size.height / 2)
        .gesture(
          DragGesture()
            .onChanged { gesture in
              let newValue = gesture.location.x / geometry.size.width
              self.saturation = min(max(Double(newValue), 0), 1)
            }
        )
      }
    }
  }
}

public struct ColorPickerView: View {
  // @Binding var selectedColor: Color
  @Binding private var hue: Double
  @Binding private var saturation: Double
  private let sliderHeight: CGFloat = 32

  public init(hue: Binding<Double>, saturation: Binding<Double>) {
    self._hue = hue
    self._saturation = saturation
  }

  public var body: some View {
    VStack(spacing: 20) {
      // 選択された色の表示
      RoundedRectangle(cornerRadius: 20)
        .fill(Color(hue: hue, saturation: saturation, brightness: 1))
        .frame(height: 100)
        .overlay(
          RoundedRectangle(cornerRadius: 20)
            .stroke(Color.white, lineWidth: 4)
        )
        .shadow(radius: 5)
      // 色相スライダー
      ColorSlider(hue: $hue, height: sliderHeight)
        .frame(height: sliderHeight)
        .clipShape(.rect(cornerRadius: sliderHeight / 2))
        .accentColor(.gray)
//        .onChange(of: hue) {
//          updateColor()
//        }
      // 彩度スライダー
      SaturationSlider(hue: $hue, saturation: $saturation, height: sliderHeight)
        .frame(height: sliderHeight)
        .clipShape(.rect(cornerRadius: sliderHeight / 2))
//        .onChange(of: saturation) {
//          updateColor()
//        }
        
    }
    .padding()
    .onAppear {
//      let (h, s, _) = UIColor(hue: hue, saturation: saturation, brightness: 1, alpha: 1).hsb
//      hue = h
//      saturation = s
    }
  }

//  private func updateColor() {
//    selectedColor = Color(hue: hue, saturation: saturation, brightness: 1)
//  }
}

extension UIColor {
  var hsb: (hue: Double, saturation: Double, brigntness: Double) {
    var h: CGFloat = 0
    var s: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
    return (Double(h), Double(s), Double(b))
  }
}
