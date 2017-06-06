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
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  init(withViewModel viewModel: MainMessagesViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: "MainMessagesEmpty", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
}

extension MainMessagesVC: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    /// Select the messages
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    /// Return the tableViewCell
    return UITableViewCell()
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
}
