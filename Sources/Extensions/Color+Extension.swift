//
//  Color+Extension.swift
//  BlockNotes
//
//  Created by Kei on 2024/08/12.
//

import SwiftUI
import UIKit

extension Color {
  public var foregroundColor: Color {
    let uiColor = UIColor(self)
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
  
    let luminance = 0.2126 * red + 0.7152 * green + 0.0722 * blue

    return luminance > 0.5 ? .black : .white
  }
}
