//
//  OnboardingButton.swift
//  Donly.de
//
//  Created by Bogdan Yur on 5/13/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class OnboardingButton: UIButton {
  
  override func awakeFromNib() {
    self.layer.cornerRadius = 5.0
  }
  
  func configure(button: OnboardingPermissionsScene.PermissionsButton, title: String) {
    switch button {
    case .accept:
      setGreenButton()
    case .cancel:
      setGreyButton()
    }
    setTitle(title, for: .normal)
  }
  
  private func setGreenButton() {
    layer.backgroundColor = donlyColor.cgColor
  }
  
  private func setGreyButton() {
    layer.borderWidth = 2.0
    layer.borderColor = UIColor.lightGray.cgColor
    layer.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1.00).cgColor
    setTitleColor(UIColor.lightGray, for: .normal)
  }

}
