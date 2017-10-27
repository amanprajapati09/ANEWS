//
//  MediaCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell,UITableViewDataSource,UITableViewDelegate, NibLoadableView, ReusableView {

    @IBOutlet weak var tblView: UITableView!
    
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
    
    
    //MARK:- UITableview datasource methods 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MeddiaTableViewCell.reuseIdentifier)   as! MeddiaTableViewCell
        cell.modelMedia = mediaList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.00
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: ListingHeader.reuseIdentifier)
    }
    
    private func registerCell() {
        tblView.register(MeddiaTableViewCell.self)
        tblView.registerHeaderCell(ListingHeader.self)
    }

    private func requestForMediaList() {
        
        guard checkForRequest() else {
            return
        }
        
        APIService.sharedInstance.mediaList(parameters: nil, success: { (result) -> (Void) in
            if (result.status) {
                self.mediaList = result.MediaList
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
