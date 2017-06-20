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
  
  @IBOutlet weak var jobSearchButton: UIButton!
  @IBAction func jobSearchButtonPressed(_ sender: UIButton!) {
    viewModel?.openAllJobsScreen()
  }
  
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
  
  override func viewWillAppear(_ animated: Bool) {
    setupJobSearchButton()
  }
  
  func setupJobSearchButton() {
    guard viewModel?.page == .myTasks else {
      self.jobSearchButton.isHidden = true
      return
    }
    self.jobSearchButton.isHidden = false
    self.jobSearchButton.setImage(UIImage(named: "icon_jobs_search_button"), for: .normal)
    self.jobSearchButton.imageEdgeInsets = UIEdgeInsets(top: 17, left: 0, bottom: 17, right: 28)
    self.jobSearchButton.tintColor = .white
    self.jobSearchButton.layer.cornerRadius = 5.0
    self.jobSearchButton.imageView?.contentMode = .scaleAspectFit
    self.jobSearchButton.contentVerticalAlignment = .center
    self.jobSearchButton.setTitle("Jobsuche", for: .normal)
    self.jobSearchButton.setTitleColor(.white, for: .normal)
  }

}
