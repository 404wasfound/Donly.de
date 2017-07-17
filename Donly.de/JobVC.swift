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
  
  /// outlets
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var jobTypeLabel: UILabel!
  @IBOutlet weak var jobTypeImageView: UIImageView!
  @IBOutlet weak var jobStatusLabel: UILabel!
  @IBOutlet weak var jobStatusImageView: UIImageView!
  @IBOutlet weak var jobAddressLabel: UILabel!
  @IBOutlet weak var jobAddressImageView: UIImageView!
  @IBOutlet weak var jobDateLabel: UILabel!
  @IBOutlet weak var jobDateImageView: UIImageView!
  
  internal var viewModel: JobViewModelProtocol?
  private var disposeBag = DisposeBag()
  
  init(withViewModel viewModel: JobViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: String(describing: JobVC.self), bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel?.getJobDetails()
    setupBindings()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.tintColor = donlyColor
  }
  
  func setupBindings() {
    self.viewModel?.job.asObservable().bind(onNext: { job in
      if let newJob = job {
        self.setupUIForJob(newJob)
      }
    }).addDisposableTo(disposeBag)
  }
  
  func setupUIForJob(_ job: Job) {
    self.titleLabel.text = job.title
    self.descriptionLabel.text = job.description
    self.priceLabel.text = String(describing: job.cost.costValue)
    self.jobTypeLabel.text = job.category.jobCategoryType.getCategoryName()
    if let categoryImage = UIImage(named: job.category.jobCategoryType.getImageName()) {
      self.jobTypeImageView.image = categoryImage
    }
    if let statusImage = UIImage(named: job.status.getImageName()) {
      self.jobStatusImageView.image = statusImage
    }
  }
  
  func reloadData() {
    /// needed if the app goes to foreground on that particular page
  }
  
}
