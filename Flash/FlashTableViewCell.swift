//
//  FlashTableViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class FlashTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    //MARK:- outlates
    @IBOutlet weak var imageFlash: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    //MARK:- variables
    var modelFlash:ModelFlash! {
        didSet {
            lblTitle.text = modelFlash.title
            lblDescription.text = modelFlash.descriptionField!
            lblDate.text = modelFlash.modified.convertToDateString()
            lblTime.text = modelFlash.modified.convertToTimeString()

            imageFlash.sd_setImage(with: modelFlash.imageUrl, placeholderImage: placeholdeImage!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
