//
//  ReviewTableViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit
import HCSStarRatingView

class ReviewTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var lblTitle: UILabel!    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var ratingView: HCSStarRatingView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var modelRating: ModelRatingData! {
        didSet {
            lblTitle.text = (modelRating.userName?.characters.count)! > 0 ? modelRating.userName! : "-"
            lblDescription.text = (modelRating.review?.characters.count)! > 0 ? modelRating.review! : "-"
            ratingView.value = CGFloat(modelRating.rateValue.floatValue)
        }
    }    
}
