//
//  STVSegmentButton.swift
//  SollywoodTV
//
//  Created by Aman Prajapati on 22/12/16.
//  Copyright © 2016 codalmacmini3. All rights reserved.
//

import Foundation
import UIKit

class STVSegmentButtonView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    typealias segmentButtonClick = ( _ index:Int) -> Void
    
    let cellIdentifier = "STVSegmentButtonCellIdentifier"
    let cellClassName = "STVSegmentButtonCell"
    
    //MARK: Inspectable variables
    @IBInspectable var buttonArray = [String]()
    @IBInspectable var spaceBetweenCell : CGFloat = 10
    
    @IBInspectable var selectedCellLineColor : UIColor = UIColor().colorWithHexString(hexString: "#100031", alpha: 1)
    @IBInspectable var notSelectedCellLineColor : UIColor = UIColor.clear
    @IBInspectable var selectedTextColor: UIColor = UIColor().colorWithHexString(hexString: "#100031", alpha: 1)
    @IBInspectable var nonSelectedTextColor: UIColor = UIColor().colorWithHexString(hexString: "#0000FF", alpha: 1)
    
    @IBInspectable var selectedFont: UIFont = UIFont.systemFont(ofSize: 15)
    @IBInspectable var nonSelectedFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    let kCellDefaultHeight : CGFloat = 42
    let kCellDefaultWidthAddition : CGFloat = 35
    
    var segmentButtonClickAtIndex : segmentButtonClick?
    
    var selectedIndex : Int = 0
    
    //MARK: private variables
    var buttonCollectionView : UICollectionView?
    
    //MARK: View override Method
    override func layoutSubviews() {
        
        // check if collectionview is allocated one time then not create this another time
        if buttonCollectionView == nil {
            intializeCollectionView()
            registerCell()
        }
    }
    
    // function to set clouser to get button selection
    func segmentButtonSelectAtIndex(complition:@escaping segmentButtonClick)  {
        self.segmentButtonClickAtIndex = complition
    }
    
    //MARK:- Collectionview Datasource Methods
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: STVSegmentButtonCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! STVSegmentButtonCell
        
        cell.lblButtonTitle.text = buttonArray[indexPath.row]
        
        // condition for select - deselect cell
        if selectedIndex == indexPath.row {
            cell.lblButtonTitle.font = selectedFont
            cell.lblButtonTitle.textColor = selectedTextColor
            cell.sliderView.backgroundColor = selectedCellLineColor
            
        } else {
            cell.lblButtonTitle.font = nonSelectedFont
            cell.lblButtonTitle.textColor = nonSelectedTextColor
            cell.sliderView.backgroundColor = notSelectedCellLineColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonArray.count
    }
    
    //MARK:- Collectionview Dataflow Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if selectedIndex == indexPath.row {
            return getSizeofCell(value:buttonArray[indexPath.row],font: selectedFont)
        }
        else{
            return getSizeofCell(value:buttonArray[indexPath.row],font: nonSelectedFont)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let totalCellWidth = getTotalSizeOfCell()
        
        // check if total width is greater then collectionview then not need to center cell
        guard totalCellWidth <= collectionView.frame.size.width else {
            return UIEdgeInsetsMake(0, 0, 0, 0)
        }
        
        // measure how much space need to make all cell in center
        let leftInset = ((buttonCollectionView?.frame.size.width)! - totalCellWidth) / 2
        let rightInset = leftInset
        
        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
        
    }
    
    //MARK:- Collectionview Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if segmentButtonClickAtIndex != nil {
            segmentButtonClickAtIndex!(indexPath.row)
        }
    
        selectedIndex = indexPath.row
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    //MARK:- Other methods
    func registerCell()  {
        
        buttonCollectionView?.register(UINib(nibName: cellClassName, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    //MARK:- width for discover genere cell
    func getSizeofCell(value:String, font: UIFont) -> CGSize {
        
        // getting the width of required text
        let attributes = NSDictionary(object: font, forKey:"UIFont" as NSCopying)
        var size =  CGSize(width: value.size(attributes: (attributes as! [String : AnyObject])).width , height: kCellDefaultHeight)
        
        size.width += kCellDefaultWidthAddition
        
        return size
    }
    
    // Method to get Total size of cell
    func getTotalSizeOfCell() -> CGFloat {
        
        var totalSize : CGFloat = 0
        
        var count = 0
        
        for labelString : String in buttonArray
        {
            if count == selectedIndex {
                totalSize += getSizeofCell(value: labelString, font: selectedFont).width + spaceBetweenCell
            }
            else {
                totalSize += getSizeofCell(value: labelString, font: nonSelectedFont).width + spaceBetweenCell
            }
            count += 1
        }
        return totalSize
    }
    
    //Method to set collectionview layout params
    func intializeCollectionView()  {
        
        // Create layout with horizontal scrolling
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = spaceBetweenCell
        
        let collectionViewFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        // initilize collectionview using layout and frame
        buttonCollectionView = UICollectionView.init(frame: collectionViewFrame, collectionViewLayout: layout)
        
        buttonCollectionView?.dataSource = self
        buttonCollectionView?.delegate = self
        buttonCollectionView?.showsHorizontalScrollIndicator = false
        buttonCollectionView?.showsVerticalScrollIndicator = false
        buttonCollectionView?.backgroundColor = UIColor.clear
        
        self.addSubview(buttonCollectionView!)
    }
    
    //Method to set index forcefully
    func setSelectedButtonAtIndex(index:Int)    {
        
        selectedIndex = index
        buttonCollectionView?.reloadData()
    }
}


