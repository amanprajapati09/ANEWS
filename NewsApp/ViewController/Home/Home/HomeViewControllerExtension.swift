
//
//  HomeViewControllerExtension.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/26/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation
import SafariServices

extension HomeViewController {
    
    //MARK:- Delegate methods
    func didSelecteItem(item: ModelBaseHome) {
        
        if item.isKind(of: ModelFlash.self) {
            performSegue(withIdentifier: Segues.kFlashDetail, sender: item)
        } else if item.isKind(of: ModelList.self) {
            performSegue(withIdentifier: Segues.kListDetail, sender: item)
        } else if item.isKind(of: ModelJob.self) {
            performSegue(withIdentifier: Segues.kJobDetail, sender: item)
        } else if item.isKind(of: ModelBulletin.self) {
            let bulletine = item as! ModelBulletin
            openSafariview(urlString: bulletine.webLink)
        } else if item.isKind(of: ModelMedia.self) {
            let media = item as! ModelMedia
            openSafariview(urlString: media.link!)
        }
    }
    
    //MARK:- logout alert
    internal func askLogout() {
        let alert = UIAlertController(title: "Alert", message: "Are you sure want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        let actionOk = UIAlertAction(title: "OK", style: .default) { (action) in
            self.logout()
        }
        let Cancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        alert.addAction(Cancel)
        alert.addAction(actionOk)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    internal func logout() {
        clearUserDefault()
        UIApplication.shared.keyWindow?.rootViewController = MainainStoryboard.instantiateViewController(withIdentifier: StroryBoardIdentifier.landingScreenIdentifier)
    }
    
    private func openSafariview(urlString:String) {
        let safariVC = SFSafariViewController(url: URL(string: urlString)!)
        self.present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }

    //MARK:- Filter related mnethods 
    func didSelectHeaderItem() {
        //check condiotion if category data is availablew or not
        guard ModelCategorySingleTone.sharedObject.objCategory != nil else {
            return
        }
        
        guard !isRegion else {
              prepareCategory(categoryList: (ModelCategorySingleTone.sharedObject.objCategory?.data?.regionList)!)
            return
        }
        
        switch selectedMode {
        case .eBulletin:
            prepareCategory(categoryList: (ModelCategorySingleTone.sharedObject.objCategory?.data?.bullatineList)!)
            break;
            
        case .eJob:
            prepareCategory(categoryList: (ModelCategorySingleTone.sharedObject.objCategory?.data?.jobList)!)
            break;
            
        case .eListing:
            prepareCategory(categoryList: (ModelCategorySingleTone.sharedObject.objCategory?.data?.liostingList)!)
            
            break
        case .eMedia:
            prepareCategory(categoryList: (ModelCategorySingleTone.sharedObject.objCategory?.data?.mediaList)!)
            
            break;
        default:
            break
        }
        
    }
    
    private func prepareCategory(categoryList:[Category]) {
        performSegue(withIdentifier: Segues.categoryView, sender: categoryList)
    }
    
    internal func requestForCategory() {
        
        APIService.sharedInstance.CategoryList(parameters: nil, success: { (result) -> (Void) in
            self.addDefauldCategoryToAllList(result: result)
            ModelCategorySingleTone.sharedObject.objCategory = result
        }) { (error) -> (Void) in
            print("Error")
        }
    }
    
    private func addDefauldCategoryToAllList(result:CategoryMain) {
     
        result.data?.bullatineList?.insert(Category.defaultObject(), at: 0)
        result.data?.jobList?.insert(Category.defaultObject(), at: 0)
        result.data?.liostingList?.insert(Category.defaultObject(), at: 0)
        result.data?.mediaList?.insert(Category.defaultObject(), at: 0)
        result.data?.regionList?.insert(Category.defaultObject(), at: 0)
    }
    
    //MARK:- category selection delegate methods 
    func didSelectCagtegory(seletedCategory: Category) {
        
        if isRegion {
            if seletedCategory.id == nil {
                selectedFilter.selectedRegion = nil
                updateRegionLabel(title: "Region")
            } else {
                selectedFilter.selectedRegion = seletedCategory
                updateRegionLabel(title: seletedCategory.name!)
            }
            
        } else {
            if seletedCategory.id == nil {
                selectedFilter.selectedCategory = nil
                updateCategoryLabel(title: "Category")
            } else {
                selectedFilter.selectedCategory = seletedCategory
                updateCategoryLabel(title: seletedCategory.name!)
            }            
        }
        
        homeCollectionContainer.selectedFilter = selectedFilter
    }
    
    internal func resetCategoryandregion() {
        homeCollectionContainer.selectedRegion = nil
        updateRegionLabel(title: "Region")
        homeCollectionContainer.selectedCategory = nil
        updateCategoryLabel(title: "Category")
    }
    
    private func updateCategoryLabel(title:String) {
        lblCategory.text = title
    }
    
    private func updateRegionLabel(title:String) {
        lblRegion.text = title
    }
    
    //MARK:- Helper Method
    func UIChangesAsPerIndexSelection(index:Int) {
        switch index {
        case 0:
            self.headerViewHeightConstraint.constant = 0.0
            selectedMode = .eFlash
            break
        case 1:
            self.headerViewHeightConstraint.constant = 45.0
            self.categoryRegionBothVisible(flag: true)
            HorizontalSpaceVisiblie(flag: true)
            self.categoryRegionWith(color: UIColor.black)
            selectedMode = .eListing
            break
        case 2:
            self.headerViewHeightConstraint.constant = 45.0
            self.categoryRegionBothVisible(flag: false)
            HorizontalSpaceVisiblie(flag: false)
            self.categoryRegionWith(color: UIColor.black)
            selectedMode = .eBulletin
            break
        case 3:
            self.headerViewHeightConstraint.constant = 89.0
            self.categoryRegionBothVisible(flag: true)
            HorizontalSpaceVisiblie(flag: true)
            self.categoryRegionWith(color: UIColor.lightGray)
            selectedMode = .eJob
            break
        case 4:
            self.headerViewHeightConstraint.constant = 45.0
            self.categoryRegionBothVisible(flag: false)
            HorizontalSpaceVisiblie(flag: false)
            self.categoryRegionWith(color: UIColor.black)
            selectedMode = .eMedia
            break
        default:
            break
        }
        self.view.layoutIfNeeded()
    }
    
    func HorizontalSpaceVisiblie(flag:Bool){
        if flag {
            self.horizontalSpaceBetweenRegion_Category.constant = 5
        }
        else {
            self.horizontalSpaceBetweenRegion_Category.constant = 0
        }
    }
    
    func categoryRegionBothVisible(flag:Bool) {
        if flag {
            self.categoryRegionEqualConstraint.isActive = true
            self.regionWidthConstraint.isActive = false
            self.regionWidthConstraint.constant = 0
        }
        else {
            self.categoryRegionEqualConstraint.isActive = false
            self.regionWidthConstraint.isActive = true
            self.regionWidthConstraint.constant = 0
        }
        self.view.layoutIfNeeded()
    }
    
    func categoryRegionWith(color:UIColor)
    {
        self.categoryView.backgroundColor = color
        self.regionView.backgroundColor = color
    }
}
