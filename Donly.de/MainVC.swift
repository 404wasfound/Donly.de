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
  
  @IBOutlet private weak var messagesButton: TabBarButton!
  @IBAction private func messagesButtonPressed(_ sender: UIButton) {
    ///trigger smth on view model
    updateBar(forNewPage: MainScene.MainPage.messages)
  }
  
  @IBOutlet private weak var myTasksButton: TabBarButton!
  @IBAction private func myTasksButtonPressed(_ sender: UIButton) {
    ///
    updateBar(forNewPage: MainScene.MainPage.myTasks)
  }
  
  @IBOutlet private weak var allTasksButton: TabBarButton!
  @IBAction private func allTasksButtonPressed(_ sender: UIButton) {
    ///
    updateBar(forNewPage: MainScene.MainPage.allTasks)
  }
  
  @IBOutlet private weak var notificationsButton: TabBarButton!
  @IBAction private func notificationsButtonPressed(_ sender: UIButton) {
    ///
    updateBar(forNewPage: MainScene.MainPage.notifications)
  }
  
  @IBOutlet private weak var profileButton: TabBarButton!
  @IBAction private func profileButtonPressed(_ sender: UIButton) {
    ///
    updateBar(forNewPage: MainScene.MainPage.profile)
  }
  
  var viewModel: MainViewModelProtocol?
  private var currentPage: MainScene.MainPage = MainScene.MainPage.messages
  var barButtons: [MainScene.MainPage: TabBarButton] = [:]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.loadViewForContainer()
    self.setupBarUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.updateBar(forNewPage: self.currentPage)
  }
  
  func loadViewModel(forPage page: MainScene.MainPage) {
    self.currentPage = page
    self.viewModel = MainViewModel(withPage: page)
  }
  
  func loadViewForContainer() {
    if let vc = self.viewModel?.configureViewForContainer() {
      addChildViewController(vc)
      vc.view.frame = CGRect(x: 0, y: 0, width: contentContainer.frame.width, height: contentContainer.frame.height)
      contentContainer.clipsToBounds = true
      contentContainer.addSubview(vc.view)
    }
  }
  
  func setupBarUI() {
    self.barButtons = [MainScene.MainPage.messages: self.messagesButton, MainScene.MainPage.myTasks: self.myTasksButton, MainScene.MainPage.allTasks: self.allTasksButton, MainScene.MainPage.notifications: self.notificationsButton, MainScene.MainPage.profile: self.profileButton]
    for buttonElement in barButtons {
      buttonElement.value.imageEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
      buttonElement.value.imageView?.contentMode = .scaleAspectFit
      buttonElement.value.contentHorizontalAlignment = .center
    }
  }
  
  func setupBarButton(forPage page: MainScene.MainPage, withState selected: Bool) {
    if let button = barButtons[page] {
      if self.currentPage != page {
        self.currentPage = page
      }
      var image: UIImage?
      if selected {
        image = page.getImageForSelectedState()
      } else {
        image = page.getImageForUnselectedState()
      }
      guard let newImage = image else {
        return
      }
      button.updateButton(withImage: newImage, forState: true)
    }
  }
  
  func updateBar(forNewPage page: MainScene.MainPage) {
    setupBarButton(forPage: self.currentPage, withState: false)
    setupBarButton(forPage: page, withState: true)
    navigationItem.title = page.getTitleForScreen()
  }
  
}
