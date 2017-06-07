//
//  MainMessagesTableCell.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/6/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class MainMessagesTableCell: UITableViewCell {
  
  @IBOutlet private weak var profileImageView: UIImageView!
  @IBOutlet private weak var userName: UILabel!
  @IBOutlet private weak var lastMessage: UILabel!
  @IBOutlet private weak var lastMessageDate: UILabel!
  
  override func awakeFromNib() {
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
  }
  
  func configureCell(forConversation conversation: Conversation) { /// Temporary only string
    self.userName.text = conversation.user.fullName
    self.lastMessage.text = conversation.lastMessage.message
    self.lastMessageDate.text = conversation.lastMessage.sentDate.description(with: Locale.current)
  }
  
}
