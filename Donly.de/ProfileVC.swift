//
//  ProfileVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/11/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit
import Kingfisher

protocol ProfileVCProtocol {
  func navigateTo(vc: UIViewController)
}

class ProfileVC: UIViewController {
  
  @IBOutlet private weak var profileImageView: UIImageView!
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var emailLabel: UILabel!
  @IBOutlet private weak var logoutButton: UIButton!
  @IBAction private func logoutButtonPressed(_ sender: UIButton) {
    self.viewModel?.logoutCurrentUser()
  }
  
  internal var viewModel: ProfileViewModelProtocol?
  
  init(withViewModel viewModel: ProfileViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: String(describing: ProfileVC.self), bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.viewModel?.delegate = self
    configureMainView()
    setupBindings()
  }
  
  func setupBindings() {
    ///
  }
  
  func configureMainView() {
    guard let currentUser = appData.user else {
      print("Something went completely wrong!")
      return
    }
    self.nameLabel.text = currentUser.fullName
    self.emailLabel.text = currentUser.email
    let profileImageUrl = URL(string: currentUser.imagePath)
    self.profileImageView.kf.setImage(with: profileImageUrl)
    self.profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    self.logoutButton.layer.cornerRadius = 5.0
    self.logoutButton.backgroundColor = donlyColor
  }
  
}

extension ProfileVC: ProfileVCProtocol {
  
  func navigateTo(vc: UIViewController) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window?.rootViewController = vc
    appDelegate.window?.makeKeyAndVisible()
  }
  
}
