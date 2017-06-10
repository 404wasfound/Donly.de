//
//  ConversationsVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/6/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ConversationsVCProtocol {
  func showActivityIndicator()
  func hideActivityIndicator()
  func endRefreshing()
}

class ConversationsVC: UIViewController {
  
  @IBOutlet weak var messagesTable: UITableView!
  
  internal var viewModel: ConversationsViewModelProtocol?
  internal var disposeBag = DisposeBag()
  lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(ConversationsVC.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
    return refreshControl
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.viewModel?.delegate = self
    viewModel?.getConversations(forPull: false)
    setupBindings()
  }
  
  init(withViewModel viewModel: ConversationsViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: "ConversationsEmpty", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  func setupBindings() {
    viewModel?.conversations.asObservable().bind(onNext: { conversations in
      if let _ = conversations {
        DispatchQueue.main.async {
          let nib = UINib(nibName: String(describing: ConversationsVC.self), bundle: nil)
          if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
          }
          self.configureTable()
        }
      }
    }).addDisposableTo(disposeBag)
  }
  
  func configureTable() {
    self.messagesTable.delegate = self
    self.messagesTable.dataSource = self
    self.messagesTable.register(UINib(nibName: String(describing: ConversationsTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ConversationsTableCell.self))
    self.messagesTable.addSubview(self.refreshControl)
    self.messagesTable.allowsMultipleSelectionDuringEditing = true
  }
  
}

extension ConversationsVC: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    /// Select the messages
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConversationsTableCell.self), for: indexPath) as? ConversationsTableCell, let conversations = viewModel?.conversations.value else {
      return UITableViewCell()
    }
    cell.configureCell(forConversation: conversations[indexPath.row])
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let conversations = viewModel?.conversations.value else {
      return 0
    }
    return conversations.count
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100.0
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      /// Perform deletion
    }
  }
  
  func handleRefresh(refreshControl: UIRefreshControl) {
    viewModel?.getConversations(forPull: true)
  }
  
}

extension ConversationsVC: ConversationsVCProtocol {
  
  func endRefreshing() {
    print("Refresh is done!")
    messagesTable.reloadData()
    refreshControl.endRefreshing()
  }
  
  func showActivityIndicator() {
    ActivityIndicatorManager.shared.show(onView: self.view)
  }
  
  func hideActivityIndicator() {
    ActivityIndicatorManager.shared.hide()
  }
  
}