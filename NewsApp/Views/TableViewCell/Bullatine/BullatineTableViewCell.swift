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
    
    @IBOutlet weak var btnReadMore: UIButton!
    //MARK:- variables 
    var modelBullatine = ModelBulletin() {
        didSet {
            lblTitle.text = modelBullatine.title
            lblDescription.text = modelBullatine.descriptionField
            btnMobileNumber.setTitle(modelBullatine.mobileNo, for: .normal)
            prepareForLanguage()
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
    
    private func prepareForLanguage() {
        btnReadMore.setTitle(localizedShared?.localizedString(forKey: "link_read_more"), for: .normal)
    }
    
    @IBAction func btnReadMoreclick(_ sender: Any) {
    }
    
    @IBAction func btnMobileNoclick(_ sender: Any) {
        if let url = URL(string: "tel://\(modelBullatine.mobileNo)"), UIApplication.shared.canOpenURL(url) {
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
