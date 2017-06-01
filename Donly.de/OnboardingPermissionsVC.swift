//
//  OnboardingPermissionsVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 5/13/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

protocol OnboardingPermissionsVCProtocol {
  func navigateTo(vc: UIViewController)
}

class OnboardingPermissionsVC: UIViewController {
  
  @IBOutlet private weak var logoImageCenter: UIImageView!
  @IBOutlet private weak var logoImageLeft: UIImageView!
  @IBOutlet private weak var logoImageRight: UIImageView!
  @IBOutlet private weak var permissionsTitle: UILabel!
  @IBOutlet private weak var permissionsDescription: UILabel!
  @IBOutlet private weak var permissionsCancelButton: OnboardingButton!
  @IBAction private func permissionsCancelButtonPressed(_ sender: UIButton) {
    viewModel?.cancelButtonPressed(delegate: self)
  }
  @IBOutlet private weak var permissionsAcceptedButton: OnboardingButton!
  @IBAction private func permissionsAcceptedButtonPressed(_ sender: UIButton) {
    viewModel?.acceptButtonPressed(delegate: self)
  }
  
  internal var viewModel: OnboardingPermissionsViewModelProtocol?
  
  init(withViewModel viewModel: OnboardingPermissionsViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: String(describing: OnboardingPermissionsVC.self), bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: animated)
    setupUI()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func setupUI() {
    self.logoImageCenter.image = viewModel?.onboardingPermissionsImageSet.center
    self.logoImageLeft.image = viewModel?.onboardingPermissionsImageSet.left
    self.logoImageRight.image = viewModel?.onboardingPermissionsImageSet.right
    self.permissionsTitle.text = viewModel?.onboardingInfoElement.title
    self.permissionsDescription.text = viewModel?.onboardingInfoElement.description
    guard let model = viewModel else {
      fatalError("Failed to configure button.")
    }
    self.permissionsCancelButton.configure(button: .cancel, title: model.onboardingPermissionsButtons.cancel)
    self.permissionsAcceptedButton.configure(button: .accept, title: model.onboardingPermissionsButtons.accept)
  }
  
}

extension OnboardingPermissionsVC: OnboardingPermissionsVCProtocol {
  
  func navigateTo(vc: UIViewController) {
    navigationController?.pushViewController(vc, animated: true)
  }
}
