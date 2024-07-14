//
//  HomeView.swift
//  
//
//  Created by Kei on 2024/07/14.
//

import BlockItemFeature
import CustomView
import Entities
import Foundation
import SwiftUI

public struct HomeView: View {
  @State private var buttons: [UIView] = []
  private var noteItems: [NoteItem] = []

  public init(noteItems: [NoteItem]) {
    self.noteItems = noteItems
  }

  public var body: some View {
    GeometryReader { geometry in
      GravityView(buttons: $buttons)
        .edgesIgnoringSafeArea(.all)
    }
    .background(Color.blue)
    .onAppear {
//      // テスト用のボタンを作成
//      for i in 0..<5 {
//        let button = UIButton(frame: CGRect(x: CGFloat.random(in: 0...300), y: -50, width: 100, height: 44))
//        button.setTitle("Button \(i+1)", for: .normal)
//        button.backgroundColor = .blue
//        buttons.append(button)
//      }
      for item in noteItems {
        let blockItemView = BlockItemView(item: item)
        if let buttonView = UIHostingController(rootView: blockItemView).view {
          buttonView.frame = CGRect(x: 48, y: 48, width: 48, height: 48)
          buttons.append(buttonView)
        }
      }
    }
  }
}
