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
    
    var selectedCategory:Category?
    var selectedFilter:FilterContainer? {
        didSet {
            selectedCategory = selectedFilter?.selectedCategory
            filterUsingCategory()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
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
        
        if (selectedCategory == nil)  {
            
            if ModelRequestMedia.sharedObject.modelMedia.count == 0 {
                page = 1
                requestForFilter()
            } else {
                page = ModelRequestMedia.sharedObject.page
                filterList = ModelRequestMedia.sharedObject.modelMedia
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
    
    private func requestForFilter(isForPagination:Bool = false) {
        
        var param = [String:AnyObject]()
        
        param["page"] = page as AnyObject
        
        
        if let categoryId = selectedCategory {
            param["category_id"] = categoryId.id! as AnyObject
        }
        
        
        if !isForPagination {
            showIndicator()
        }
        
        ModelRequestMedia.sharedObject.isRequestSend = true
        APIService.sharedInstance.mediaList(parameters: param as [String : AnyObject], success: { (result) -> (Void) in
            self.hideIndicator()
            
            if (result.status) {
                
                self.parseForNilFilter(result: result, isForPagination: isForPagination)
                
                if !isForPagination {
                    self.mediaList = result.MediaList
                    self.filterList = result.MediaList
                    
                } else {
                    self.mediaList.append(contentsOf: result.MediaList)
                    self.filterList.append(contentsOf: result.MediaList)
                }
                
                self.page = self.page + 1
                self.totalPage = result.totalPageCount
            } else {
                showTitleBarAlert(message: result.message)
                self.filterList = [ModelMedia]()
            }
            
            ModelRequestMedia.sharedObject.isRequestSend = false
        }) { (error) -> (Void) in
            showTitleBarAlert(message: error)
            self.hideIndicator()
            ModelRequestMedia.sharedObject.isRequestSend = false
        }
    }
    
    private func parseForNilFilter (result:ModelMediaMain, isForPagination:Bool) {
        
        if (selectedCategory == nil)  {
            
            if isForPagination {
                ModelRequestMedia.sharedObject.modelMedia.append(contentsOf: result.MediaList)
            } else {
                ModelRequestMedia.sharedObject.modelMedia = result.MediaList
            }
            
            ModelRequestMedia.sharedObject.page = page + 1
        }
    }
    
    //Check if requst is required or not
    private func checkForRequest() -> Bool {
        return ModelRequestMedia.sharedObject.isRequestSend
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
