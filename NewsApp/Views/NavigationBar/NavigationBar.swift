//
//  NavigationBar.swift
//  ACTIVATE
//
//  Created by Aman Prajapati on 14/04/17.
//  Copyright © 2017 Codal. All rights reserved.
//

import UIKit

@IBDesignable
class NavigationBar: UINavigationItem {

    var leftItemClick : (() -> Void)? = nil
    var rightItemClick : (() -> Void)? = nil
    
    
    //MARK:- titlebar imageview variables
    ///Set left button image
    @IBInspectable var leftButtonImage : UIImage? = nil {
        didSet {
            let leftBarItem = UIBarButtonItem(image: leftButtonImage, style: .plain, target: self, action: #selector(leftButtonClick(sender:)))
            self.leftBarButtonItem = leftBarItem
            self.leftBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    ///Set right button image
    @IBInspectable var rightButtonImage : UIImage? = nil {
        didSet {
            let rightBarItem = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: #selector(rightButtonClick(sender:)))
            self.rightBarButtonItem = rightBarItem
            self.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    ///Set title image
    @IBInspectable var titleImage : UIImage? = nil {
        didSet {
            self.titleView = UIImageView(image: titleImage)
        }
    }

    //MARK:- button click
    internal func leftButtonClick(sender:UIBarButtonItem) {
        guard leftItemClick != nil else {
            return
        }
        
        leftItemClick!()
    }
    
    internal func rightButtonClick(sender:UIBarButtonItem) {
        guard rightItemClick != nil else {
            return
        }
        
        rightItemClick!()
    }
}
