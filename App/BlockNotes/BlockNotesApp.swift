//
//  BlockNotesApp.swift
//  BlockNotes
//
//  Created by Kei on 2024/07/13.
//

import Entities
import GoogleMobileAds
import InAppPurchaseFeature
import RootFeature
import SettingsFeature
import SwiftData
import SwiftUI

@main
struct BlockNotesApp: App {
  @StateObject private var settings = AppSettingsService()
  @StateObject private var purchaseManager = InAppPurchaseManager()
  @UIApplicationDelegateAdaptor (AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
          RootView()
            .environmentObject(settings)
            .environmentObject(purchaseManager)
        }
        .modelContainer(for: NoteItem.self)
    }
}

final class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    GADMobileAds.sharedInstance().start(completionHandler: nil)
    return true
  }
}
