//
//  ListDetailViewController.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/26/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit
import GooglePlacePicker
import HCSStarRatingView

class ListDetailViewController: BaseViewController,UITextFieldDelegate, GMSPlacePickerViewControllerDelegate, MyReviewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblContactNo: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBOutlet weak var lblAverageRating: UILabel!
    
    @IBOutlet weak var ratingView: HCSStarRatingView!
    @IBOutlet weak var btnTotalRating: UIButton!
    
    var modelList = ModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGesture()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
    }
    
    internal func prepareView() {
        imageView.sd_setImage(with: modelList.imageUrl, placeholderImage: placeholdeImage!)
        lblTitle.text = modelList.title
        lblName.text =  modelList.fullName
        lblContactNo.text = modelList.mobileNo
        lblEmail.text = modelList.emailId
        lblAddress.text = modelList.address
        btnTotalRating.setTitle("\(modelList.totalReview) Review", for: .normal)
        lblAverageRating.text = "\(modelList.totalRating)"
        ratingView.value = CGFloat(modelList.totalRating)
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(askToSaveImage))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    func askToSaveImage()  {
        let alert = UIAlertController(title: "Warning", message: "Are you sure want to save image to photos ?", preferredStyle: .alert)
        
        let actionOk = UIAlertAction(title: "Ok", style: .default) { (action) in
            CustomPhotoAlbum.sharedInstance.save(image: self.imageView.image!)
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            
        }
        
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:- helper methods
    internal func presentAddressPicker() {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        placePicker.modalPresentationStyle = .popover
        placePicker.popoverPresentationController?.sourceView = txtAddress
        placePicker.popoverPresentationController?.sourceRect = txtAddress.bounds
        
        // Display the place picker. This will call the delegate methods defined below when the user
        // has made a selection.
        self.present(placePicker, animated: true, completion: nil)
    }
    
    @IBAction func myReviewClick(_ sender: Any) {
        
        guard (userDefault.value(forKey: MyUserDefault.USER_ID) != nil) else {
            showNotificationAlert(type: .error, title: "Warning!", message: "Please Signin to add your review!")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 2), execute: {
                self.presentLoginView()
            })
            return
        }
        
        performSegue(withIdentifier: Segues.kToGiveReviewViewController, sender: nil)
        
    }
    
    @IBAction func TotalReviewClick(_ sender: Any) {
        guard modelList.totalReview > 0 else {
            return
        }
        performSegue(withIdentifier: Segues.kToReviewListingScreen, sender: nil)
    }
    
    @IBAction func SubmitListingClick(_ sender: Any) {
        
        guard (userDefault.value(forKey: MyUserDefault.USER_ID) != nil) else {
            showNotificationAlert(type: .error, title: "Warning!", message: "Please login  first to post job")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 2), execute: {
                self.presentLoginView()
            })
            return
        }
        
        performSegue(withIdentifier: Segues.ktoSubmitListingView, sender: nil)
    }

    //MARK:- Segue methods 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.kToReviewListingScreen {
            let destinationViewController = segue.destination as! RatingListViewController
            destinationViewController.listId = modelList.id!
        } else if segue.identifier == Segues.kToGiveReviewViewController {
            let destinationViewController = segue.destination as! MyReviewViewController
            destinationViewController.listID = modelList.id!
            destinationViewController.delegate = self
        }
        
    }
}

extension ListDetailViewController {
    
    //MARK:- Textfield delegate methods
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard textField == txtAddress else {
            return true
        }
        
        if (UIApplication.shared.canOpenURL(URL(string:"http://maps.google.co.in/maps?q=\(modelList.address)")!)) {
            UIApplication.shared.open(URL(string:"")!, options: [:], completionHandler: nil)
        } else {
            showNotificationAlert(type: .error, title: "", message: "Not able to open google map")
        }
        
        return false
    }
    
    //MARK:- Place picker delegate methods
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        txtAddress.text = place.name
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didFailWithError error: Error) {
        
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- myreview delegate methods 
    func didSubmitListing(listDetail: ModelList) {
        modelList = listDetail
        prepareView()
    }
}
