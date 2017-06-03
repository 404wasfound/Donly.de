//
//  MainVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
  
  @IBOutlet private weak var contentContainer: UIView!
  @IBOutlet private weak var tabBarView: UIView!
  @IBOutlet private weak var messagesButton: UIButton!
  @IBOutlet private weak var myTasksButton: UIButton!
  @IBOutlet private weak var allTasksButton: UIButton!
  @IBOutlet private weak var notificationsButton: UIButton!
  @IBOutlet private weak var profileButton: UIButton!
  
  var viewModel: MainViewModel?
  private var currentPage: MainScene.MainPage?
  var barButtons: [UIButton] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  func loadViewModel(forPage page: MainScene.MainPage) {
    self.currentPage = page
    self.viewModel = MainViewModel(withPage: page)
  }
  
  func setupUI() {
    self.barButtons = [self.messagesButton, self.myTasksButton, self.allTasksButton, self.notificationsButton, self.profileButton]
    for button in barButtons {
      button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
      button.imageView?.contentMode = .scaleAspectFit
      button.contentHorizontalAlignment = .center
    }
  }
  
}
