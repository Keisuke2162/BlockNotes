//
//  MotionManager.swift
//  BlockNotes
//
//  Created by Kei on 2024/08/07.
//

import SwiftUI
import CoreMotion

public class MotionManager: ObservableObject {
  private var motionManager = CMMotionManager()

  @Published public var yaw: CGFloat = 0

  private var lastYaw: CGFloat = 0
  private let threshold: CGFloat = 0.1  // 更新する閾値（例: 0.05ラジアン

  public init() {
    startDeviceMotionUpdates()
  }

  func startDeviceMotionUpdates() {
    if motionManager.isDeviceMotionAvailable {
      motionManager.deviceMotionUpdateInterval = 0.01
      motionManager.startDeviceMotionUpdates(to: .main) { (motion, error) in
        guard let motion else { return }
        
        self.yaw = CGFloat(motion.attitude.yaw)
//        // 新しいyaw値
//        let newYaw = CGFloat(motion.attitude.yaw)
//        // 前回のyaw値との差分が閾値を超えていれば更新
//        if abs(newYaw - self.lastYaw) > self.threshold {
//          self.yaw = newYaw
//          self.lastYaw = newYaw
//        }
      }
    }
  }

  deinit {
    motionManager.stopDeviceMotionUpdates()
  }
}
