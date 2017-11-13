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
    
    var selectedCategory:Category? {
        didSet {
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
        requestForJobList()
    }
    
    func filterUsingCategory()  {
        guard (selectedCategory == nil  && selectedRegion == nil)else {
            requestForFilter()
            return
        }
        
        guard jobList.count == 0 else {
            filterList = jobList
            return
        }
        
        requestForJobList()
        
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
    
    private func requestForJobList() {
        
        guard checkForRequest() else {
            return
        }
        let param = ["page":page]
        
        APIService.sharedInstance.jobList(parameters: param as [String : AnyObject], success: { (result) -> (Void) in
            if (result.status) {
                self.jobList = result.jobList!
                self.filterList = result.jobList!
                ModelRequestJob.sharedObject.modelJob = result
                self.page = result.totalPageCount
            }
        }) { (error) -> (Void) in
            showTitleBarAlert(message: error)
        }
    }
    
    private func requestForFilter() {
        
        let param = ["category_id":selectedCategory?.id!,
                     "region_id":selectedRegion?.id!,
                     "page":page] as [String : Any]
        
        showIndicator()
        APIService.sharedInstance.jobList(parameters: param as [String : AnyObject], success: { (result) -> (Void) in
            self.hideIndicator()
            
            if (result.status) {
                self.filterList = result.jobList!
                self.page = result.totalPageCount
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
                if totalPage > page {
                    
                    if (selectedCategory == nil && selectedRegion == nil) {
                        requestForJobList()
                    } else {
                        requestForFilter()
                    }
                }
            }
        }
    }
}
