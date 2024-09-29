//
//  GravityView.swift
//  
//
//  Created by Kei on 2024/07/14.
//

import InAppPurchaseFeature
import SwiftUI
import UIKit

public struct GravityView: UIViewRepresentable {
  // TODO: 要検討：Bindingじゃなくて良いかも
  @Binding var animationViews: [UIView]
  @Binding var angle: CGFloat
  let viewWidth: CGFloat
  let viewHeight: CGFloat
  let isPurchaseProduct: Bool

  public init(animationViews: Binding<[UIView]>, angle: Binding<CGFloat>, viewWidth: CGFloat, viewHeight: CGFloat, isPurchaseProduct: Bool) {
    self._animationViews = animationViews
    self._angle = angle
    self.viewWidth = viewWidth
    self.viewHeight = viewHeight
    self.isPurchaseProduct = isPurchaseProduct
  }

  public func makeUIView(context: Context) -> UIView {
    let view = UIView()
    let animator = UIDynamicAnimator(referenceView: view)
    let gravity = UIGravityBehavior(items: animationViews)

    let collision = UICollisionBehavior(items: animationViews)
    collision.translatesReferenceBoundsIntoBoundary = false

    /// 衝突境界の設定　https://qiita.com/Hiragarian/items/15a0e4a1e1396059e21b
    let adMargin: CGFloat = isPurchaseProduct ? 0 : 50
    let barrierRect = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight - adMargin)
    collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrierRect))

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
    if context.coordinator.currentAnimationViews != animationViews || context.coordinator.isPurchaseProduct != isPurchaseProduct {
      context.coordinator.updateAnimator(animationViews, angle, isPurchasePremium: isPurchaseProduct, in: uiView)
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
    @EnvironmentObject var purchaseManager: InAppPurchaseManager
    var parent: GravityView
    var animator: UIDynamicAnimator?
    var currentAnimationViews: [UIView]
    var currentAngle: CGFloat
    var currentGravityBehavior: UIGravityBehavior
    let viewWidth: CGFloat
    let viewHeight: CGFloat
    var isPurchaseProduct: Bool
    
    init(_ parent: GravityView) {
      self.parent = parent
      self.currentAnimationViews = parent.animationViews
      self.currentAngle = parent.angle
      self.currentGravityBehavior = UIGravityBehavior(items: parent.animationViews)
      self.viewWidth = parent.viewWidth
      self.viewHeight = parent.viewHeight
      self.isPurchaseProduct = parent.isPurchaseProduct
    }

    // Blockのアップデート
    func updateAnimator(_ animationViews: [UIView], _ angle: CGFloat, isPurchaseProduct: Bool, in view: UIView) {
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
        collision.translatesReferenceBoundsIntoBoundary = false
        let adMargin: CGFloat = isPurchaseProduct ? 0 : 50
        let barrierRect = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight - adMargin)
        collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrierRect))
        
        animator.addBehavior(collision)
        animator.addBehavior(currentGravityBehavior)
      }
      self.isPurchaseProduct = isPurchaseProduct
      self.currentAnimationViews = animationViews
    }

    // 重力設定の変更
    func updateGravityAngle(_ animationViews: [UIView], _ angle: CGFloat, in view: UIView) {
      currentGravityBehavior.angle = angle
      // CGFloat(angle + CGFloat.pi / 2)
      currentAngle = angle
    }
  }
}
