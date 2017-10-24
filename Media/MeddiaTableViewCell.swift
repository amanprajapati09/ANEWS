//
//  MeddiaTableViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class MeddiaTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var imageMedia: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!    
    @IBOutlet weak var lblDescription: UILabel!
    
    var modelMedia = ModelMedia() {
        didSet {
            lblTitle.text = modelMedia.title!
            lblDescription.text = modelMedia.descriptionField!            
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
