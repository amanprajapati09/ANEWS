//
//  UIButtonExtension.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/14/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func setCornerRadious(corner:Int) {
        self.layer.cornerRadius = CGFloat(corner)
    }
}
