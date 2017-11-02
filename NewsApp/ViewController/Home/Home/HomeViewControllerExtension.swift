
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
        result.data?.bullatineList?[0] = Category.defaultObject()
        result.data?.jobList?[0] = Category.defaultObject()
        result.data?.liostingList?[0] = Category.defaultObject()
        result.data?.mediaList?[0] = Category.defaultObject()
        result.data?.regionList?[0] = Category.defaultObject()
    }
    
    //MARK:- category selection delegate methods 
    func didSelectCagtegory(seletedCategory: Category) {
        
        if isRegion {
            if seletedCategory.id == nil {
                homeCollectionContainer.selectedRegion = nil
                updateRegionLabel(title: "Region")
            } else {
                homeCollectionContainer.selectedRegion = seletedCategory
                updateRegionLabel(title: seletedCategory.name!)
            }
            
        } else {
            if seletedCategory.id == nil {
             homeCollectionContainer.selectedCategory = nil
                updateCategoryLabel(title: "Category")
            } else {
                homeCollectionContainer.selectedCategory = seletedCategory
                updateCategoryLabel(title: seletedCategory.name!)
            }            
        }
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
}
