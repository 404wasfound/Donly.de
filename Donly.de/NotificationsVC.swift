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

protocol NotificationsVCProtocol {
  func endRefreshing()
}

class NotificationsVC: UIViewController {
  
  @IBOutlet weak var notificationsTable: UITableView!
  @IBOutlet weak var reloadButton: ReloadButton!
  @IBAction func reloadButtonPressed(_ sender: UIButton) {
    self.reloadData()
  }
  
  internal var viewModel: NotificationsViewModelProtocol?
  internal var disposeBag = DisposeBag()
  internal var emptyView: UIView!
  internal var mainViewConfigured: Bool = false
  lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(NotificationsVC.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
    return refreshControl
  }()
  
  init(withViewModel viewModel: NotificationsViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: "NotificationsEmpty", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel?.delegate = self
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
        if self.mainViewConfigured {
          self.notificationsTable.reloadData()
        } else {
          self.configureMainView()
        }
      }
    }).addDisposableTo(disposeBag)
  }
  
  func configureMainView() {
    DispatchQueue.main.async {
      let nib = UINib(nibName: String(describing: NotificationsVC.self), bundle: nil)
      if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
        self.configureTable()
        self.mainViewConfigured = true
        UIView.animate(withDuration: 0.3, animations: {
          self.emptyView.alpha = 0.3
          self.emptyView.removeFromSuperview()
          self.view.alpha = 0.3
          self.view = view
          self.view.alpha = 1.0
        })
      }
    }
  }
  
  func configureTable() {
    self.notificationsTable.delegate = self
    self.notificationsTable.dataSource = self
    self.notificationsTable.register(UINib(nibName: String(describing: NotificationsTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: NotificationsTableCell.self))
    self.notificationsTable.addSubview(self.refreshControl)
    self.notificationsTable.allowsMultipleSelectionDuringEditing = true
    self.notificationsTable.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    self.notificationsTable.tableFooterView?.isHidden = true
    self.notificationsTable.backgroundColor = lightGrayColor
  }
  
}

extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NotificationsTableCell.self), for: indexPath) as? NotificationsTableCell, let notifications = viewModel?.notifications.value else {
      return UITableViewCell()
    }
    cell.configureCell(forNotification: notifications[indexPath.row])
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let notifications = viewModel?.notifications.value else {
      return 0
    }
    return notifications.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80.0
  }
  
  func handleRefresh(refreshControl: UIRefreshControl) {
    viewModel?.getNotifications(forPull: true)
  }
  
  func reloadData() {
    self.viewModel?.getNotifications(forPull: false)
  }
  
}

extension NotificationsVC: NotificationsVCProtocol {
  
  func endRefreshing() {
    print("Refresh is done!")
    self.refreshMainView()
    refreshControl.endRefreshing()
  }
  
  func refreshMainView() {
    if let notifications = viewModel?.notifications.value, notifications.isEmpty {
      let nib = UINib(nibName: "NotificationsEmpty", bundle: nil)
      if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
        self.view = view
        self.mainViewConfigured = false
      }
    }
  }
  
}
