//
//  JobCell.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/8/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {

  @IBOutlet private weak var container: UIView!
  @IBOutlet private weak var label: UILabel!
  
  func configureCell(textForLabel: String) {
    self.label.text = textForLabel
  }
    
}
