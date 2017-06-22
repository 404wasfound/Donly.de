//
//  NotificationsVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 7/12/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NotificationsVC: UIViewController {
  
  @IBOutlet weak var reloadButton: ReloadButton!
  @IBAction func reloadButtonPressed(_ sender: UIButton) {
    self.reloadData()
  }
  
  internal var viewModel: NotificationsViewModelProtocol?
  internal var disposeBag = DisposeBag()
  internal var emptyView: UIView!
  
  init(withViewModel viewModel: NotificationsViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: "NotificationsEmpty", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel?.getNotifications(forPull: false)
    setupEmptyView()
    setupBindings()
  }
  
  func setupEmptyView() {
    self.emptyView = UIView(frame: self.view.frame)
    self.emptyView.backgroundColor = .white
    self.view.addSubview(self.emptyView)
  }
  
  func setupBindings() {
    viewModel?.notifications.asObservable().bind(onNext: { notifications in
      if let newNotifications = notifications {
        guard !newNotifications.isEmpty else {
          self.emptyView.removeFromSuperview()
          return
        }
      }
    }).addDisposableTo(disposeBag)
  }
  
  func reloadData() {
    self.viewModel?.getNotifications(forPull: false)
  }
  
}
