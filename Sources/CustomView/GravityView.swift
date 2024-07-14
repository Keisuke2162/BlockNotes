//
//  GravityView.swift
//  
//
//  Created by Kei on 2024/07/14.
//

import SwiftUI
import UIKit

public struct GravityView: UIViewRepresentable {
  // TODO: 要検討：Bindingじゃなくて良いかも
  @Binding var animationViews: [UIView]
  let viewSize: CGSize

  public init(animationViews: Binding<[UIView]>, viewSize: CGSize) {
    self._animationViews = animationViews
    self.viewSize = viewSize
  }

  public func makeUIView(context: Context) -> UIView {
    let view = UIView()
    let animator = UIDynamicAnimator(referenceView: view)
    let gravity = UIGravityBehavior(items: animationViews)
    
    let collision = UICollisionBehavior(items: animationViews)
    collision.translatesReferenceBoundsIntoBoundary = true
    
    // バリアの設定
    // TODO: 色々弾性の設定できそう
    /// https://qiita.com/Hiragarian/items/15a0e4a1e1396059e21b
//    let barrierRect = CGRect(x: 0, y: 0 - viewSize.height, width: viewSize.width, height: viewSize.height)
//    collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrierRect))
    
    animator.addBehavior(collision)
    animator.addBehavior(gravity)
    
    // ボタンを追加
    for animationView in animationViews {
      view.addSubview(animationView)
    }
    context.coordinator.animator = animator
    
    return view
  }
    
  public func updateUIView(_ uiView: UIView, context: Context) {
    // ボタンが追加または削除された場合の更新処理
    context.coordinator.updateAnimator(animationViews, in: uiView)
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
    
    func updateAnimator(_ animationViews: [UIView], in view: UIView) {
      // 既存のボタンを削除
      view.subviews.forEach { $0.removeFromSuperview() }
      // 新しいボタンを追加
      for animationView in animationViews {
        view.addSubview(animationView)
      }
      
      // アニメーターの動作を更新
      if let animator = animator {
        animator.removeAllBehaviors()
        
        let gravity = UIGravityBehavior(items: animationViews)
        let collision = UICollisionBehavior(items: animationViews)
        collision.translatesReferenceBoundsIntoBoundary = true
  
//        let barrierRect = CGRect(x: 0, y: 0 - parent.viewSize.height, width: parent.viewSize.width, height: parent.viewSize.height)
//        collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrierRect))
        
        animator.addBehavior(collision)
        animator.addBehavior(gravity)
      }
    }
  }
}
