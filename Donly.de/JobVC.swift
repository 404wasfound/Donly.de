//
//  JobVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 7/16/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class JobVC: UIViewController {
  
  internal var viewModel: JobViewModelProtocol?
  
  init(withViewModel viewModel: JobViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: String(describing: JobVC.self), bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.tintColor = donlyColor
  }
  
}
