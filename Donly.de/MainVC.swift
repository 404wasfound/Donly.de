//
//  MainVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

protocol MainVCProtocol {
  func showIndicator()
  func hideIndicator()
}

class MainVC: UIViewController {
  
  @IBOutlet weak var contentContainer: UIView!
  @IBOutlet weak var tabBarView: UIView!
  
  @IBOutlet weak var messagesButton: TabBarButton!
  @IBAction private func messagesButtonPressed(_ sender: UIButton) {
    ///trigger smth on view model
    viewModel?.page = .messages
    loadViewForContainer()
    updateBar(forNewPage: MainScene.MainPage.messages)
  }
  
  @IBOutlet weak var myTasksButton: TabBarButton!
  @IBAction private func myTasksButtonPressed(_ sender: UIButton) {
    ///
    viewModel?.page = .myTasks
    loadViewForContainer()
    updateBar(forNewPage: MainScene.MainPage.myTasks)
  }
  
  @IBOutlet weak var allTasksButton: TabBarButton!
  @IBAction private func allTasksButtonPressed(_ sender: UIButton) {
    ///
    viewModel?.page = .allTasks
    loadViewForContainer()
    updateBar(forNewPage: MainScene.MainPage.allTasks)
  }
  
  @IBOutlet weak var notificationsButton: TabBarButton!
  @IBAction private func notificationsButtonPressed(_ sender: UIButton) {
    ///
    viewModel?.page = .notifications
    loadViewForContainer()
    updateBar(forNewPage: MainScene.MainPage.notifications)
  }
  
  @IBOutlet weak var profileButton: TabBarButton!
  @IBAction private func profileButtonPressed(_ sender: UIButton) {
    ///
    viewModel?.page = .profile
    loadViewForContainer()
    updateBar(forNewPage: MainScene.MainPage.profile)
  }

  var viewModel: MainViewModelProtocol?
  var router: MainRouterProtocol?
  fileprivate var currentPage: MainScene.MainPage = MainScene.MainPage.messages
  var barButtons: [MainScene.MainPage: TabBarButton] = [:]
  var sliderSelection: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.router = MainRouter(withMainViewcontroller: self, andViewModel: self.viewModel)
    self.loadViewForContainer()
    self.setupBarUI()
    self.setupSlider(forPage: self.currentPage)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.updateBar(forNewPage: self.currentPage)
  }
  
  func loadViewModel(forPage page: MainScene.MainPage) {
    self.currentPage = page
    self.viewModel = MainViewModel(withPage: page)
  }
}

/// Loading and animating related stuff
extension MainVC {
  func loadViewForContainer() {
    if let router = self.router, let vc = self.viewModel?.configureViewForContainer(withRouter: router, andMainVC: self) {
      addChildViewController(vc)
      performPageAnimation(forController: vc)
      viewModel?.currentScreen = vc
      contentContainer.clipsToBounds = true
      contentContainer.addSubview(vc.view)
    }
  }
  
  func performPageAnimation(forController vc: UIViewController) {
    guard let pageRaw = viewModel?.page.rawValue, pageRaw != currentPage.rawValue else {
      return
    }
    let difference = self.view.frame.width
    var frameForView = CGRect(x: self.view.frame.origin.x + difference, y: 0, width: contentContainer.frame.width, height: contentContainer.frame.height)
    if pageRaw < self.currentPage.rawValue {
      frameForView = CGRect(x: self.view.frame.origin.x - difference, y: 0, width: contentContainer.frame.width, height: contentContainer.frame.height)
    }
    vc.view.frame = frameForView
    UIView.animate(withDuration: 0.2) {
      var oldViewCenter = self.view.center.x - difference
      if pageRaw < self.currentPage.rawValue {
        oldViewCenter = self.view.center.x + difference
      }
      self.viewModel?.currentScreen?.view.center.x = oldViewCenter
      vc.view.center.x = self.view.center.x
    }
  }
}

/// Bar related stuff
extension MainVC {
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
    moveSlider(forPage: self.currentPage)
    navigationItem.title = page.getTitleForScreen()
  }
}

/// Bar slider related stuff
extension MainVC {
  func setupSlider(forPage page: MainScene.MainPage) {
    if let button = barButtons[page] {
      let heightForSlider: CGFloat = 3.0
      let frame = CGRect(x: 0, y: self.view.frame.height - self.messagesButton.frame.height - heightForSlider / 2 - 0.5, width: self.messagesButton.frame.width, height: heightForSlider)
      self.sliderSelection = UIView(frame: frame)
      self.sliderSelection.center.x = button.center.x
      self.sliderSelection.layer.cornerRadius = 2.0
      self.sliderSelection.backgroundColor = donlyColor
      self.view.addSubview(sliderSelection)
    }
  }
  
  func moveSlider(forPage page: MainScene.MainPage) {
    if let button = barButtons[page] {
      let positionX = button.center.x
      UIView.animate(withDuration: 0.2) {
        self.sliderSelection.center.x = positionX
      }
    }
  }
}

/// MainVCProtocol
extension MainVC: MainVCProtocol {
  func showIndicator() {
    self.showActivityIndicator()
  }
  
  func hideIndicator() {
    self.hideActivityIndicator()
  }
}
