//
//  UIColor+Extension.swift
//  
//
//  Created by Kei on 2024/07/21.
//

import UIKit

extension UIColor {
    public func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format: "%06X", rgb)
    }

  public func textColor() -> UIColor {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0

    self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

    let luminance = 0.2126 * red + 0.7152 * green + 0.0722 * blue

    return luminance > 0.5 ? .black : .white
  }
}
