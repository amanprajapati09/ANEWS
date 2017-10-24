//
//  BullatineTableViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class BullatineTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    //MARK:- outlates
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnMobileNumber: UIButton!
    
    //MARK:- variables 
    var modelBullatine = ModelBulletin() {
        didSet {
            lblTitle.text = modelBullatine.title!
            lblDescription.text = modelBullatine.descriptionField!
            btnMobileNumber.titleLabel?.text = modelBullatine.mobileNo!
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
    
    @IBAction func btnReadMoreclick(_ sender: Any) {
    }
    
    @IBAction func btnMobileNoclick(_ sender: Any) {
    }
    
}
