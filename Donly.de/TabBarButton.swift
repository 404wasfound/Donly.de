//
//  TabBarButton.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/3/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class TabBarButton: UIButton {

  var currentSelected: Bool = false
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func updateButton(withImage image: UIImage, forState selected: Bool) {
    setImage(image, for: .normal)
    self.currentSelected = selected
  }

}
