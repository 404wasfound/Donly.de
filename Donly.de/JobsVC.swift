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

protocol JobsVCProtocol {
  func endRefreshing()
}

class JobsVC: UIViewController {
  
  @IBOutlet weak var jobsTable: UITableView!
  @IBOutlet weak var listMapSwitch: UISegmentedControl!
  @IBOutlet weak var listMapSwitchContainer: UIView!
  @IBOutlet weak var jobSearchButton: UIButton!
  @IBAction func jobSearchButtonPressed(_ sender: UIButton!) {
    viewModel?.openAllJobsScreen()
  }
  
  internal var viewModel: JobsViewModelProtocol?
  internal var disposeBag = DisposeBag()
  lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(JobsVC.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
    return refreshControl
  }()
  
  init(withViewModel viewModel: JobsViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: "JobsEmpty", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel?.delegate = self
    viewModel?.getJobs(forPull: false)
    setupJobSearchButton()
    setupBindings()
  }
  
  func setupBindings() {
    viewModel?.jobs.asObservable().bind(onNext: { jobs in
      if let _ = jobs {
        DispatchQueue.main.async {
          let nib = UINib(nibName: String(describing: JobsVC.self) , bundle: nil)
          if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
            if self.viewModel?.page == .myTasks {
              self.listMapSwitchContainer.isHidden = true
            }
          }
          self.configureTable()
        }
      }
    }).addDisposableTo(disposeBag)
  }
  
  func configureTable() {
    self.jobsTable.delegate = self
    self.jobsTable.dataSource = self
    self.jobsTable.register(UINib(nibName: String(describing: JobsTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: JobsTableCell.self))
    self.jobsTable.addSubview(self.refreshControl)
    self.jobsTable.allowsMultipleSelectionDuringEditing = true
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

extension JobsVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: JobsTableCell.self), for: indexPath) as? JobsTableCell, let jobs = viewModel?.jobs.value else {
      return UITableViewCell()
    }
    cell.configureCell(forJob: jobs[indexPath.row])
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let jobs = viewModel?.jobs.value else {
      return 0
    }
    return jobs.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80.0
  }
  
  func handleRefresh(refreshControl: UIRefreshControl) {
    viewModel?.getJobs(forPull: true)
  }
  
}

extension JobsVC: JobsVCProtocol {
  
  func endRefreshing() {
    print("Refresh is done!")
    jobsTable.reloadData()
    refreshControl.endRefreshing()
  }
  
}
