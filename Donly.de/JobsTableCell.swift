//
//  JobsTableCell.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/17/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class JobsTableCell: UITableViewCell {

  @IBOutlet private weak var jobCategoryImageView: UIImageView!
  @IBOutlet private weak var jobCategoryBackground: UIView!
  @IBOutlet private weak var jobTitleLabel: UILabel!
  @IBOutlet private weak var jobStatusLabel: UILabel!
  @IBOutlet private weak var jobStatusImageView: UIImageView!
  
  override func awakeFromNib() {
    self.jobCategoryBackground.layer.cornerRadius = self.jobCategoryBackground.frame.width / 2
  }
  
  func configureCell(forJob job: Job) {
    self.jobTitleLabel.text = job.title
    self.jobStatusLabel.text = job.status.getStatusName()
    self.jobCategoryBackground.backgroundColor = job.category.jobCategoryType.getColor()
    if let statusImage = UIImage(named: job.status.getImageName()) {
      self.jobStatusImageView.image = statusImage
    }
    if let categoryImage = UIImage(named: job.category.jobCategoryType.getImageName()) {
      self.jobCategoryImageView.image = categoryImage
    }
  }
  
}
