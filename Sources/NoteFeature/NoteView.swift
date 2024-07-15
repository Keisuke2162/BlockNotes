//
//  NoteView.swift
//
//
//  Created by Kei on 2024/07/15.
//

import Entities
import SwiftUI

public struct NoteView: View {
  @State var noteItem: NoteItem

  public init(noteItem: NoteItem) {
    self.noteItem = noteItem
  }
  
  public var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

//#Preview {
//  NoteView()
//}
