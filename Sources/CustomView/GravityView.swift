//
//  GravityView.swift
//  
//
//  Created by Kei on 2024/07/14.
//

import BlockItemFeature
import Entities
import SwiftUI
import UIKit

public struct GravityView: UIViewRepresentable {
  @Binding var noteItemViews: [UIHostingController<BlockItemView>]

  public init(noteItemViews: Binding<[UIHostingController<BlockItemView>]>) {
    self._noteItemViews = noteItemViews
  }

  public func makeUIView(context: Context) -> UIView {
    let containerView = UIView()
    var buttonViews: [UIView] = []

    for item in noteItemViews {
      containerView.addSubview(item.view)
      buttonViews.append(item.view)
    }
    let animator = UIDynamicAnimator(referenceView: containerView)
    let gravity = UIGravityBehavior(items: buttonViews)
    animator.addBehavior(gravity)
    
    return containerView
  }
  
  public func updateUIView(_ uiView: UIView, context: Context) {
//    let buttons = uiView.subviews
//    print("テスト　\(buttons)")
//    let animator = UIDynamicAnimator(referenceView: uiView)
//    let gravity = UIGravityBehavior(items: buttons)
//    animator.addBehavior(gravity)
    context.coordinator.updateGravity(noteItemViews, in: uiView)
  }

  public func makeCoordinator() -> Coordinator {
    Coordinator(parent: self)
  }
  
  public class Coordinator: NSObject {
    var parent: GravityView
    var animator: UIDynamicAnimator?

    init(parent: GravityView) {
      self.parent = parent
    }

    func updateGravity(_ items: [UIHostingController<BlockItemView>], in view: UIView) {
      view.subviews.forEach { $0.removeFromSuperview() }
      
      for item in items {
        view.addSubview(item.view)
      }

      if let animator {
        animator.removeAllBehaviors()

        let animator = UIDynamicAnimator(referenceView: view)
        let gravity = UIGravityBehavior(items: items.map { $0.view })
        animator.addBehavior(gravity)
        
      }
    }
  }
}

//public struct GravityView: UIViewRepresentable {
//  let items: [NoteItem]
//
//  public init(items: [NoteItem]) {
//    self.items = items
//  }
//  
//  public func makeUIView(context: Context) -> UIView {
//    let containerView = UIView()
//    var buttonViews: [UIView] = []
//    
//    for item in items {
//      let buttonItemView = BlockItemView(store: .init(initialState: BlockItem.State(item: item), reducer: {
//        BlockItem()
//      }))
//      let buttonView = UIHostingController(rootView: buttonItemView)
//      buttonView.view.frame = CGRect(x: 48, y: 0, width: 48, height: 48)
//      containerView.addSubview(buttonView.view)
//      buttonViews.append(buttonView.view)
//    }
//
//    print("テスト \(buttonViews)")
//    let animator = UIDynamicAnimator(referenceView: containerView)
//    let gravity = UIGravityBehavior(items: buttonViews)
////    gravity.gravityDirection = .init(dx: 2.0, dy: 2.0)
////    gravity.magnitude = 1.0
//    animator.addBehavior(gravity)
//    
//
//    return containerView
//  }
//
//  public func updateUIView(_ uiView: UIView, context: Context) {
//    print("テスト2")
//    let animator = UIDynamicAnimator(referenceView: uiView)
//    let gravity = UIGravityBehavior()
//    animator.addBehavior(gravity)
//  }
//}
