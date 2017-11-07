//
//  ListingCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class ListingCollectionViewCell: UICollectionViewCell, UITableViewDataSource,UITableViewDelegate, NibLoadableView, ReusableView {
    
    var delegate:ItemSelection?
    
    @IBOutlet weak var lblTitleMessage: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    var selectedCategory:Category? {
        didSet{
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
        requestForList()
    }
    
    var List = [ModelList]() {
        didSet {
            tblView.reloadData()
            manageNoDataFoundMessage()
        }
    }
    
    var filterList = [ModelList]() {
        didSet {
            tblView.reloadData()
            manageNoDataFoundMessage()
        }
    }

    
    func filterUsingCategory()  {
        
        //check selected category and region both nil one of them nil or both valid
        guard (selectedCategory != nil) else {
            
            if selectedRegion != nil {
                
                //Selected category nil but selected region not nil
                filterList = filterUsingRegion()
            } else {
                
                //Selected region nil but selected category nil
                filterList = List
            }
            
            return
        }
        
        guard (selectedRegion != nil ) else {
            
            //Selected region nil but selected category not nil
            filterList = List.filter({ (object) -> Bool in
                
                return (object.categoryId == selectedCategory!.id)
            })
            
            return
        }
        
        //Selected region and selected category not nil
        filterList = filterUsingRegion().filter({ (object) -> Bool in
            
            return (object.categoryId == selectedCategory!.id)
        })
    }
    
    func filterUsingRegion() -> [ModelList] {
        guard (selectedRegion != nil) else {
            return List
        }
        
        return List.filter({ (object) -> Bool in
            
            return (object.regionId == selectedRegion?.id)
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

    
    //MARK:- UITableview delegate methods 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelecteItem(item: List[indexPath.row])
    }
    
    //MARK:- Helper methods
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

    private func manageNoDataFoundMessage() {
        guard filterList.count > 0 else {
            tblView.isHidden = true
            lblTitleMessage.isHidden = false
            return
        }
        
        tblView.isHidden = false
        lblTitleMessage.isHidden = true
    }
}
