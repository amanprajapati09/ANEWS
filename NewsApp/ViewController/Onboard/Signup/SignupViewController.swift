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
    
    @IBOutlet weak var passwordContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var isForEditProfile = false
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareForLanguage()
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
        
        
        if isForEditProfile {
            guard validateEdit().0 else {
                showTitleBarAlert(message: validateEdit().1)
                return
            }
            
            requestForEditProfile()
            
        } else {
            guard validateSignUp().0 else {
                showTitleBarAlert(message: validateSignUp().1)
                return
            }
            
            requestForSignup()
        }
    }
    
    private func prepareView() {
        txtAddress.textField.delegate = self
        txtName.textField.delegate = self
        txtEmail.textField.delegate = self
        txtPassword.textField.delegate = self
        txtPhone.textField.delegate = self
        txtPassword.textField.isSecureTextEntry = true
        passwordContainer.isHidden = true
        if isForEditProfile {
            
            txtEmail.textField.text = (userDefault.value(forKey: MyUserDefault.USER_EMAIL) as? String)!
            txtEmail.changeToFloat(animated: false)
            txtName.textField.text = (userDefault.value(forKey: MyUserDefault.USER_FIRSTNAME) as? String)!
            txtName.changeToFloat(animated: false)
            txtPhone.textField.text = (userDefault.value(forKey: MyUserDefault.USER_PHONE) as? String)!
            txtPhone.changeToFloat(animated: false)
            txtAddress.textField.text = (userDefault.value(forKey: MyUserDefault.USER_ADDRESS) as? String)!
            txtAddress.changeToFloat(animated: false)
            txtEmail.isUserInteractionEnabled = false
        }
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
                self.hideLoading()
                showNotificationAlert(type: .error, title: "Error", message: result.message)
            }
            
        }) { (error) -> (Void) in
            self.hideLoading()
            showNotificationAlert(type: .error, title: "Error", message: error)
        }
    }
    
    private func requestForEditProfile() {
        showLoading()
        let params = ["user_id":userDefault.value(forKey: MyUserDefault.USER_ID),
                      "full_name":txtName.textField.text!,
                      "address":txtAddress.textField.text!,
                      "mobile_no":txtPhone.textField.text!
        ]
        
        APIService.sharedInstance.editProfile(parameters: params as [String : AnyObject], success: { (result) -> (Void) in
            if (result.status) {
                self.hideLoading()
                showNotificationAlert(type: .success, title: "Success", message: "Profile Edit completed")
                self.navigationController?.popViewController(animated: true)
            } else {
                self.hideLoading()
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
    
    private func prepareForLanguage() {
        txtName.placeHolderLabel.string = localizedShared?.localizedString(forKey: "label_name")
        txtPhone.placeHolderLabel.string = localizedShared?.localizedString(forKey: "label_contact")
        txtAddress.placeHolderLabel.string = localizedShared?.localizedString(forKey: "label_address")
        txtPassword.placeHolderLabel.string = localizedShared?.localizedString(forKey: "label_password")
        txtEmail.placeHolderLabel.string = localizedShared?.localizedString(forKey: "label_email")
        btnFinish.setTitle(localizedShared?.localizedString(forKey: "button_signup"), for: .normal)
    }
}
