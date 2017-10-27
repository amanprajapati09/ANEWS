//
//  BulletineCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class BulletineCollectionViewCell: UICollectionViewCell, UITableViewDataSource,UITableViewDelegate ,NibLoadableView, ReusableView {

    @IBOutlet weak var tblView: UITableView!
    
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
    
    
    //MARK:- UITableview datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bullatineList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BullatineTableViewCell.reuseIdentifier)   as! BullatineTableViewCell
        cell.modelBullatine = bullatineList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       return tableView.dequeueReusableHeaderFooterView(withIdentifier: BullatineHeader.reuseIdentifier)
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
}
