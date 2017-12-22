//
//  LoginViewControllerExtension.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/11/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

extension LoginViewController:UITextFieldDelegate, GIDSignInUIDelegate, GIDSignInDelegate {

    
    internal func validateLogin() -> (Bool,String) {
        guard txtEmail.textField.validateEmail() else {
            return (false,"Enter proper email!")
        }
        
        guard !txtPassword.textField.validateIsEmpty() else {
            return (false,"Enter proper password!")
        }
        
        return (true,"")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    internal func doLoginWithGoogle() {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        // Uncomment to automatically sign in the user.
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
    }
    
    //MARK:- Google sign delegate methods
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        print(error)
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            self.requestForGoogleLocalSignIn(user: user)
        } else {
            showNotificationAlert(type: .error, title: "Error!", message: error.localizedDescription)
        }
    }
    
    func requestForGoogleLocalSignIn(user: GIDGoogleUser) {
        
        showLoadingForGoogleSignIn()
        let params = ["email_id":user.profile.email!,
                      "gmail_social_id":user.userID!,
                      "social_login_id":"",
                      "full_name":user.profile.givenName]
        
        APIService.sharedInstance.socialLogin(parameters: params as [String : AnyObject], success: { (result) -> (Void) in
            
            if !result.status {
                self.requestForSignup(user: user)
            } else {
                if self.isFromApp {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.performSegue(withIdentifier: Segues.kToHomeViewControllerFromSignIn, sender: nil)
                }
                self.hideLoadingForGoogleSignIn()
                self.objLoginViewModel.saveLoginInfo(model: result.data.modelUser)
                userDefault.setValue(true, forKey: MyUserDefault.SOCIAL_LOGIN)
            }
            
        }) { (error) -> (Void) in
            showNotificationAlert(type: .error, title: "Error!", message: error)
            self.hideLoadingForGoogleSignIn()
        }
    }
    
    private func requestForSignup(user: GIDGoogleUser!) {
        
        let params = ["email_id":user.profile.email!,
                      "full_name":user.profile.name!,
                      "address":"",
                      "mobile_no":"",
                      "password":""]
        
        APIService.sharedInstance.registration(parameters: params as [String : AnyObject], success: { (result) -> (Void) in
            if (result.status) {
                
                showNotificationAlert(type: .success, title: "Success", message: "Signup completed")
                
            } else {
                
                showNotificationAlert(type: .error, title: "Error", message: result.message)
            }
            
        }) { (error) -> (Void) in
            self.hideLoadingForGoogleSignIn()
            showNotificationAlert(type: .error, title: "Error", message: error)
        }
    }

    func showLoadingForGoogleSignIn() {
        btnGoogleLogin.isEnabled = false
        btnFacebookLogin.isEnabled = false
        btnSignIn.isEnabled = false
        btnSkipToHome.isEnabled = false
        googleIndicator.startAnimating()
    }
    
    func hideLoadingForGoogleSignIn() {
        btnGoogleLogin.isEnabled = true
        btnFacebookLogin.isEnabled = true
        btnSignIn.isEnabled = true
        btnSkipToHome.isEnabled = true
        googleIndicator.stopAnimating()
    }
}
