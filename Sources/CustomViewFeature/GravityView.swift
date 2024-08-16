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
  @Binding var angle: CGFloat

  public init(animationViews: Binding<[UIView]>, angle: Binding<CGFloat>) {
    self._animationViews = animationViews
    self._angle = angle
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
    if context.coordinator.currentAnimationViews != animationViews {
      context.coordinator.updateAnimator(animationViews, angle, in: uiView)
    }

    // 端末の角度に変更があった場合の処理
    if context.coordinator.currentAngle != angle {
      context.coordinator.updateGravityAngle(animationViews, angle, in: uiView)
    }
  }
    
  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
    
  public class Coordinator: NSObject {
    var parent: GravityView
    var animator: UIDynamicAnimator?

    var currentAnimationViews: [UIView]
    var currentAngle: CGFloat

    var currentGravityBehavior: UIGravityBehavior
    
    init(_ parent: GravityView) {
      self.parent = parent
      self.currentAnimationViews = parent.animationViews
      self.currentAngle = parent.angle
      self.currentGravityBehavior = UIGravityBehavior(items: parent.animationViews)
    }
    
    // Blockのアップデート
    func updateAnimator(_ animationViews: [UIView], _ angle: CGFloat, in view: UIView) {
      // 既存のBlockを削除
      view.subviews.forEach { $0.removeFromSuperview() }
      // Blockを追加
      for animationView in animationViews {
        view.addSubview(animationView)
      }
      
      // Blockにアニメーターの動作を設定
      if let animator = animator {
        animator.removeAllBehaviors()
        
        currentGravityBehavior = UIGravityBehavior(items: animationViews)
        currentGravityBehavior.angle = CGFloat(angle + CGFloat.pi / 2)

        let collision = UICollisionBehavior(items: animationViews)
        collision.translatesReferenceBoundsIntoBoundary = true
        
        animator.addBehavior(collision)
        animator.addBehavior(currentGravityBehavior)
      }

      currentAnimationViews = animationViews
    }

    // 重力設定の変更
    func updateGravityAngle(_ animationViews: [UIView], _ angle: CGFloat, in view: UIView) {
      currentGravityBehavior.angle = angle
      // CGFloat(angle + CGFloat.pi / 2)
      currentAngle = angle
    }
  }
}
