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
  
  init(withViewModel viewModel: SplashViewModelProtocol) {
    self.splashViewModel = viewModel
    super.init(nibName: String(describing: SplashVC.self), bundle: nil)
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
    let navController = UINavigationController()
    navController.viewControllers = [nextController]
    appDelegate.window?.rootViewController = navController
    appDelegate.window?.makeKeyAndVisible()
  }
  
}
