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
        page = 1
        requestForFilter()
    }
    
    func filterUsingRegion() -> [ModelJob] {
        guard (selectedRegion != nil) else {
            return jobList
        }
        
        return jobList.filter({ (object) -> Bool in
            
            return (object.regionId == selectedRegion?.id)
        })
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

        
        showIndicator()
        APIService.sharedInstance.jobList(parameters: param as [String : AnyObject], success: { (result) -> (Void) in
            self.hideIndicator()
            
            if (result.status) {
                
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
        }) { (error) -> (Void) in
            showTitleBarAlert(message: error)
            self.hideIndicator()
        }
    }
    
    //Check if requst is required or not
    private func checkForRequest() -> Bool {
        
        if ModelRequestBullatine.sharedObject.modelBullatine != nil {
            if ModelRequestBullatine.sharedObject.isRequestSend {
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
                if totalPage >= page {
                    requestForFilter(isForPagination: true)
                }
            }
        }
    }
}
