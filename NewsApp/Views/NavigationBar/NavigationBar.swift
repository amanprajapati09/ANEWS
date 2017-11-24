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
    var rightSearchItemClick : (() -> Void)? = nil
    var rightProfileItemClick : (() -> Void)? = nil
    
    var rightBarItemSearch:UIBarButtonItem?
    var rightBarItem:UIBarButtonItem?
    var profileBarItem:UIBarButtonItem?
    
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
            rightBarItem = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: #selector(rightButtonClick(sender:)))
          
            profileBarItem = UIBarButtonItem(image: UIImage(named: "NavigationProfile"), style: .plain, target: self, action: #selector(profileButtonClick(sender:)))
            
            rightBarItemSearch = UIBarButtonItem(image: UIImage.init(named: "search"), style: .plain, target: self, action: #selector(rightSearchButtonClick(sender:)))
            
            self.rightBarButtonItems = [rightBarItem!, profileBarItem!]
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
    
    internal func profileButtonClick(sender:UIBarButtonItem) {
        guard rightProfileItemClick != nil else {
            return
        }
        
        rightProfileItemClick!()
    }
    
    internal func rightSearchButtonClick(sender:UIBarButtonItem) {
        guard rightSearchItemClick != nil else {
            return
        }
        
        rightSearchItemClick!()
    }
    
    
    //Helper methods 
    func hideSearchBar()  {
        self.rightBarButtonItems = [rightBarItem!, profileBarItem!]
    }
    
    func showSearchBar() {
        self.rightBarButtonItems = [rightBarItem!, profileBarItem! ,rightBarItemSearch!]
    }
}
