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
  func endRefreshing()
}

class ConversationsVC: UIViewController {
  
  @IBOutlet weak var messagesTable: UITableView!
  @IBOutlet weak var reloadButton: ReloadButton!
  @IBAction func reloadButtonPressed(_ sender: UIButton) {
    self.reloadData()
  }
  
  internal var viewModel: ConversationsViewModelProtocol?
  internal var disposeBag = DisposeBag()
  internal var mainViewConfigured: Bool = false
  internal var emptyView: UIView!
  lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(ConversationsVC.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
    return refreshControl
  }()
  
  init(withViewModel viewModel: ConversationsViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: "ConversationsEmpty", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel?.delegate = self
    viewModel?.getConversations(forPull: false)
    setupEmptyView()
    setupBindings()
  }
  
  func setupEmptyView() {
    self.emptyView = UIView(frame: self.view.frame)
    self.emptyView.backgroundColor = .white
    self.view.addSubview(self.emptyView)
  }
  
  func setupBindings() {
    viewModel?.conversations.asObservable().bind(onNext: { conversations in
      if let newConversations = conversations {
        guard !newConversations.isEmpty else {
          self.emptyView.removeFromSuperview()
          return
        }
        if self.mainViewConfigured {
          self.messagesTable.reloadData()
        } else {
          self.configureMainView()
        }
      }
    }).addDisposableTo(disposeBag)
  }
  
  func configureMainView() {
    DispatchQueue.main.async {
      let nib = UINib(nibName: String(describing: ConversationsVC.self), bundle: nil)
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
    self.messagesTable.delegate = self
    self.messagesTable.dataSource = self
    self.messagesTable.register(UINib(nibName: String(describing: ConversationsTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ConversationsTableCell.self))
    self.messagesTable.addSubview(self.refreshControl)
    self.messagesTable.allowsMultipleSelectionDuringEditing = true
    self.messagesTable.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    self.messagesTable.tableFooterView?.isHidden = true
    self.messagesTable.backgroundColor = .clear
  }
  
}

extension ConversationsVC: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let conversation = viewModel?.conversations.value?[indexPath.row] else {
      return
    }
    tableView.deselectRow(at: indexPath, animated: true)
    viewModel?.openConversation(conversation)
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
    return 80.0
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      /// Perform deletion
    }
  }
  
  func handleRefresh(refreshControl: UIRefreshControl) {
    viewModel?.getConversations(forPull: true)
  }
  
  func reloadData() {
    self.viewModel?.getConversations(forPull: false)
  }
  
}

extension ConversationsVC: ConversationsVCProtocol {
  
  func endRefreshing() {
    print("Refresh is done!")
    self.refreshMainView()
    refreshControl.endRefreshing()
  }
  
  func refreshMainView() {
    if let conversations = viewModel?.conversations.value, conversations.isEmpty {
      let nib = UINib(nibName: "ConversationsEmpty", bundle: nil)
      if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
        self.view = view
        self.mainViewConfigured = false
      }
    }
  }
  
}
