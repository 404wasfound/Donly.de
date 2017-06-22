//
//  ReloadButton.swift
//  Donly.de
//
//  Created by Bogdan Yur on 7/13/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class ReloadButton: UIButton {

  override func awakeFromNib() {
    layer.borderWidth = 1.0
    layer.borderColor = UIColor.lightGray.cgColor
    layer.cornerRadius = 5.0
    layer.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1.00).cgColor
    setTitleColor(.lightGray, for: .normal)
    setTitle("Reload", for: .normal)
  }

}
