//
//  SplashVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

  @IBOutlet private weak var logo: UIImageView!
  
  private var splashViewModel: SplashViewModelProtocol
  
  init(viewModel: SplashViewModelProtocol) {
    self.splashViewModel = viewModel
    super.init(nibName: String(describing: SplashVC.self), bundle: nil)
  }
  
  convenience init() {
    self.init(viewModel: SplashViewModel())
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setup()
  }
  
  func setup() {
    guard let nextController = self.splashViewModel.nextController else {
      return
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window?.rootViewController = nextController
    appDelegate.window?.makeKeyAndVisible()
  }
  
}
