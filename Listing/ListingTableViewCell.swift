//
//  ListingTableViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class ListingTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var imageList: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    var objList:ModelList! {
        didSet {
            lblTitle.text = objList.title 
            lblDescription.text = objList.descriptionField
            lblAddress.text = objList.address
            imageList.sd_setImage(with: objList.imageUrl, placeholderImage: placeholdeImage!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func btnDirectCallClick(_ sender: Any) {
        
    }
}
