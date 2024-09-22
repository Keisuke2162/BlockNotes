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
        let itemSize: CGFloat = 56
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
//      "1.lane",
//      "2.lane",
//      "3.lane",
//      "4.lane",
//      "5.lane",
//      "6.lane",
//      "7.lane",
//      "8.lane",
//      "9.lane",
//      "10.lane",
//      "11.lane",
//      "12.lane",
//      "soccerball",
//      "baseball",
//      "basketball",
//      "football",
//      "tennis.racket",
//      "cricket.ball",
//      "tennisball",
//      "volleyball",
//      "skateboard",
//      "skis",
//      "snowboard",
//      "surfboard",
//      "gym.bag",
//      "trophy",
//      "medal",
//      "peacesign",
//      "globe",
//      "globe.americas",
//      "globe.europe.africa",
//      "globe.asia.australia",
//      "globe.central.south.asia",
//      "sun.min",
//      "sun.max",
//      "sun.horizon",
//      "sun.dust",
//      "sun.haze",
//      "sun.rain",
//      "sun.snow",
//      "moon",
//      "sparkle",
//      "sparkles",
//      "moon.stars",
//      "cloud",
//      "cloud.drizzle",
//      "cloud.rain",
//      "cloud.hail",
//      "cloud.snow",
//      "cloud.bolt",
//      "cloud.bolt.rain",
//      "cloud.sun",
//      "cloud.sun.rain",
//      "cloud.sun.bolt",
//      "cloud.moon.rain",
//      "cloud.moon.bolt",
//      "wind",
//      "wind.snow",
//      "snowflake",
//      "tornado",
//      "tropicalstorm",
//      "flame",
//      "beach.umbrella",
//      "umbrella",
//      "guitars",
//      "airplane",
//      "car",
//      "bolt.car",
//      "car.2",
//      "bus",
//      "tram",
//      "cablecar",
//      "lightrail",
//      "ferry",
//      "car.ferry",
//      "sailboat",
//      "truck.box",
//      "bicycle",
//      "scooter",
//      "stroller",
//      "car.side",
//      "hare",
//      "tortoise",
//      "dog",
//      "cat",
//      "bird",
//      "fish",
//      "pawprint",
//      "teddybear",
//      "laurel.leading",
//      "laurel.trailing",
//      "tree",
//      "hanger",
//      "crown",
//      "tshirt",
//      "shoe",
//      "shoe.2",
//      "shoeprints.fill",
//      "mustache",
//      "cube",
//      "shippingbox",
//      "alarm",
//      "arcade.stick",
//      "gamecontroller",
//      "arrowkeys",
//      "playstation.logo",
//      "xbox.logo",
//      "swatchpalette",
//      "cup.and.saucer",
//      "mug",
//      "takeoutbag.and.cup.and.straw",
//      "wineglass",
//      "waterbottle",
//      "birthday.cake",
//      "carrot",
//      "fork.knife",
//      "burst",
//      "waveform.path.ecg",
//      "scalemass",
//      "globe.desk",
//      "gift",
//      "binoculars",
//      "apple.logo"
  ]
}
