//
//  RootView.swift
//  
//
//  Created by Kei on 2024/07/14.
//

import Entities
import HomeFeature
import SettingsFeature
import SwiftUI

public struct RootView: View {
  @EnvironmentObject var settings: AppSettingsService

  public init() {}

  // TODO: ダークモード対応
  public var body: some View {
    HomeView()
  }
}
