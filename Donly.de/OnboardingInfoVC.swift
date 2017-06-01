//
//  OnboardingInfoVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 5/13/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class OnboardingInfoVC: UIViewController {
  
  @IBOutlet private weak var firstElementTitle: UILabel!
  @IBOutlet private weak var firstElementDescription: UILabel!
  
  @IBOutlet private weak var secondElementTitle: UILabel!
  @IBOutlet private weak var secondElementDescription: UILabel!
  
  @IBOutlet private weak var thirdElementTitle: UILabel!
  @IBOutlet private weak var thirdElementDescription: UILabel!
  
  @IBOutlet private weak var nextButton: UIButton!
  @IBAction private func nextButtonPressed(_ sender: UIButton) {
    navigateToNextVC()
  }
  
  internal var viewModel: OnboardingInfoViewModelProtocol?
  
  init(withViewModel viewModel: OnboardingInfoViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: String(describing: OnboardingInfoVC.self), bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()
  }
  
  func setupUI() {
    self.firstElementTitle.text = viewModel?.firstElement.title
    self.firstElementDescription.text = viewModel?.firstElement.description
    self.secondElementTitle.text = viewModel?.secondElement.title
    self.secondElementDescription.text = viewModel?.secondElement.description
    self.thirdElementTitle.text = viewModel?.thirdElement.title
    self.thirdElementDescription.text = viewModel?.thirdElement.description
  }
  
  func navigateToNextVC() {
    let nextVC = OnboardingPermissionsScene.configure(forPage: .notifications)
    navigationController?.pushViewController(nextVC, animated: true)
  }
  
}
