//
//  GravityView.swift
//  
//
//  Created by Kei on 2024/07/14.
//

import SwiftUI
import UIKit

public struct GravityView: UIViewRepresentable {
  @Binding var buttons: [UIView]
  
  public init(buttons: Binding<[UIView]>) {
    self._buttons = buttons
  }

  public func makeUIView(context: Context) -> UIView {
    let view = UIView()
    let animator = UIDynamicAnimator(referenceView: view)
    let gravity = UIGravityBehavior(items: buttons)
    
    let collision = UICollisionBehavior(items: buttons)
    collision.translatesReferenceBoundsIntoBoundary = false
    
    // バリアの設定
//    let barrierRect = CGRect(x: 0, y: 0 - view.bounds.height, width: view.bounds.width, height: view.bounds.height - tabBarHeight + view.bounds.height)
//    collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrierRect))
    
    animator.addBehavior(collision)
    animator.addBehavior(gravity)
    
    // ボタンを追加
    for button in buttons {
      view.addSubview(button)
    }
    context.coordinator.animator = animator
    
    return view
  }
    
  public func updateUIView(_ uiView: UIView, context: Context) {
    // ボタンが追加または削除された場合の更新処理
    context.coordinator.updateButtons(buttons, in: uiView)
  }
    
  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
    
  public class Coordinator: NSObject {
    var parent: GravityView
    var animator: UIDynamicAnimator?
    
    init(_ parent: GravityView) {
      self.parent = parent
    }
    
    func updateButtons(_ buttons: [UIView], in view: UIView) {
      // 既存のボタンを削除
      view.subviews.forEach { $0.removeFromSuperview() }
      // 新しいボタンを追加
      for button in buttons {
        view.addSubview(button)
      }
      
      // アニメーターの動作を更新
      if let animator = animator {
        animator.removeAllBehaviors()
        
        let gravity = UIGravityBehavior(items: buttons)
        let collision = UICollisionBehavior(items: buttons)
        collision.translatesReferenceBoundsIntoBoundary = false
        
        //        let barrierRect = CGRect(x: 0, y: 0 - view.bounds.height, width: view.bounds.width, height: view.bounds.height - parent.tabBarHeight + view.bounds.height)
        //        collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrierRect))
        
        animator.addBehavior(collision)
        animator.addBehavior(gravity)
      }
    }
  }
}
