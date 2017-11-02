//
//  JobCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class JobCollectionViewCell: UICollectionViewCell, UITableViewDataSource,UITableViewDelegate,NibLoadableView, ReusableView {
    
    var delegate:ItemSelection?
    @IBOutlet weak var tblView: UITableView!
    
    var jobList = [ModelJob]() {
        didSet {
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

        //check selected category and region both nil one of them nil or both valid
        guard (selectedCategory != nil) else {
            
            if selectedRegion != nil {
                
                //Selected category nil but selected region not nil
                filterList = filterUsingRegion()
            } else {
                
                //Selected region nil but selected category nil
                filterList = jobList
            }
            
            return
        }
        
        guard (selectedRegion != nil ) else {
            
            //Selected region nil but selected category not nil
            filterList = jobList.filter({ (object) -> Bool in
                
                return (object.categoryId == selectedCategory!.id)
            })
            
            return
        }
        
        //Selected region and selected category not nil
        filterList = filterUsingRegion().filter({ (object) -> Bool in
            
            return (object.categoryId == selectedCategory!.id)
        })
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
