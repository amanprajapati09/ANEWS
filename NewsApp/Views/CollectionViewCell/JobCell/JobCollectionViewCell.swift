//
//  JobCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class JobCollectionViewCell: UICollectionViewCell, UITableViewDataSource,UITableViewDelegate,NibLoadableView, ReusableView {
    
    var page = 1
    var totalPage = 0
    var delegate:ItemSelection?
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblTitleMessage: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    var jobList = [ModelJob]() {
        didSet {
            tblView.reloadData()
        }
    }
    
    var filterList = [ModelJob]() {
        didSet {
            tblView.reloadData()
            manageNoDataFoundMessage()
        }
    }
    
    var selectedCategory:Category?
    var selectedRegion:Category?
    
    var selectedFilter:FilterContainer? {
        didSet {
            selectedCategory = selectedFilter?.selectedCategory
            selectedRegion = selectedFilter?.selectedRegion
            
            filterUsingCategory()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
    }
    
    func filterUsingCategory()  {
        
        if (selectedRegion == nil && selectedCategory == nil)  {
            
            if ModelRequestJob.sharedObject.modelJobList.count == 0 {
                page = 1
                requestForFilter()
            } else {
                page = ModelRequestJob.sharedObject.page
                filterList = ModelRequestJob.sharedObject.modelJobList
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
        let cell = tableView.dequeueReusableCell(withIdentifier: JobTableViewCell.reuseIdentifier)   as! JobTableViewCell
        cell.modelJob = filterList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 169
    }
    
    //MARK:- UITableview delegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelecteItem(item: jobList[indexPath.row])
    }
    
    private func registerCell() {
        tblView.register(JobTableViewCell.self)
        self.tblView.contentInset = UIEdgeInsetsMake(tableviewTopSpace, 0, 0, 0);
        tblView.estimatedRowHeight = 45
        tblView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func requestForFilter(isForPagination:Bool = false) {
        
        var param = [String:AnyObject]()
        
        param["page"] = page as AnyObject

        
        if let categoryId = selectedCategory {
            param["category_id"] = categoryId.id! as AnyObject
        }
        
        if let regionId = selectedRegion {
            param["region_id"] = regionId.id! as AnyObject
        }
        
        if !isForPagination {
            showIndicator()
        }
        
        ModelRequestJob.sharedObject.isRequestSend = true
      
        APIService.sharedInstance.jobList(parameters: param as [String : AnyObject], success: { (result) -> (Void) in
            self.hideIndicator()
            
            if (result.status) {
                
                self.parseForNilFilter(result: result, isForPagination: isForPagination)
                if !isForPagination {
                    self.jobList = result.jobList
                    self.filterList = result.jobList
                    
                } else {
                    self.jobList.append(contentsOf: result.jobList)
                    self.filterList.append(contentsOf: result.jobList)
                }
                
                self.page = self.page + 1
                self.totalPage = result.totalPageCount
                
            } else {
                showTitleBarAlert(message: result.message)
                self.filterList = [ModelJob]()
            }
            return ModelRequestJob.sharedObject.isRequestSend = false
            
        }) { (error) -> (Void) in
            
            ModelRequestJob.sharedObject.isRequestSend = false
            showTitleBarAlert(message: error)
            self.hideIndicator()
        }
    }
    
    private func parseForNilFilter (result:ModelJobMain, isForPagination:Bool) {
        
        if (selectedCategory == nil && selectedRegion == nil)  {
            
            if isForPagination {
                ModelRequestJob.sharedObject.modelJobList.append(contentsOf: result.jobList)
            } else {
                ModelRequestJob.sharedObject.modelJobList = result.jobList
            }
            
            ModelRequestJob.sharedObject.page = page + 1
        }
    }
    
    //Check if requst is required or not
    private func checkForRequest() -> Bool {
        return ModelRequestBullatine.sharedObject.isRequestSend
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
                if totalPage >= page {
                    requestForFilter(isForPagination: true)
                }
            }
        }
    }
}
