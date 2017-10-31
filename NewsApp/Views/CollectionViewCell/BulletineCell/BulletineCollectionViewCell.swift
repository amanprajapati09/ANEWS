//
//  BulletineCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class BulletineCollectionViewCell: UICollectionViewCell, UITableViewDataSource,UITableViewDelegate ,NibLoadableView, ReusableView, HeaderClickDelegate {

    @IBOutlet weak var tblView: UITableView!
     var delegate:ItemSelection?
    
    var selectedCategory:Category? {
        didSet {
            tblView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        requestForBullatineList()
    }
    
    var bullatineList = [ModelBulletin]() {
        didSet {
            filterUsingCategory()
            tblView.reloadData()
        }
    }
    
    var filterList = [ModelBulletin]() {
        didSet {
            tblView.reloadData()
        }
    }
    
    func filterUsingCategory()  {
        guard selectedCategory != nil else {
            return
        }
        
        filterList = bullatineList.filter({ (object) -> Bool in
            return object.categoryId == selectedCategory?.id
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: BullatineHeader.reuseIdentifier) as! BullatineHeader
       header.delegate = self
        return header
    }
    
    //MARK:- UITableview delegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelecteItem(item: bullatineList[indexPath.row])
    }
    
    private func registerCell() {
        tblView.register(BullatineTableViewCell.self)
        tblView.registerHeaderCell(BullatineHeader.self)
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
    
    //HeaderClick Delegate
    func didSelecteHeader(isRegion: Bool) {
        delegate?.didSelectHeaderItem(headerValue: .eBulletin)
    }
}
