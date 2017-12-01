//
//  FlashCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class FlashCollectionViewCell: UICollectionViewCell, UITableViewDataSource,UITableViewDelegate, NibLoadableView, ReusableView, UIScrollViewDelegate {

    var page = 1
    var totalPage = 0
    
    
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
        self.tblView.contentInset = UIEdgeInsetsMake(tableviewTopSpace, 0, 0, 0);
    }
    
    private func requestForFlashList() {
        
        guard !checkForRequest() else {
            return
        }
        
        let param = ["page":page]
        
        ModelRequestFlash.sharedObject.isRequestSend = true
        APIService.sharedInstance.flashList(parameters: param as [String : AnyObject], success: { (result) -> (Void) in
            if (result.status) {
                self.flashList.append(contentsOf: result.flashList)
                ModelRequestFlash.sharedObject.modelFlash = result
                self.page = self.page + 1
                self.totalPage = result.totalPageCount
            }
            ModelRequestFlash.sharedObject.isRequestSend = true
        }) { (error) -> (Void) in
            showTitleBarAlert(message: error)
            ModelRequestFlash.sharedObject.isRequestSend = true
        }
    }
    
    //Check if requst is required or not
    private func checkForRequest() -> Bool {
        
        return ModelRequestFlash.sharedObject.isRequestSend
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
    
    //MARK:- Scrollview delegate methods 
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //Bottom Refresh
        
        if scrollView == tblView {
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                if totalPage >= page {
                    requestForFlashList()
                }
            }
        }
    }
}
