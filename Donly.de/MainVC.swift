//
//  MainVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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
  internal var badgeViews: [MainScene.MainPage: NotificationBadge?] = [:]
  internal var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.router = MainRouter(withMainViewcontroller: self, andViewModel: self.viewModel)
    self.loadData()
    self.setupBindings()
    self.setupBarUI()
    self.setupSlider(forPage: self.currentPage)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.updateBar(forNewPage: self.currentPage)
    self.registerForNotifications()
  }
  
  func loadViewModel(forPage page: MainScene.MainPage) {
    self.currentPage = page
    self.viewModel = MainViewModel(withPage: page)
  }
  
  func loadData() {
    self.loadViewForContainer()
    self.viewModel?.mainVC = self
    self.viewModel?.getBadgeCounterForPage(.messages)
    self.viewModel?.getBadgeCounterForPage(.notifications)
  }
  
}

/// Loading and animating related stuff
extension MainVC {
  
  func setupBindings() {
    self.viewModel?.messagesCounter.asObservable().bind(onNext: { value in
      if let newValue = value {
        self.configureBadgeForPage(.messages, withValue: newValue)
      }
    }).addDisposableTo(disposeBag)
    
    self.viewModel?.notificationsCounter.asObservable().bind(onNext: { value in
      if let newValue = value {
        self.configureBadgeForPage(.notifications, withValue: newValue)
      }
    }).addDisposableTo(disposeBag)
  }
  
  func loadViewForContainer() {
    if let router = self.router, let vc = self.viewModel?.configureViewForContainer(withRouter: router, andMainVC: self) {
      addChildViewController(vc)
      performPageAnimation(forController: vc)
      viewModel?.currentScreen = vc
      let frameForSubview = CGRect(x: 0, y: 0, width: contentContainer.frame.width, height: contentContainer.frame.height)
      vc.view.frame = frameForSubview
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

extension MainVC {
  func configureBadgeForPage(_ page: MainScene.MainPage, withValue value: Int) {
    guard let barButton = barButtons[page] else { return }
    guard let badge = badgeViews[page] else {
      if value == 0 { return }
      let newBadge = NotificationBadge.instantiateFromNib()
      newBadge.setBadgeValue(value)
      newBadge.center.y = self.sliderSelection.center.y
      newBadge.center.x = barButton.center.x - barButton.frame.width * 0.25
      badgeViews[page] = newBadge
      self.view.addSubview(newBadge)
      return
    }
    if value == 0 {
      badge?.removeFromSuperview()
      badgeViews[page] = nil
    } else {
      badge?.setBadgeValue(value)
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
  
  func registerForNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(reloadViewsOnDidBecomeActive), name: .UIApplicationWillEnterForeground, object: nil)
  }
  
  func deregisterFromNotifications() {
    NotificationCenter.default.removeObserver(self, name: .UIApplicationWillEnterForeground, object: nil)
  }
  
  @objc func reloadViewsOnDidBecomeActive() {
//    self.setupEmptyView()
    self.contentContainer.subviews.forEach({ $0.removeFromSuperview() })
    self.viewModel?.resetScenes()
    self.loadData()
  }
  
  func setupEmptyView() {
    let emptyView = UIView(frame: self.contentContainer.frame)
    emptyView.backgroundColor = .white
    self.contentContainer.addSubview(emptyView)
  }
  
}
