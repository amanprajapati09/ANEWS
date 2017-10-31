//
//  BullatineHeader.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/25/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class BullatineHeader: UITableViewHeaderFooterView, NibLoadableView, ReusableView {

    var delegate:HeaderClickDelegate?
    
    @IBAction func btnCategoryClick(_ sender: Any) {
        delegate?.didSelecteHeader(isRegion: false)
    }

}
