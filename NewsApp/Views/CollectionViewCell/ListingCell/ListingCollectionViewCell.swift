//
//  ListingCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class ListingCollectionViewCell: UICollectionViewCell, UITableViewDataSource,UITableViewDelegate, NibLoadableView, ReusableView, HeaderClickDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    var delegate:ItemSelection?
    
    var selectedCategory:Category? {
        didSet{
            filterData()
        }
    }
    
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
    
    var filterList = [ModelList]() {
        didSet {
            tblView.reloadData()
        }
    }

    
    private func filterData() {
        guard (selectedCategory != nil) else {
            return
        }
        
        filterList = List.filter({ (object) -> Bool in
            return object.categoryId == selectedCategory?.id
        })
    }
    
    //MARK:- UITableview datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListingTableViewCell.reuseIdentifier)   as! ListingTableViewCell
        cell.objList = filterList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
        delegate?.didSelecteItem(item: List[indexPath.row])
    }
    
    //MARK:- Helper methods
    private func registerCell() {
        tblView.register(ListingTableViewCell.self)
        tblView.registerHeaderCell(ListingHeader.self)
    }
    
    private func requestForList() {
        
        guard checkForRequest() else {
            return
        }
        
        APIService.sharedInstance.list(parameters: nil, success: { (result) -> (Void) in
            if (result.status) {
                self.List = result.modelList
                self.filterList = result.modelList
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
    
    //HeaderClick Delegate
    func didSelecteHeader(isRegion: Bool) {
        if isRegion {
            delegate?.didSelectHeaderItem(headerValue: .eRegion)
        } else {
            delegate?.didSelectHeaderItem(headerValue: .eListing)
        }
    }
}
