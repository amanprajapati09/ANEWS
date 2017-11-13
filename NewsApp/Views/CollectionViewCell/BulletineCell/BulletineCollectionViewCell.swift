//
//  BulletineCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class BulletineCollectionViewCell: UICollectionViewCell, UITableViewDataSource,UITableViewDelegate ,NibLoadableView, ReusableView {

    var page = 1
    var totalPage = 0
    
    var delegate:ItemSelection?
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblTitleMessage: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedCategory:Category? {
        didSet {
            filterUsingCategory()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        requestForBullatineList()
    }
    
    var bullatineList = [ModelBulletin]() {
        didSet {
            tblView.reloadData()
        }
    }
    
    var filterList = [ModelBulletin]() {
        didSet {
            tblView.reloadData()
            manageNoDataFoundMessage()
        }
    }
    
    func filterUsingCategory()  {
       
        guard (selectedCategory == nil )else {
            requestForFilter()
            return
        }
        
        guard bullatineList.count == 0 else {
            filterList = bullatineList
            return
        }
        
        requestForBullatineList()
    }
    
    //MARK:- UITableview datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BullatineTableViewCell.reuseIdentifier)   as! BullatineTableViewCell
        cell.modelBullatine = filterList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156.0
    }
    
    //MARK:- UITableview delegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelecteItem(item: bullatineList[indexPath.row])
    }
    
    private func registerCell() {
        tblView.register(BullatineTableViewCell.self)
        self.tblView.contentInset = UIEdgeInsetsMake(tableviewTopSpace, 0, 0, 0);
    }

    private func requestForBullatineList() {
        
        guard checkForRequest() else {
            return
        }
        
        let param = ["page":page]
        APIService.sharedInstance.bulletineList(parameters: param as [String : AnyObject], success: { (result) -> (Void) in
            if (result.status) {
                self.bullatineList = result.bulletinList
                self.filterList = result.bulletinList
                ModelRequestBullatine.sharedObject.modelBullatine = result
                self.page = result.totalPageCount
            }
        }) { (error) -> (Void) in
            showTitleBarAlert(message: error)
        }
    }
    
    private func requestForFilter() {
        
        let param = ["category_id":selectedCategory!.id,
                     "page":page] as [String : Any]
        
        showIndicator()
        APIService.sharedInstance.bulletineList(parameters: param as [String : AnyObject], success: { (result) -> (Void) in
            self.hideIndicator()
            
            if (result.status) {
                self.filterList = result.bulletinList
                self.page = result.totalPageCount
            } else {
                showTitleBarAlert(message: result.message)
                self.filterList = [ModelBulletin]()
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
                    
                    if (selectedCategory == nil) {
                        requestForBullatineList()
                    } else {
                        requestForFilter()
                    }
                }
            }
        }
    }
}
