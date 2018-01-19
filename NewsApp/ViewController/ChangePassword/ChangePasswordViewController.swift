//
//  ChangePasswordViewController.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/17/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit
import RSFloatInputView

class ChangePasswordViewController: BaseViewController {

    @IBOutlet weak var txtCurrentPassword: RSFloatInputView!
    @IBOutlet weak var txtNewPassword: RSFloatInputView!
    @IBOutlet weak var txtReTypePassword: RSFloatInputView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnFinish: UIButton!
    
    
    let objViewModel = ChangePasswordViewModel()
    
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
    
    @IBAction func btnFinishClick(_ sender: Any) {
        guard validateChangePassword().0 else {
            showTitleBarAlert(message: validateChangePassword().1)
            return
        }
        
        requestForChangePassword()
    }
    
    private func requestForChangePassword() {
        showLoading()
        let params = objViewModel.prepareParams(oldPassword: txtCurrentPassword.textField.text!, newPassword: txtNewPassword.textField.text!)
        APIService.sharedInstance.resetPassword(parameters: params as [String : AnyObject], success: { (result) -> (Void) in
            self.hideLoading()
            if(result.status) {
                showNotificationAlert(type: .success, title: "Success" , message:result.message)
                self.navigationController?.popViewController(animated: true)
            } else {
                showNotificationAlert(type: .error, title: "Error" , message:result.message)
            }                        
        }) { (error) -> (Void) in
            self.hideLoading()
            showNotificationAlert(type: .error, title: "Error" , message:error)
        }
    }
    
    //MARK:- helper methods
    private func prepareView() {
        txtNewPassword.textField.isSecureTextEntry = true
        txtCurrentPassword.textField.isSecureTextEntry = true
        txtReTypePassword.textField.isSecureTextEntry = true
        btnFinish.setCornerRadious(corner: Int(btnFinish.frame.height/2))
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
        txtCurrentPassword.placeHolderLabel.string = localizedShared?.localizedString(forKey: "label_current_password")
        txtNewPassword.placeHolderLabel.string = localizedShared?.localizedString(forKey: "label_new_password")
        txtReTypePassword.placeHolderLabel.string = localizedShared?.localizedString(forKey: "label_retype_password")
        btnFinish.setTitle(localizedShared?.localizedString(forKey: "button_save_password"), for: .normal)
    }
}
