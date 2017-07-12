//
//  NotificationsVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 7/12/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class NotificationsVC: UIViewController {
  
  internal var viewModel: NotificationsViewModelProtocol?
  
  init(withViewModel viewModel: NotificationsViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: "NotificationsEmpty", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
}
