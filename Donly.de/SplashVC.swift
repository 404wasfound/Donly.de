//
//  SplashVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit
import RxSwift

protocol SplashVCProtocol {
  func showIndicator()
  func hideIndicator()
}

class SplashVC: UIViewController {

  @IBOutlet private weak var logo: UIImageView!
  
  private var viewModel: SplashViewModelProtocol
  private var router: SplashRouter
  private var disposeBag = DisposeBag()
  
  init(withViewModel viewModel: SplashViewModelProtocol) {
    self.viewModel = viewModel
    self.router = SplashRouter(withViewModel: viewModel)
    super.init(nibName: String(describing: SplashVC.self), bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.viewModel.delegate = self
    self.viewModel.configureNext()
    self.setupBindings()
  }
  
  func setupBindings() {
    viewModel.nextPage.asObservable()
      .bind(onNext: { _ in
        self.setupFirstScene()
      }).addDisposableTo(disposeBag)
  }
  
  func setupFirstScene() {
    router.route()
  }
  
}

extension SplashVC: SplashVCProtocol {
  
  func showIndicator() {
    self.showActivityIndicator(withColor: .white)
  }
  
  func hideIndicator() {
    self.hideActivityIndicator()
  }
  
}
