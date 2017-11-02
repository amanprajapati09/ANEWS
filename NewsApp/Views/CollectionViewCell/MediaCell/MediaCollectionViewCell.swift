//
//  MediaCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell,UITableViewDataSource,UITableViewDelegate, NibLoadableView, ReusableView {

    var delegate:ItemSelection?
    @IBOutlet weak var tblView: UITableView!
    
    var selectegCategory:Category? {
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
        }
    }
    
    func filterUsingCategory()  {
      
        guard selectegCategory != nil else {
            filterList = mediaList
            return
        }
        
        filterList = mediaList.filter({ (object) -> Bool in
            return object.categoryId == selectegCategory?.id
        })
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
    }

    private func requestForMediaList() {
        
        guard checkForRequest() else {
            return
        }
        
        APIService.sharedInstance.mediaList(parameters: nil, success: { (result) -> (Void) in
            if (result.status) {
                self.mediaList = result.MediaList
                self.filterList = result.MediaList
                ModelRequestMedia.sharedObject.modelMedia = result
            }
        }) { (error) -> (Void) in
            showTitleBarAlert(message: error)
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
}
