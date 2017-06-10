//
//  ConversationVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/10/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class ConversationVC: UIViewController {
  
  private var viewModel: ConversationViewModelProtocol?
  
  init(withViewModel viewModel: ConversationViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: String(describing: ConversationVC.self), bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
}
