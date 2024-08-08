//
//  BannerAdView.swift
//  BlockNotes
//
//  Created by Kei on 2024/08/08.
//

import SwiftUI
import GoogleMobileAds

public struct BannerAdView: UIViewRepresentable {
  var adUnitID: String {
    #if DEBUG
    return "ca-app-pub-3940256099942544/2934735716" // テスト用広告ユニットID
    #else
    return "ca-app-pub-6087556183712349/8521002432"
    #endif
  }
  
  /*
   var adUnitID: String {
           #if DEBUG
           return "ca-app-pub-3940256099942544/2934735716" // テスト用広告ユニットID
           #else
           return "your-real-ad-unit-id" // 本番用広告ユニットID
           #endif
       }
   */

  public init() {
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
