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
  
  func configureCell(forDialog dialog: String) { /// Temporary only string
    self.userName.text = dialog
  }
  
}
