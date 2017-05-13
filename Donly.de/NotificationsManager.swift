//
//  NotificationsManager.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/4/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

var notificationsManager = NotificationsManager.shared

class NotificationsManager {
  static let shared = NotificationsManager()
  
  func requestWith(delegate: OnboardingPermissionsProtocol) {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { granted, error in
      if granted {
        UIApplication.shared.registerForRemoteNotifications()
      }
      DispatchQueue.main.async {
        delegate.notificationsRequested()
      }
    }
  }
  
}

