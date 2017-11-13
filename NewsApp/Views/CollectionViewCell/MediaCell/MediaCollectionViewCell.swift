//
//  MediaCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell,UITableViewDataSource,UITableViewDelegate, NibLoadableView, ReusableView {

    var page = 1
    var totalPage = 0
    
    var delegate:ItemSelection?
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var lblTitleMessage: UILabel!
    var selectedCategory:Category? {
        didSet {
            filterUsingCategory()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        requestForMediaList()
    }
    
    var mediaList = [ModelMedia]() {
        didSet {
            tblView.reloadData()
        }
    }
    
    var filterList = [ModelMedia]() {
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
        
        guard mediaList.count == 0 else {
            filterList = mediaList
            return
        }
        
        requestForMediaList()
    }
    
    //MARK:- UITableview datasource methods 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MeddiaTableViewCell.reuseIdentifier)   as! MeddiaTableViewCell
        cell.modelMedia = filterList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    //MARK:- UITableview delegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelecteItem(item: mediaList[indexPath.row])
    }
    
    private func registerCell() {
        tblView.register(MeddiaTableViewCell.self)
        self.tblView.contentInset = UIEdgeInsetsMake(tableviewTopSpace, 0, 0, 0);
    }

    private func requestForMediaList() {
        
        guard checkForRequest() else {
            return
        }
        let param = ["page":page]
        APIService.sharedInstance.mediaList(parameters: param as [String : AnyObject], success: { (result) -> (Void) in
            if (result.status) {
                self.mediaList = result.MediaList
                self.filterList = result.MediaList
                ModelRequestMedia.sharedObject.modelMedia = result
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
        APIService.sharedInstance.mediaList(parameters: param as [String : AnyObject], success: { (result) -> (Void) in
            self.hideIndicator()
            
            if (result.status) {
                self.filterList = result.MediaList
                self.page = result.totalPageCount
            } else {
                showTitleBarAlert(message: result.message)
                self.filterList = [ModelMedia]()
            }
        }) { (error) -> (Void) in
            showTitleBarAlert(message: error)
            self.hideIndicator()
        }
    }
    
    
    //Check if requst is required or not
    private func checkForRequest() -> Bool {
        
        if ModelRequestMedia.sharedObject.modelMedia != nil {
            if ModelRequestMedia.sharedObject.isRequestSend {
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
                        requestForMediaList()
                    } else {
                        requestForFilter()
                    }
                }
            }
        }
    }
}
