//
//  MyReviewViewController.swift
//  NewsApp
//
//  Created by Aman Prajapati on 11/18/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit
import HCSStarRatingView

protocol MyReviewDelegate {
   func didSubmitListing(listDetail:ModelList)
}

class MyReviewViewController: UIViewController {

    @IBOutlet weak var txtReview: UITextView!
    @IBOutlet weak var ratingView: HCSStarRatingView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var lblMyReview: UILabel!
    
    var objModel:ModelList!
    
    var listID:String!
    let userID = userDefault.value(forKey: MyUserDefault.USER_ID)
    
    var delegate:MyReviewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareForLanguage()
        txtReview.text = objModel.myReview
        ratingView.value = CGFloat(objModel.myRating)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelClickAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancelClick(_ sender: Any) {
        dismissView()
    }
    
    @IBAction func btnSubmitClick(_ sender: Any) {
        requestForSubmitReview()
    }
    
    private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    private func requestForSubmitReview() {
        showLoading()
        let param = ["user_id":userID!,
                     "review":txtReview.text,
                     "rate_value":ratingView.value,
                     "list_id":listID]
        
        APIService.sharedInstance.submitReview(parameters: param as [String : AnyObject], success: { (result) -> (Void) in
                self.requestForListDetail()
        }) { (error) -> (Void) in
            self.hideLoading()
            showNotificationAlert(type: .error, title: "", message: error)
        }
    }
    
    private func showLoading() {
        btnCancel.isUserInteractionEnabled = false
        btnSubmit.isUserInteractionEnabled = false
    }
    
    private func hideLoading() {
        btnCancel.isUserInteractionEnabled = true
        btnSubmit.isUserInteractionEnabled = true
    }
    
    private func requestForListDetail() {
        
        let param = ["user_id":userID!,
                     "list_id":listID]
        
        APIService.sharedInstance.listDetail(parameters: param as [String : AnyObject], success: { (result) -> (Void) in
            if result.modelRatingData.count > 0 {
                self.delegate?.didSubmitListing(listDetail: result.modelRatingData.first!)                
            }
            self.dismissView()
        }) { (error) -> (Void) in
            self.dismissView()
            self.hideLoading()
        }
    }
    
    private func prepareForLanguage() {
        lblMyReview.text = localizedShared?.localizedString(forKey: "button_my_review")        
    }
}
