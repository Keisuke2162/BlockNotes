//
//  EditIconView.swift
//
//
//  Created by Kei on 2024/07/16.
//

import Entities
import SwiftUI

public struct EditIconView: View {
  @Binding public var noteItem: NoteItem
  
  public init(noteItem: Binding<NoteItem>) {
    self._noteItem = noteItem
  }

  public var body: some View {
    Text("test")
  }
}
