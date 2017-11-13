//
//  JobTableViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var lblPostDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!    
    @IBOutlet weak var lblSalary: UILabel!
    @IBOutlet weak var lblNumberofPost: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblInterviewDate: UILabel!
    
    var modelJob:ModelJob! {
        didSet {
            lblTitle.text = modelJob.jobTitle
            lblSalary.text = "Salary : " + modelJob.salary
            lblNumberofPost.text = "Post : " + modelJob.noOfPost
            lblCompanyName.text = "Job in : " + modelJob.firmName
            lblInterviewDate.text = modelJob.interviewDate
            lblPostDate.text = "Posted on \(modelJob.modified)"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
