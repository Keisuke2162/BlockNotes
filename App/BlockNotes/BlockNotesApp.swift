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
  let container: ModelContainer

  init() {
    do {
      let scheme = Schema([
        NoteItem.self
      ])
      let modelConfiguration = ModelConfiguration(schema: scheme, isStoredInMemoryOnly: false)
      container = try ModelContainer(for: scheme, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }

  var body: some Scene {
    WindowGroup {
      RootView()
        .environmentObject(settings)
        .environmentObject(purchaseManager)
    }
    .modelContainer(container)
//    .modelContainer(for: container)
  }
}

final class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    GADMobileAds.sharedInstance().start(completionHandler: nil)
    return true
  }
}
