//
//  MainVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
  
  @IBOutlet private var container: UIView!
  @IBOutlet private var tabBar: UITabBar!
  
  private var viewModel: MainViewModelProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.viewModel = MainViewModel(page: .alltasks)
    showCurrentView()
  }
  
  func showCurrentView() {
    if let viewModel = self.viewModel, let vc = viewModel.configureView() {
      addChildViewController(vc)
      vc.view.frame = CGRect(x: 0, y: 0, width: container.frame.width, height: container.frame.height)
      container.clipsToBounds = true
      container.addSubview(vc.view)
    }
  }
  
}
