//
//  ListingCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class ListingCollectionViewCell: UICollectionViewCell, UITableViewDataSource,UITableViewDelegate, NibLoadableView, ReusableView, UIScrollViewDelegate {
    
    var delegate:ItemSelection?
    var page = 1
    var totalPage = 0
    
    @IBOutlet weak var lblTitleMessage: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedCategory:Category?
    var selectedRegion:Category?
    var searchListText:String = ""
    
    var selectedFilter:FilterContainer? {
        didSet {
            selectedCategory = selectedFilter?.selectedCategory
            selectedRegion = selectedFilter?.selectedRegion
            if let obj = selectedFilter {
                searchListText = obj.searchText
            }
            filterUsingCategory()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
    }
    
    var filterList = [ModelList]() {
        didSet {
            tblView.reloadData()
            manageNoDataFoundMessage()
        }
    }
    
    func filterUsingCategory()  {
        
        guard searchListText.characters.count == 0 else {
            page = 1
            requestForFilter()
            return
        }
        
        if (selectedRegion == nil && selectedCategory == nil)  {
            
            if ModelRequestList.sharedObject.modelList.count == 0 {
                page = 1
                requestForFilter()
            } else {
                page = ModelRequestList.sharedObject.page
                filterList = ModelRequestList.sharedObject.modelList
            }
        } else {
            page = 1
            requestForFilter()
        }
    }
    
    
    //MARK:- UITableview datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListingTableViewCell.reuseIdentifier)   as! ListingTableViewCell
        cell.objList = filterList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    //MARK:- UITableview delegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelecteItem(item: filterList[indexPath.row])
    }
    
    //MARK:- Helper methods
    private func registerCell() {
        tblView.register(ListingTableViewCell.self)
        self.tblView.contentInset = UIEdgeInsetsMake(tableviewTopSpace, 0, 0, 0);
    }
    
    private func requestForFilter(isForPagination:Bool = false) {
        
        guard !checkForRequest() else {
            return
        }
        
        var param = [String:AnyObject]()
        
      
        param["page"] = page as AnyObject
        param["filter_name"] = searchListText as AnyObject
        
        if let categoryId = selectedCategory {
            param["category_id"] = categoryId.id! as AnyObject
        }
        
        if let regionId = selectedRegion {
            param["region_id"] = regionId.id! as AnyObject
        }
        
        if !isForPagination {
            showIndicator()
        }
        
        ModelRequestList.sharedObject.isRequestSend = true
        APIService.sharedInstance.list(parameters: param as [String : AnyObject], success: { (result) -> (Void) in
            self.hideIndicator()
            
            if (result.status) {
                
                self.parseForNilFilter(result: result, isForPagination: isForPagination)
                
                if !isForPagination {
                    self.filterList = result.modelList
                    
                } else {
                    self.filterList.append(contentsOf: result.modelList)
                }
                
                self.page = self.page + 1
                self.totalPage = result.totalPageCount
               
            } else {
                showTitleBarAlert(message: result.message)
                self.filterList = [ModelList]()
            }
            ModelRequestList.sharedObject.isRequestSend = false
        }) { (error) -> (Void) in
            showTitleBarAlert(message: error)
            self.hideIndicator()
            ModelRequestList.sharedObject.isRequestSend = false
        }
    }
    
    private func parseForNilFilter (result:ModelListMain, isForPagination:Bool) {
        
        if (selectedCategory == nil && selectedRegion == nil)  {
            
            if isForPagination {
                ModelRequestList.sharedObject.modelList.append(contentsOf: result.modelList)
            } else {
                ModelRequestList.sharedObject.modelList = result.modelList
            }
            
            ModelRequestList.sharedObject.page = page + 1
        }
    }
    
    //Check if requst is required or not
    private func checkForRequest() -> Bool {
        
        return ModelRequestList.sharedObject.isRequestSend
    }
    
    private func manageNoDataFoundMessage() {
        guard filterList.count > 0 else {
            tblView.isHidden = true
            lblTitleMessage.isHidden = false
            return
        }
        
        tblView.isHidden = false
        lblTitleMessage.isHidden = true
    }
    
    private func showIndicator() {
        activityIndicator.startAnimating()
        tblView.isHidden = true
    }
    
    private func hideIndicator() {
        activityIndicator.stopAnimating()
        tblView.isHidden = false
    }
    
    //MARK:- Scrollview delegate methods
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //Bottom Refresh
        
        if scrollView == tblView {
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                guard totalPage > 1 else {
                    return
                }
                if totalPage >= page {
                    requestForFilter(isForPagination: true)
                }
            }
        }
    }
}
