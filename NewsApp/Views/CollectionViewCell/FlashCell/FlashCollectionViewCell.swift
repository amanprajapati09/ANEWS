//
//  FlashCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class FlashCollectionViewCell: UICollectionViewCell, UITableViewDataSource,UITableViewDelegate, NibLoadableView, ReusableView {

    @IBOutlet weak var lblTitleMessage: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var delegate:ItemSelection?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        requestForFlashList()
    }
    
    var flashList = [ModelFlash]() {
        didSet {
            tblView.reloadData()
            manageNoDataFoundMessage()
        }
    }

    //MARK:- UITableview datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flashList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlashTableViewCell.reuseIdentifier)   as! FlashTableViewCell
        cell.modelFlash = flashList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    //MARK:- UITableview delegate methods 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelecteItem(item: flashList[indexPath.row])
    }
    
    //MARK:- Hepler methods
    private func registerCell() {
        tblView.register(FlashTableViewCell.self)
    }
    
    private func requestForFlashList() {
        
        guard checkForRequest() else {
            return
        }
        
        APIService.sharedInstance.flashList(parameters: nil, success: { (result) -> (Void) in
            if (result.status) {
                self.flashList = result.flashList
                ModelRequestFlash.sharedObject.modelFlash = result
            }
        }) { (error) -> (Void) in
            showTitleBarAlert(message: error)
        }
    }
    
    //Check if requst is required or not
    private func checkForRequest() -> Bool {
        
        if ModelRequestFlash.sharedObject.modelFlash != nil {
            if ModelRequestFlash.sharedObject.isRequestSend {
                return false
            } else {
                return true
            }
            
        } else {
            return true
        }
    }
    
    private func manageNoDataFoundMessage() {
        guard flashList.count > 0 else {
            tblView.isHidden = true
            lblTitleMessage.isHidden = false
            return
        }
        
        tblView.isHidden = false
        lblTitleMessage.isHidden = true
    }
}
