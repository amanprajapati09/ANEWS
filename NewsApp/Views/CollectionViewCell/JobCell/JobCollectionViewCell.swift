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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
    }

    //MARK:- UITableview datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JobTableViewCell.reuseIdentifier)   as! JobTableViewCell
        return cell
    }
    
    private func registerCell() {
        tblView.register(JobTableViewCell.self)
    }
}
