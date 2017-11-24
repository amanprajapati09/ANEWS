//
//  RatingListViewController.swift
//  NewsApp
//
//  Created by Aman Prajapati on 11/18/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit

class RatingListViewController: BaseViewController, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var ratingList: [ModelRatingData]! {
        didSet {
            tblView.reloadData()
        }
    }
    
    var listId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reviews"
        tblView.register(ReviewTableViewCell.self)
        tblView.estimatedRowHeight = 70
        tblView.rowHeight = UITableViewAutomaticDimension
        tblView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestForList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UITableview datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard ratingList != nil else {
            return 0
        }
        return ratingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.reuseIdentifier)  as! ReviewTableViewCell
        cell.modelRating = ratingList[indexPath.row]
        return cell
    }
    
    private func requestForList() {
        showLoading()
        APIService.sharedInstance.ratingList(parameters: ["list_id":listId as AnyObject], success: { (result) -> (Void) in
            self.hideLading()
            self.ratingList = result.modelRatingData!
        }) { (error) -> (Void) in
            showNotificationAlert(type: .error, title: "", message: error)
            self.hideLading()
        }
    }
    
    
    private func showLoading() {
        activityIndicator.startAnimating()
        tblView.isHidden = true
    }
    
    private func hideLading() {
        activityIndicator.stopAnimating()
        tblView.isHidden = false
    }
}
