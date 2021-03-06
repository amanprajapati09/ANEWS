//
//  SignupViewController.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/10/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit
import RSFloatInputView
import GooglePlacePicker

class SignupViewController: BaseViewController, UITextFieldDelegate, GMSPlacePickerViewControllerDelegate {

    @IBOutlet weak var txtName: RSFloatInputView!
    @IBOutlet weak var txtPhone: RSFloatInputView!
    @IBOutlet weak var txtAddress: RSFloatInputView!
    @IBOutlet weak var txtEmail: RSFloatInputView!
    @IBOutlet weak var txtPassword: RSFloatInputView!
    
    @IBOutlet weak var btnFinish: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnFinish.setCornerRadious(corner: Int(btnFinish.frame.height/2))
    }

    
    @IBAction func btnSignupClick(_ sender: Any) {
        guard validateSignUp().0 else {
            showTitleBarAlert(message: validateSignUp().1)
            return
        }
        
        requestForSignup()
    }
    
    private func prepareView() {
        txtAddress.textField.delegate = self 
    }
    
    private func requestForSignup() {
        showLoading()
        let params = ["email_id":txtEmail.textField.text!,
                      "full_name":txtName.textField.text!,
                      "address":txtAddress.textField.text!,
                      "mobile_no":txtPhone.textField.text!,
                      "password":txtPassword.textField.text!]
       
        APIService.sharedInstance.registration(parameters: params as [String : AnyObject], success: { (result) -> (Void) in
            if (result.status) {
                self.hideLoading()
                showNotificationAlert(type: .success, title: "Success", message: "Signup completed")
                self.navigationController?.popViewController(animated: true)
            } else {
               showNotificationAlert(type: .error, title: "Error", message: result.message)
            }
            
        }) { (error) -> (Void) in
            self.hideLoading()
            showNotificationAlert(type: .error, title: "Error", message: error)
        }
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
    
    private func showLoading() {
        activityIndicator.startAnimating()
        btnFinish.isEnabled = false
    }
    
    private func hideLoading() {
        activityIndicator.stopAnimating()
        btnFinish.isEnabled = true
    }
}
