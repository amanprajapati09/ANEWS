//
//  JobDetailTableViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 11/3/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class JobDetailTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblvalue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
