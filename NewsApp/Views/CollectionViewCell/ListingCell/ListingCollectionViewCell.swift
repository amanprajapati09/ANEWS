//
//  ListingCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class ListingCollectionViewCell: UICollectionViewCell, UITableViewDataSource,UITableViewDelegate, NibLoadableView, ReusableView {
    
    var delegate:ItemSelection?
    var page = 1
    var totalPage = 0
    
    @IBOutlet weak var lblTitleMessage: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedCategory:Category? {
        didSet{
            filterUsingCategory()
        }
    }
    
    var selectedRegion:Category? {
        didSet {
            filterUsingCategory()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        requestForList()
    }
    
    var List = [ModelList]() {
        didSet {
            tblView.reloadData()
            manageNoDataFoundMessage()
        }
    }
    
    var filterList = [ModelList]() {
        didSet {
            tblView.reloadData()
            manageNoDataFoundMessage()
        }
    }

    
    func filterUsingCategory()  {
        
        guard (selectedCategory == nil  && selectedRegion == nil)else {
            requestForFilter()
            return
        }
        
        guard List.count == 0 else {
            filterList = List
            return
        }
        
        requestForList()
    }
    
    func filterUsingRegion() -> [ModelList] {
        guard (selectedRegion != nil) else {
            return List
        }
        
        return List.filter({ (object) -> Bool in
            
            return (object.regionId == selectedRegion?.id)
        })
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
        delegate?.didSelecteItem(item: List[indexPath.row])
    }
    
    //MARK:- Helper methods
    private func registerCell() {
        tblView.register(ListingTableViewCell.self)
        self.tblView.contentInset = UIEdgeInsetsMake(tableviewTopSpace, 0, 0, 0);
    }
    
    private func requestForList() {
        
        guard checkForRequest() else {
            return
        }
        
        let param = ["page":page]
        APIService.sharedInstance.list(parameters: param as [String : AnyObject], success: { (result) -> (Void) in
            if (result.status) {
                self.List = result.modelList
                self.filterList = result.modelList
                ModelRequestList.sharedObject.modelList = result
                self.page = result.totalPageCount
            } else {
                showTitleBarAlert(message: result.message)
                self.filterList = [ModelList]()
            }
        }) { (error) -> (Void) in
            showTitleBarAlert(message: error)
        }
    }
    
    private func requestForFilter() {
        
        let param = ["category_id":selectedCategory?.id,
                     "region_id":selectedRegion?.id,
                     "page":page] as [String : Any]
        
        showIndicator()
        APIService.sharedInstance.list(parameters: param as [String : AnyObject], success: { (result) -> (Void) in
            self.hideIndicator()
            
            if (result.status) {
                self.filterList = result.modelList
            } else {
                showTitleBarAlert(message: result.message)
                self.filterList = [ModelList]()
                self.page = result.totalPageCount
            }
        }) { (error) -> (Void) in
            showTitleBarAlert(message: error)
            self.hideIndicator()
        }
    }
    
    //Check if requst is required or not
    private func checkForRequest() -> Bool {
        
        if ModelRequestList.sharedObject.modelList != nil {
            if ModelRequestList.sharedObject.isRequestSend {
                return false
            } else {
                return true
            }
        } else {
            return true
        }
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
                if totalPage > page {
                    
                    if (selectedCategory == nil && selectedRegion == nil) {
                        requestForList()
                    } else {
                        requestForFilter()
                    }
                }
            }
        }
    }
}
