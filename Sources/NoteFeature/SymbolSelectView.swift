//
//  SymbolSelectView.swift
//  
//
//  Created by Kei on 2024/07/22.
//

import Entities
import Extensions
import SettingsFeature
import SwiftUI

struct SymbolSelectView: View {
  @EnvironmentObject var settings: AppSettingsService
  let symbols: [String] = Symbols().stringArray

  @Binding var selectedSymbol: String

  init(selectedSymbol: Binding<String>) {
    self._selectedSymbol = selectedSymbol
  }

  var body: some View {
    GeometryReader { geometry in
      ScrollView(.horizontal, showsIndicators: false) {
        let itemSize: CGFloat = 60
        let spacing: CGFloat = 8
        let columns = Int(geometry.size.height / (itemSize + spacing))
        
        LazyHGrid(rows: Array(repeating: GridItem(.fixed(itemSize), spacing: spacing), count: columns), spacing: spacing) {
          ForEach(symbols, id: \.self) { symbol in
            Button {
              self.selectedSymbol = symbol
            } label: {
              Image(symbol)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(settings.isDarkMode ? .white : .black)
                .padding(16)
            }
            .frame(width: itemSize, height: itemSize)
            .overlay {
              RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 2)
                .fill(
                  symbol == selectedSymbol ? (settings.isDarkMode ? .white : .black) : .clear
                )
            }
          }
        }
      }
      .padding(.bottom, 48)
      .scrollIndicators(.visible)
    }
  }
}

class Symbols {
  let stringArray: [String] = [
      "pencil",
      "pencil.slash",
      "pencil.line",
      "square.and.pencil",
      "folder",
      "paperplane",
      "list.bullet.clipboard",
      "list.clipboard",
      "doc.plaintext",
      "newspaper",
      "figure.american.football",
      "figure.archery",
      "figure.australian.football",
      "figure.badminton",
      "figure.barre",
      "figure.baseball",
      "figure.basketball",
      "figure.bowling",
      "figure.boxing",
      "figure.climbing",
      "figure.cooldown",
      "figure.core.training",
      "figure.cricket",
      "figure.skiing.crosscountry",
      "figure.cross.training",
      "figure.curling",
      "figure.dance",
      "figure.disc.sports",
      "figure.skiing.downhill",
      "figure.elliptical",
      "figure.equestrian.sports",
      "figure.fencing",
      "figure.fishing",
      "figure.flexibility",
      "figure.strengthtraining.functional",
      "figure.golf",
      "figure.gymnastics",
      "figure.hand.cycling",
      "figure.handball",
      "figure.highintensity.intervaltraining",
      "figure.hiking",
      "figure.hockey",
      "figure.hunting",
      "figure.indoor.cycle",
      "figure.jumprope",
      "figure.kickboxing",
      "figure.lacrosse",
      "figure.martial.arts",
      "figure.mind.and.body",
      "figure.mixed.cardio",
      "figure.open.water.swim",
      "figure.outdoor.cycle",
      "figure.pickleball",
      "figure.pilates",
      "figure.play",
      "figure.pool.swim",
      "figure.racquetball",
      "figure.rolling",
      "figure.rower",
      "figure.rugby",
      "figure.sailing",
      "figure.skating",
      "figure.snowboarding",
      "figure.soccer",
      "figure.socialdance",
      "figure.softball",
      "figure.squash",
      "figure.stair.stepper",
      "figure.stairs",
      "figure.step.training",
      "figure.surfing",
      "figure.table.tennis",
      "figure.taichi",
      "figure.tennis",
      "figure.track.and.field",
      "figure.strengthtraining.traditional",
      "figure.volleyball",
      "figure.water.fitness",
      "figure.waterpolo",
      "figure.wrestling",
      "figure.yoga",
      "a.circle",
      "cloud.bolt",
      "r.circle",
      "airplane",
      "cloud.drizzle",
      "rb.button.roundedbottom.horizontal",
      "arrowtriangle.up.circle",
      "dog",
      "sailboat",
      "b.circle",
      "fish",
      "scooter",
      "balloon.2",
      "flag.checkered.2.crossed",
      "soccerball",
      "balloon",
      "flag.checkered",
      "spigot",
      "baseball",
      "football",
      "sun.max",
      "basketball",
      "gamecontroller",
      "tennisball",
      "bicycle",
      "hare",
      "tortoise",
      "bird",
      "l.circle",
      "tram",
      "bolt.car",
      "lb.button.roundedbottom.horizontal",
      "trophy",
      "bolt.square",
      "lightbulb.max",
      "truck.box",
      "camera.macro",
      "lightrail",
      "volleyball",
      "car",
      "moon",
      "x.circle",
      "carrot",
      "party.popper",
      "y.circle",
      "cat",
      "pawprint"
  ]
}
