//
//  PostJobViewController.swift
//  NewsApp
//
//  Created by Aman Prajapati on 11/3/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit
import RSFloatInputView
import GooglePlacePicker

class PostJobViewController: BaseViewController, CategorySelectionDelegate, UITextFieldDelegate, GMSPlacePickerViewControllerDelegate {
    
    @IBOutlet weak var txtFirmName: RSFloatInputView!
    @IBOutlet weak var txtJobTitle: RSFloatInputView!
    @IBOutlet weak var txtSalary: RSFloatInputView!
    @IBOutlet weak var txtNumberOfPosition: RSFloatInputView!
    @IBOutlet weak var txtEmail: RSFloatInputView!
    @IBOutlet weak var txtContactNUmber: RSFloatInputView!
    @IBOutlet weak var txtAlterContactNumber: RSFloatInputView!
    @IBOutlet weak var txtContactPerson: RSFloatInputView!
    @IBOutlet weak var txtRecruterDesignation: RSFloatInputView!
    @IBOutlet weak var txtInterviewDate: RSFloatInputView!
    @IBOutlet weak var txtInterViewFirmAddress: RSFloatInputView!
    @IBOutlet weak var txtJobLocation: RSFloatInputView!
    @IBOutlet weak var txtJobDescription: RSFloatInputView!
    
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblRegion: UILabel!
    
    @IBOutlet weak var btnPostJob: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedCategory:Category?
    var selectedRegion:Category?
    
    var isRegion = false
    
    var selectedTextfield:UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        prepareView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCategoryClick(_ sender: Any) {
        isRegion = false
        performSegue(withIdentifier: Segues.kToCategoryFromJobPost, sender: ModelCategorySingleTone.sharedObject.objCategory?.data?.jobList)
    }
    
    @IBAction func btnRegionClick(_ sender: Any) {
        isRegion = true
        performSegue(withIdentifier: Segues.kToCategoryFromJobPost, sender: (ModelCategorySingleTone.sharedObject.objCategory?.data?.regionList)!)
    }
    
    @IBAction func btnPostJobClick(_ sender: Any) {
        
        guard validateTextfielr().0 else {
            showTitleBarAlert(message: validateTextfielr().1)
            return
        }
        
        requestPostJob()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.kToCategoryFromJobPost {
            
            let destinationViewController = segue.destination as! CategorySelectionViewController
            destinationViewController.delegate = self
            destinationViewController.categoryList = sender as! [Category]
            destinationViewController.titleLabel = createcategoryPickerTitleMessage()
        }
    }
 
    private func prepareView() {
        txtInterViewFirmAddress.textField.delegate = self
        txtJobLocation.textField.delegate = self
    }
    
    //MARK:- category selection delegate methods
    func didSelectCagtegory(seletedCategory: Category) {
        if isRegion {
            selectedRegion = seletedCategory
            lblRegion.text = selectedRegion?.name!
        } else {
            self.selectedCategory = seletedCategory
            lblCategory.text = selectedCategory?.name!
        }
    }
    
    //MARK:- Web Services 
    func requestPostJob(){
 
        showLoading()
        let params:[String:AnyObject] = ["user_id":"\(userDefault.object(forKey: MyUserDefault.USER_ID)!)" as AnyObject,
                                         "category_id":"\((selectedCategory?.id)!)" as AnyObject,
                                         "region_id":"\((selectedRegion?.id)!)" as AnyObject,
                                         "firm_name":"\(txtFirmName.textField.text!)" as AnyObject,
                                         "job_title":"\(txtJobTitle.textField.text!)" as AnyObject,
                                         "salary":"\(txtSalary.textField.text!)" as AnyObject,
                                         "no_of_post":"\(txtNumberOfPosition.textField.text!)" as AnyObject,
                                         "email_id":"\(txtEmail.textField.text!)" as AnyObject,
                                         "contact_no":"\(txtContactNUmber.textField.text!)" as AnyObject,
                                         "alt_contact_no":"\(txtAlterContactNumber.textField.text!)" as AnyObject,
                                         "contact_person":"\(txtContactPerson.textField.text!)" as AnyObject,
                                         "recruiter_designation":"\(txtRecruterDesignation.textField.text!)" as AnyObject,
                                         "interview_date":"\(txtInterviewDate.textField.text!)" as AnyObject,
                                         "firm_address":"\(txtInterViewFirmAddress.textField.text!)" as AnyObject,
                                         "job_location":"\(txtJobLocation.textField.text!)" as AnyObject,
                                         "job_description":"\(txtJobDescription.textField.text!)" as AnyObject]
        
        print("params: \(params)")
        APIService.sharedInstance.AddPostJob(parameters: params, success: { (result) -> (Void) in
            showNotificationAlert(type: .success, title: "Suceess!", message: result.message)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 2), execute: {
                self.navigationController?.popViewController(animated: true)
            })
            self.hideLoading()
        }) { (errorStr) -> (Void) in
            showNotificationAlert(type: .error, title: "Error!", message: errorStr)
            self.hideLoading()
        }
    }
    
    //MARK:- helper methods
    internal func presentAddressPicker() {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        placePicker.modalPresentationStyle = .popover
//        placePicker.popoverPresentationController?.sourceView = txtAddress
//        placePicker.popoverPresentationController?.sourceRect = txtAddress.bounds
//        
        // Display the place picker. This will call the delegate methods defined below when the user
        // has made a selection.
        self.present(placePicker, animated: true, completion: nil)
    }
    
    private func showLoading() {
        activityIndicator.startAnimating()
        btnPostJob.isEnabled = false
    }
    
    private func hideLoading() {
        activityIndicator.stopAnimating()
        btnPostJob.isEnabled = true
    }
    
    private func createcategoryPickerTitleMessage() -> String {
        if isRegion {
            return "Select region for job posting"
        } else {
            return "Select category for job posting"
        }
    }
}
