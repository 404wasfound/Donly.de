//
//  SplashViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol SplashViewModelProtocol {
  var nextPage: Variable<SplashScene.Route?> { get set }
  var delegate: SplashVCProtocol? { get set }
  func configureNext()
}

final class SplashViewModel: SplashViewModelProtocol {
  var nextPage = Variable<SplashScene.Route?>(nil)
  var delegate: SplashVCProtocol?
  var disposeBag = DisposeBag()
  init() {
    appData.readUserData()
  }
}

extension SplashViewModel {
  func configureNext() {
    if appSet.onboardingShown {
      if let userData = appData.userData {
        self.getUserData(forId: userData.userId, withToken: userData.token)
      } else {
        self.nextPage.value = SplashScene.Route.login
      }
    } else {
      self.nextPage.value = SplashScene.Route.onboarding
    }
  }
  
  func getUserData(forId id: Int, withToken token: String) {
    let userDataRequest = UserDataAPIRequest(withUserId: id)
    delegate?.showIndicator()
    userDataRequest.send().subscribe(onNext: { result in
      switch result {
      case .success(var user):
        user.token = token
        appData.user = user
        self.nextPage.value = SplashScene.Route.main
      case .failure(let error):
        print("Something is wrong here! Here goes the error: (\(error.localizedDescription))")
      }
    }, onError: { error in
      //
    }, onCompleted: { 
      self.delegate?.hideIndicator()
    }).addDisposableTo(disposeBag)
  }
  
}
