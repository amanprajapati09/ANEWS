//
//  ListingCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class ListingCollectionViewCell: UICollectionViewCell, UITableViewDataSource,UITableViewDelegate, NibLoadableView, ReusableView {
    
    @IBOutlet weak var tblView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        requestForList()
    }
    
    var List = [ModelList]() {
        didSet {
            tblView.reloadData()
        }
    }
    
    
    //MARK:- UITableview datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return List.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListingTableViewCell.reuseIdentifier)   as! ListingTableViewCell
        cell.objList = List[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    private func registerCell() {
        tblView.register(ListingTableViewCell.self)
    }
    
    private func requestForList() {
        
        guard checkForRequest() else {
            return
        }
        
        APIService.sharedInstance.list(parameters: nil, success: { (result) -> (Void) in
            if (result.status) {
                self.List = result.modelList
                ModelRequestList.sharedObject.modelList = result
            } else {
                showTitleBarAlert(message: result.message)
            }
        }) { (error) -> (Void) in
            showTitleBarAlert(message: error)
        }
    }
    
    //Check if requst is required or not
    private func checkForRequest() -> Bool {
        
        if ModelRequestList.sharedObject.modelList != nil {
            if ModelRequestList.sharedObject.isRequestSend {
                return false
            } else {
                return true
            }
            
        } else {
            return true
        }
    }
}
