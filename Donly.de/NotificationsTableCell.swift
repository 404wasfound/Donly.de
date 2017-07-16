//
//  NotificationsTableCell.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/22/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit
import Kingfisher

class NotificationsTableCell: UITableViewCell {
  
  @IBOutlet private weak var profileImageView: UIImageView!
  @IBOutlet private weak var userName: UILabel!
  @IBOutlet private weak var notificationType: UILabel!
  @IBOutlet private weak var notificationTitle: UILabel!
  @IBOutlet private weak var notificationDate: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
    self.userName.textColor = donlyColor
    self.notificationTitle.textColor = donlyColor
  }
  
  func configureCell(forNotification notification: Notification) {
    self.userName.text = notification.author.firstName
    self.notificationTitle.text = notification.jobTitle
    self.notificationDate.text = DateManager.getFormattedDate(fromDate: notification.dateCreated)
    let url = URL(string: notification.author.imagePath)
    self.profileImageView.kf.setImage(with: url)
  }
  
}
