//
//  NotificationBadge.swift
//  Donly.de
//
//  Created by Bogdan Yur on 7/13/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class NotificationBadge: UIView {
  
  @IBOutlet private weak var badgeValueLabel: UILabel!
  
  override func awakeFromNib() {
    self.layer.cornerRadius = self.frame.width / 2
  }
  
  class func instantiateFromNib() -> NotificationBadge {
    return UINib(nibName: String(describing: NotificationBadge.self), bundle: nil).instantiate(withOwner: nil, options: nil).first as! NotificationBadge
  }
  
  func setBadgeValue(_ value: Int) {
    self.badgeValueLabel.text = "\(value)"
  }
  
}
