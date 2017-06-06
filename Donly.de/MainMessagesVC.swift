//
//  MainMessagesVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/6/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol MainMessagesVCProtocol {
  
}

class MainMessagesVC: UIViewController {
  
  @IBOutlet private weak var messagesTable: UITableView!
  
  internal var viewModel: MainMessagesViewModelProtocol?
  internal var disposeBag = DisposeBag()
  var tempArray: [String]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBindings()
  }
  
  init(withViewModel viewModel: MainMessagesViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: "MainMessagesEmpty", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  func setupBindings() {
    viewModel?.tempArray.asObservable().bind(onNext: { array in
      if let array = array {
        self.tempArray = array
        DispatchQueue.main.async {
          let nib = UINib(nibName: String(describing: MainMessagesVC.self), bundle: nil)
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
    self.messagesTable.register(UINib(nibName: String(describing: MainMessagesTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MainMessagesTableCell.self))
    self.messagesTable.allowsMultipleSelectionDuringEditing = true
//    self.messagesTable.reloadData()
  }
  
}

extension MainMessagesVC: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    /// Select the messages
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MainMessagesTableCell.self), for: indexPath) as? MainMessagesTableCell, let array = self.tempArray else {
      return UITableViewCell()
    }
    cell.configureCell(forDialog: array[indexPath.row])
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let array = self.tempArray else {
      return 1
    }
    return array.count
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
  
}
