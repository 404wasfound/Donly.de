//
//  OnboardingLoginVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 5/14/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class OnboardingLoginVC: UIViewController {

  var viewModel: OnboardingLoginViewModelProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }
  
  init(viewModel: OnboardingLoginViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: String(describing: OnboardingLoginVC.self), bundle: nil)
  }
  
  convenience init() {
    let viewModel = OnboardingLoginViewModel()
    self.init(viewModel: viewModel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
}
