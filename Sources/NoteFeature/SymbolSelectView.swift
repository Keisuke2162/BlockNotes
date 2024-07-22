//
//  SymbolSelectView.swift
//  
//
//  Created by Kei on 2024/07/22.
//

import Entities
import Extensions
import SwiftUI

struct SymbolSelectView: View {
  let symbols: [String] = Symbols().stringArray

  @Binding var selectedSymbol: String

  init(selectedSymbol: Binding<String>) {
    self._selectedSymbol = selectedSymbol
  }

  var body: some View {
    GeometryReader { geometry in
      ScrollView(.horizontal, showsIndicators: false) {
        let itemSize: CGFloat = 48
        let spacing: CGFloat = 8
        let columns = Int(geometry.size.height / (itemSize + spacing))
        
        LazyHGrid(rows: Array(repeating: GridItem(.fixed(itemSize), spacing: spacing), count: columns), spacing: spacing) {
          ForEach(symbols, id: \.self) { symbol in
            Button {
              self.selectedSymbol = symbol
            } label: {
              Image(systemName: symbol)
                .frame(width: itemSize, height: itemSize)
                .foregroundColor(.black)
            }
          }
        }
      }
      .padding(.bottom, 48)
    }
  }
}

class Symbols {
  let stringArray: [String] = [
      "pencil.and.list.clipboard",
      "doc.questionmark",
      "book.pages",
      "calendar.badge.checkmark",
      "figure",
      "gym.bag",
      "sun.snow",
      "moonrise",
      "play.house",
      "storefront",
      "fireworks",
      "dot.scope.laptopcomputer",
      "visionpro",
      "watch.analog",
      "beats.studiobudsplus.chargingcase",
      "beats.studiobudsplus",
      "truck.pickup.side",
      "book.and.wrench",
      "horn",
      "dog",
      "cat",
      "shoe",
      "arcade.stick.console",
      "arrowkeys",
      "chart.bar.xaxis.ascending",
      "folder",
      "doc.text",
      "list.bullet.clipboard",
      "list.clipboard",
      "doc.text.below.ecg",
      "doc.questionmark",
      "sun.max.fill",
      "sun.haze.fill",
      "sun.rain.fill",
      "moon.zzz.fill",
      "sparkle",
      "sparkles",
      "moon.stars.fill",
      "cloud.drizzle.fill",
      "cloud.bolt.fill",
      "snowflake",
      "tornado",
      "suit.heart",
      "suit.club",
      "suit.diamond",
      "suit.spade",
      "star",
      "flag",
      "flag.checkered.circle.fill",
      "bolt",
      "ellipsis.bubble.fill",
      "video",
      "wifi",
      "airplane",
      "car",
      "alarm",
      "fork.knife",
      "gift",
      "hourglass"
  ]
}
