//
//  UIColor+Extension.swift
//  
//
//  Created by Kei on 2024/07/21.
//

import UIKit

extension UIColor {
  // カラーコード作成メソッド。使ってないけど一応残しとく
  public func toHexString() -> String {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    
    getRed(&r, green: &g, blue: &b, alpha: &a)
    let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
    return String(format: "%06X", rgb)
  }

  var hsb: (hue: Double, saturation: Double, brightness: Double) {
    var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
    return (Double(h), Double(s), Double(b))
  }
}
