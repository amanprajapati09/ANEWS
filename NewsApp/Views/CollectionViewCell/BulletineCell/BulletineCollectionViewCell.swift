//
//  BulletineCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class BulletineCollectionViewCell: UICollectionViewCell, UITableViewDataSource,UITableViewDelegate ,NibLoadableView, ReusableView {

    var delegate:ItemSelection?
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var lblTitleMessage: UILabel!
    var selectegCategory:Category? {
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
       
        guard selectegCategory != nil else {
            filterList = bullatineList
            return
        }
        
        filterList = bullatineList.filter({ (object) -> Bool in
            return object.categoryId == selectegCategory?.id
        })
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
    }

    private func requestForBullatineList() {
        
        guard checkForRequest() else {
            return
        }
        
        APIService.sharedInstance.bulletineList(parameters: nil, success: { (result) -> (Void) in
            if (result.status) {
                self.bullatineList = result.bulletinList
                self.filterList = result.bulletinList
                ModelRequestBullatine.sharedObject.modelBullatine = result
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
