//
//  JobCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class JobCollectionViewCell: UICollectionViewCell, UITableViewDataSource,UITableViewDelegate,NibLoadableView, ReusableView, HeaderClickDelegate {

    @IBOutlet weak var tblView: UITableView!
    var delegate:ItemSelection?
    
    var jobList = [ModelJob]() {
        didSet {
            filterUsingCategory()
            tblView.reloadData()
        }
    }
    
    var filterList = [ModelJob]() {
        didSet {
            tblView.reloadData()
        }
    }
    
    var selectedCategory:Category? {
        didSet {
            tblView.reloadData()
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        requestForJobList()
    }

    func filterUsingCategory()  {
        guard selectedCategory != nil else {
            return
        }
        
        filterList = jobList.filter({ (object) -> Bool in
            return object.categoryId == selectedCategory?.id
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.00
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ListingHeader.reuseIdentifier) as! ListingHeader
        header.delegate = self
        return header
    }
    
    //MARK:- UITableview delegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelecteItem(item: jobList[indexPath.row])
    }
    
    //HeaderClick Delegate
    func didSelecteHeader(isRegion: Bool) {
        if isRegion {
            delegate?.didSelectHeaderItem(headerValue: .eRegion)
        } else {
            delegate?.didSelectHeaderItem(headerValue: .eJob)
        }
    }
    
    private func registerCell() {
        tblView.register(JobTableViewCell.self)
        tblView.registerHeaderCell(ListingHeader.self)
    }
    
    private func requestForJobList() {
        
        guard checkForRequest() else {
            return
        }
        
        APIService.sharedInstance.jobList(parameters: nil, success: { (result) -> (Void) in
            if (result.status) {
                self.jobList = result.jobList!
                self.filterList = result.jobList!
                ModelRequestJob.sharedObject.modelJob = result
            }
        }) { (error) -> (Void) in
            showTitleBarAlert(message: error)
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

}
