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
  
  private var viewModel: SplashViewModelProtocol
  private var router: SplashRouter
  
  init(withViewModel viewModel: SplashViewModelProtocol) {
    self.viewModel = viewModel
    self.router = SplashRouter(withViewModel: viewModel)
    super.init(nibName: String(describing: SplashVC.self), bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupFirstScene()
  }
  
  func setupFirstScene() {
    router.route()
  }
  
}
