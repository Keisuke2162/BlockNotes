//
//  BlockNotesApp.swift
//  BlockNotes
//
//  Created by Kei on 2024/07/13.
//

import Entities
import RootFeature
import SwiftData
import SwiftUI

@main
struct BlockNotesApp: App {
    var body: some Scene {
        WindowGroup {
          RootView()
        }
        .modelContainer(for: NoteItem.self)
    }
}
