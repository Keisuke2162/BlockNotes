//
//  Notification+Extension.swift
//  BlockNotes
//
//  Created by Kei on 2024/08/19.
//

import Foundation
import UIKit

extension NSNotification.Name {
  public static let deviceDidShakeNotification = NSNotification.Name("DeviceDidShakeNotification")
}

extension UIWindow {
  open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    super.motionEnded(motion, with: event)
    NotificationCenter.default.post(name: .deviceDidShakeNotification, object: event)
  }
}
