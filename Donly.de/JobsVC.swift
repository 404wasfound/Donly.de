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
import TwicketSegmentedControl
import MapKit

protocol JobsVCProtocol {
  func endRefreshing()
}

class JobsVC: UIViewController {
  
  @IBOutlet weak var jobsTable: UITableView!
  @IBOutlet weak var jobSearchButton: UIButton!
  @IBAction func jobSearchButtonPressed(_ sender: UIButton!) {
    viewModel?.openAllJobsScreen()
  }
  @IBOutlet weak var reloadButton: ReloadButton!
  @IBAction func reloadButtonPressed(_ sender: UIButton) {
    self.reloadData()
  }
  @IBOutlet weak var buttonsStackWidth: NSLayoutConstraint!
  
  internal var viewModel: JobsViewModelProtocol?
  internal var disposeBag = DisposeBag()
  internal var listMapSwitch = TwicketSegmentedControl()
  internal var mapView: MKMapView?
  internal var mainViewConfigured: Bool = false
  internal var emptyView: UIView!
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
    setupEmptyView()
    setupBindings()
  }
  
  func setupEmptyView() {
    self.emptyView = UIView(frame: self.view.frame)
    self.emptyView.backgroundColor = .white
    self.view.addSubview(self.emptyView)
  }
  
  func setupBindings() {
    viewModel?.jobs.asObservable().bind(onNext: { jobs in
      if let newJobs = jobs {
        guard !newJobs.isEmpty else {
          self.emptyView.removeFromSuperview()
          return
        }
        if self.mainViewConfigured {
          self.jobsTable.reloadData()
        } else {
          self.configureMainView()
        }
      }
    }).addDisposableTo(disposeBag)
  }
  
  func configureMainView() {
    DispatchQueue.main.async {
      let nib = UINib(nibName: String(describing: JobsVC.self), bundle: nil)
      if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
        self.configureTable()
        self.configureListMapSwitchView()
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
  
  func configureListMapSwitchView() {
    if self.viewModel?.page == .myTasks {
      self.listMapSwitch.isHidden = true
    } else {
      let segments = ["List", "Map"]
      let frame = CGRect(x: self.view.center.x - 150, y: 4, width: 300, height: 30)
      self.listMapSwitch.frame = frame
      self.listMapSwitch.setSegmentItems(segments)
      self.listMapSwitch.delegate = self
      self.listMapSwitch.sliderBackgroundColor = donlyColor
      self.listMapSwitch.backgroundColor = UIColor.clear
      self.listMapSwitch.isSliderShadowHidden = true
      self.view.addSubview(self.listMapSwitch)
      self.jobsTable.contentInset = UIEdgeInsetsMake(46, 0, 0, 0)
    }
  }
  
  func configureTable() {
    self.jobsTable.delegate = self
    self.jobsTable.dataSource = self
    self.jobsTable.register(UINib(nibName: String(describing: JobsTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: JobsTableCell.self))
    self.jobsTable.addSubview(self.refreshControl)
    self.jobsTable.allowsMultipleSelectionDuringEditing = true
    self.jobsTable.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    self.jobsTable.tableFooterView?.isHidden = true
    self.jobsTable.backgroundColor = lightGrayColor
  }
  
  func setupJobSearchButton() {
    guard viewModel?.page == .myTasks else {
      self.jobSearchButton.isHidden = true
      self.buttonsStackWidth.constant = 150
      return
    }
    self.buttonsStackWidth.constant = 300
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
    guard let job = self.viewModel?.jobs.value?[indexPath.row] else {
      return
    }
    tableView.deselectRow(at: indexPath, animated: true)
    self.viewModel?.openJob(job.id)
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
  
  func reloadData() {
    self.viewModel?.getJobs(forPull: false)
  }
  
}

extension JobsVC: JobsVCProtocol, TwicketSegmentedControlDelegate {
  
  func endRefreshing() {
    print("Refresh is done!")
    self.refreshMainView()
    refreshControl.endRefreshing()
    self.mapView = nil
  }
  
  func refreshMainView() {
    if let jobs = viewModel?.jobs.value, jobs.isEmpty {
      let nib = UINib(nibName: "JobsEmpty", bundle: nil)
      if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
        self.view = view
        self.mainViewConfigured = false
      }
    }
  }
  
  func didSelect(_ segmentIndex: Int) {
    if segmentIndex == 1 {
      if let _ = self.mapView {
        self.mapView?.isHidden = false
      } else {
        self.mapView = MKMapView()
        self.mapView?.frame = self.jobsTable.frame
        guard let map = self.mapView else {
          return
        }
        self.view.addSubview(map)
        self.view.bringSubview(toFront: self.listMapSwitch)
        map.isHidden = false
      }
    } else {
      if let _ = self.mapView {
        self.mapView?.isHidden = true
      }
    }
  }
  
}
