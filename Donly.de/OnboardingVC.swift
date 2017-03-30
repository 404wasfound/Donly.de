//
//  OnboardingVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 3/30/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class OnboardingVC: UIViewController {

  @IBOutlet private var textLabel: UILabel!
  @IBOutlet private var button: UIButton!
  
  private let viewModel: OnboardingViewModelProtocol
  private let disposeBag = DisposeBag()
  
  init(viewModel: OnboardingViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: String(describing: OnboardingVC.self), bundle: nil)
  }
  
  convenience init(page: Page) {
    self.init(viewModel: OnboardingViewModel(page: page))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupBindings()
    self.setRestorationID()
  }
  
  func setupBindings() {
    self.viewModel.text.asObservable()
    .bindTo(self.textLabel.rx.text)
    .addDisposableTo(disposeBag)
  }
  
  func setRestorationID() {
    self.restorationIdentifier = self.viewModel.page.rawValue
  }
  
}
