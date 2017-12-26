//
//  LoginViewController.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/10/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit
import RSFloatInputView
import GoogleSignIn

class LoginViewController: BaseViewController {

    @IBOutlet weak var txtEmail: RSFloatInputView!
    @IBOutlet weak var txtPassword: RSFloatInputView!
    
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var activityIndigator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var btnSkipToHome: UIButton!
    internal var objLoginViewModel = LoginViewModel()
    
    @IBOutlet weak var googleIndicator: UIActivityIndicatorView!
    @IBOutlet weak var facebookIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var btnFacebookLogin: UIButton!
    @IBOutlet weak var btnGoogleLogin: UIButton!
    
    var isFromApp: Bool = false
    
    var googleUser: GIDGoogleUser!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard isFromApp else {
            hideNavigationBar()
            return
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        prepareView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar()
    }
    
    //MARK:- Button Action
    @IBAction func btnSignClick(_ sender: Any) {
        guard validateLogin().0 else {
            //Show alert
            showTitleBarAlert(message: validateLogin().1)
            return
        }
        
        requestForLogin()
    }
    
    @IBAction func btnSkipHomeClick(_ sender: Any) {
        performSegue(withIdentifier: Segues.kToHomeViewControllerFromSignIn, sender: nil)
    }
    
    @IBAction func btnForgotPasswordClick(_ sender: Any) {
        presentForgotpasswordAlert()
    }
    
    @IBAction func btnFBLoginClick(_ sender: Any) {
        doLoginWithFacebook()
    }
    
    @IBAction func btnGoogleClick(_ sender: Any) {
        doLoginWithGoogle()
    }
    
    //MARK:- Request methods
    private func requestForLogin() {
        showLoading()
        let param = objLoginViewModel.createLoginParams(username: txtEmail.textField.text!, password: txtPassword.textField.text!) as [String : AnyObject]
        APIService.sharedInstance.login(parameters: param , success: { (result) -> (Void) in
            //Navigate to home view controller
            self.hideLoading()
            if (result.status) {
                showNotificationAlert(type: .success, title: "Success", message: "Login Success")
                
                //check if it is come from app then pop else goahed
                if self.isFromApp {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.performSegue(withIdentifier: Segues.kToHomeViewControllerFromSignIn, sender: nil)
                }
                self.activityIndigator.stopAnimating()
                self.objLoginViewModel.saveLoginInfo(model: (result.modelLoginData?.modelUser)!)
            } else {
                showNotificationAlert(type: .success, title: "Error", message: result.message)
            }
            
        }) { (error) -> (Void) in
            // Show error
            self.hideLoading()
            showNotificationAlert(type: .error, title: "Error" , message: error)
            self.activityIndigator.stopAnimating()
        }
    }

    private func presentForgotpasswordAlert() {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Alert!", message: "Please enter your register email!", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            
            guard (textField?.validateEmail())! else {
                showTitleBarAlert(message: "Please enter your email!")
                return
            }
            
            self.requestForForgotPassword(email: (textField?.text)!)
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
 
    private func requestForForgotPassword(email:String) {
        
        let param = objLoginViewModel.createForgotParams(email: email)
        APIService.sharedInstance.forgotPassword(parameters: param as [String : AnyObject] , success: { (result) -> (Void) in
            //Navigate to home view controller
            if (result.status) {
                showNotificationAlert(type: .success, title: "Success", message: "Link send to your email.")
            } else {
                showNotificationAlert(type: .error, title: "Error", message: result.message)                
            }
            
        }) { (error) -> (Void) in
            // Show error
            showNotificationAlert(type: .error, title: "Error" , message: error)
        }
    }
    
    //MARK:- Helper methods
    private func showLoading() {
        activityIndigator.startAnimating()
        btnSignIn.isEnabled = false
    }
    
    private func hideLoading() {
        activityIndigator.stopAnimating()
        btnSignIn.isEnabled = true
    }

    private func prepareView() {
        btnSignIn.setCornerRadious(corner: Int(btnSignIn.frame.height/2))
        txtPassword.textField.isSecureTextEntry = true
        txtEmail.textField.delegate = self
        txtPassword.textField.delegate = self
        
        guard isFromApp else {
            return
        }
        
        btnSkipToHome.isHidden = true
    }
}
