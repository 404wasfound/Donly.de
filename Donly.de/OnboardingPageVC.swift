//
//  OnboardingPageVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 3/30/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class OnboardingPageVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  var pages: [Page] = [.first, .second, .third]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
    self.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    let controller = OnboardingVC(page: .first, delegate: self)
    setViewControllers([controller], direction: .forward, animated: true, completion: nil)
  }

  //MARK: UIPageControl and DataSource methods.
  public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    if let identifier = viewController.restorationIdentifier {
      if let page = Page(rawValue: identifier), let index = pages.index(of: page) {
        if index > 0 {
          return OnboardingVC(page: pages[index - 1], delegate: self)
        }
      }
    }
    return nil
  }
  
  public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    if let identifier = viewController.restorationIdentifier {
      if let page = Page(rawValue: identifier), let index = pages.index(of: page) {
        if index < pages.count - 1 {
          return OnboardingVC(page: pages[index + 1], delegate: self)
        }
      }
    }
    return nil
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return pages.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    if let identifier = viewControllers?.first?.restorationIdentifier {
      if let page = Page(rawValue: identifier), let index = pages.index(of: page) {
        return index
      }
    }
    return 0
  }
  
  //MARK: UI adjustment
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    for view in view.subviews {
      if view is UIScrollView {
        view.frame = UIScreen.main.bounds
      } else if view is UIPageControl {
        view.backgroundColor = UIColor.clear
      }
    }
  }
}

/// Protocol for communication viewModel -> PageVC
protocol OnboardingPageProtocol {
  func performSegueToMainBoard()
}
/// Extension which implemets protocol
extension OnboardingPageVC: OnboardingPageProtocol {
  func performSegueToMainBoard() {
    performSegue(withIdentifier: "segueToMainBoard", sender: nil)
  }
}
