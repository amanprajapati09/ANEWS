//
//  JobCollectionViewCell.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/23/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class JobCollectionViewCell: UICollectionViewCell, UITableViewDataSource,UITableViewDelegate,NibLoadableView, ReusableView {

    @IBOutlet weak var tblView: UITableView!
    var delegate:ItemSelection?
    
    var jobList = [Job]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
    }

    //MARK:- UITableview datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JobTableViewCell.reuseIdentifier)   as! JobTableViewCell
        cell.modelJob = jobList[indexPath.row].modelJob
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 169
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.00
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: ListingHeader.reuseIdentifier)
    }
    
    //MARK:- UITableview delegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelecteItem(item: jobList[indexPath.row].modelJob!)
    }
    
    
    private func registerCell() {
        tblView.register(JobTableViewCell.self)
        tblView.registerHeaderCell(ListingHeader.self)
    }
}
