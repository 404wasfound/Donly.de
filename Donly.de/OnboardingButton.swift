//
//  OnboardingButton.swift
//  Donly.de
//
//  Created by Bogdan Yur on 3/30/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

  override func awakeFromNib() {
    layer.cornerRadius = 3.0
    layer.shadowColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.5).cgColor
    layer.shadowOpacity = 0.8
    layer.shadowRadius = 4.0
    layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
  }
  
  func setupButtonWith(title: String) {
    setTitle(title, for: .normal)
    setTitleColor(UIColor(red: 0, green: 200/255, blue: 155/255, alpha: 1.0), for: .normal)
    isHidden = false
  }

}
