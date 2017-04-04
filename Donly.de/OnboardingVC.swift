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
  @IBOutlet private var button: CustomButton!
  
  private let viewModel: OnboardingViewModelProtocol
  private let disposeBag = DisposeBag()
  
  init(viewModel: OnboardingViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: String(describing: OnboardingVC.self), bundle: nil)
  }
  
  convenience init(page: Page, delegate: OnboardingPageProtocol) {
    self.init(viewModel: OnboardingViewModel(page: page, delegate: delegate))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupBindings()
  }
  
  func setupBindings() {
    self.viewModel.text.asObservable()
      .bindTo(self.textLabel.rx.text)
      .addDisposableTo(disposeBag)
    self.viewModel.page.asObservable()
      .bindNext({ page in
        self.restorationIdentifier = page.rawValue
        switch page {
        case .first:
          self.button.isHidden = true
        case .second:
          self.button.setupButtonWith(title: "LOCATION", image: UIImage(named: "loc_donly"))
        case .third:
          self.button.setupButtonWith(title: "NOTIFICATIONS", image: UIImage(named: "notifs_donly"))
        case .fourth:
          self.button.setupButtonWith(title: "NEXT SCREEN")
        }
      })
      .addDisposableTo(disposeBag)
    self.button.rx.tap
      .subscribe(onNext: {
        switch self.viewModel.page.value {
        case .second:
          self.viewModel.requestLocation()
        case.third:
          self.viewModel.requestNotifications()
        case.fourth:
          self.viewModel.segueToMainBoard()
        default:()
        }
      })
      .addDisposableTo(disposeBag)
  }
}
