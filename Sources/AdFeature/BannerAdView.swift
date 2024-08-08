//
//  BannerAdView.swift
//  BlockNotes
//
//  Created by Kei on 2024/08/08.
//

import SwiftUI
import GoogleMobileAds

public struct BannerAdView: UIViewRepresentable {
  var adUnitID: String

  public init(adUnitID: String) {
    self.adUnitID = adUnitID
  }

  public func makeUIView(context: Context) -> GADBannerView {
    let banner = GADBannerView(adSize: GADAdSizeBanner)
    banner.adUnitID = adUnitID
    let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    banner.rootViewController = windowsScene?.windows.first?.rootViewController
    banner.load(GADRequest())
    return banner
  }

  public func updateUIView(_ uiView: GADBannerView, context: Context) {
  }
}
