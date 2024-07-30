//
//  BlockNotesApp.swift
//  BlockNotes
//
//  Created by Kei on 2024/07/13.
//

import Entities
import RootFeature
import SettingsFeature
import SwiftData
import SwiftUI

@main
struct BlockNotesApp: App {
  @StateObject private var settings = AppSettingsService()

    var body: some Scene {
        WindowGroup {
          RootView()
            .environmentObject(settings)
        }
        .modelContainer(for: NoteItem.self)
    }
}
