//
//  JobsVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/17/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class JobsVC: UIViewController {
  
  internal var viewModel: JobsViewModelProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  init(withViewModel viewModel: JobsViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: "JobsEmpty", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

}
