//
//  ListingTableViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit
import HCSStarRatingView

class ListingTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var imageList: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var ratingView: HCSStarRatingView!
    @IBOutlet weak var lblDirectCall: UILabel!
    
    var objList:ModelList! {
        didSet {
            lblTitle.text = objList.title 
            lblDescription.text = objList.descriptionField
            lblAddress.text = objList.address
            imageList.sd_setImage(with: objList.imageUrl, placeholderImage: placeholdeImage!)
            ratingView.value = CGFloat(objList.totalRating)
            prepareForLanguage()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func prepareForLanguage() {
        lblDirectCall.text = localizedShared?.localizedString(forKey: "text_direct_call")
    }
    
    @IBAction func btnDirectCallClick(_ sender: Any) {
        if let url = URL(string: "tel://\(objList.mobileNo)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            showNotificationAlert(type: .error, title: "", message: "Call not available!")
        }
    }
}
