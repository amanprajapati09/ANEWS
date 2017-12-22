//
//  LoginViewcontrollerFacebook.swift
//  NewsApp
//
//  Created by Aman Prajapati on 12/22/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin

extension LoginViewController {
    
    internal func doLoginWithFacebook() {
        let objFbView = FBLogin()
        objFbView.facebookLoginDataRequest { (result) in
            self.requestForFBLocalSignIn(user: result)
        }
    }
    
    func requestForFBLocalSignIn(user: FBProfileRequest.Response) {
        
        showLoadingForFBSignIn()
        let params = ["email_id":user.email!,
                      "gmail_social_id":user.facebookId!,
                      "social_login_id":"",
                      "full_name":user.firstName]
        
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
            self.hideLoadingForFBSignIn()
        }
    }
    
    private func requestForSignup(user: FBProfileRequest.Response) {
        
        let params = ["email_id":user.email!,
                      "full_name":user.firstName!,
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
            self.hideLoadingForFBSignIn()
            showNotificationAlert(type: .error, title: "Error", message: error)
        }
    }
    
    func showLoadingForFBSignIn() {
        btnGoogleLogin.isEnabled = false
        btnFacebookLogin.isEnabled = false
        btnSignIn.isEnabled = false
        btnSkipToHome.isEnabled = false
        facebookIndicator.startAnimating()
    }
    
    func hideLoadingForFBSignIn() {
        btnGoogleLogin.isEnabled = true
        btnFacebookLogin.isEnabled = true
        btnSignIn.isEnabled = true
        btnSkipToHome.isEnabled = true
        facebookIndicator.stopAnimating()
    }
}

struct Constants {
    
    struct FacebookParameters {
        static let kBirthday = "birthday"
        static let kEmail = "email"
        static let kGender = "gender"
        static let kId = "id"
        static let kPicture = "picture"
        static let kFirstName = "first_name"
        static let kLastName = "last_name"
        static let kData = "data"
        static let kUrl = "url"
    }
}


//--------------------------------------
// MARK: - FB Profile Reading Request
//--------------------------------------
struct FBProfileRequest: GraphRequestProtocol {
    
    var graphPath = "/me"
    var parameters: [String : Any]? =  [
        "fields": "\(Constants.FacebookParameters.kBirthday),\(Constants.FacebookParameters.kEmail),\(Constants.FacebookParameters.kGender),\(Constants.FacebookParameters.kId),\(Constants.FacebookParameters.kPicture),\(Constants.FacebookParameters.kFirstName),\(Constants.FacebookParameters.kLastName)" as AnyObject]
    
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = 2.7
    
    struct Response: GraphResponseProtocol {
        
        /// Easy access properties
        var facebookId: String?
        var firstName: String?
        var lastName: String?
        var email: String?
        var birthday: String?
        var profilePicture: String?
        var gender: String?
        var rawResponse: Dictionary<String, AnyObject>?
        
        /**
         Initializes a response.
         - parameter rawResponse: Raw response received from a server.
         Usually is represented by either a `Dictionary` or `Array`.
         */
        public init(rawResponse: Any?) {
            if let response = rawResponse as? Dictionary<String, AnyObject> {
                self.rawResponse = response
                if let facebookId = response[Constants.FacebookParameters.kId] as? String {
                    self.facebookId = facebookId
                }
                if let firstName = response[Constants.FacebookParameters.kFirstName] as? String {
                    self.firstName = firstName
                }
                if let lastName = response[Constants.FacebookParameters.kLastName] as? String {
                    self.lastName = lastName
                }
                if let email = response[Constants.FacebookParameters.kEmail] as? String {
                    self.email = email
                }
                if let location = response[Constants.FacebookParameters.kBirthday] as? String {
                    self.birthday = location
                }
                if let pictureData: Dictionary<String, AnyObject> = (response[Constants.FacebookParameters.kPicture]?[Constants.FacebookParameters.kData]) as? Dictionary<String, AnyObject> {
                    self.profilePicture = pictureData[Constants.FacebookParameters.kUrl] as! String?
                }
                
                if let gender = response[Constants.FacebookParameters.kGender] as? String {
                    self.gender = gender
                }
                
            }
        }
    }
}

class FBLogin: UIViewController {
    
    static let shareInstance = FBLogin()
    
    var loginManager: LoginManager? = LoginManager()
    
    func facebookLoginDataRequest(completion:@escaping ((FBProfileRequest.Response) -> Void)) {
        
        loginManager?.logIn(readPermissions: [.email, .publicProfile,],
                            viewController: self,
                            completion: { (loginResult) in
                                switch loginResult {
                                case .success(_, _, _):
                                    //Readinf FB Profile
                                    self.readProfile(completion: completion)
                                case .cancelled: break
                                case .failed(_): break
                                }
        })
    }
    
    
    func readProfile(completion:@escaping ((FBProfileRequest.Response) -> Void)) {
        let request = FBProfileRequest()
        request.start { (_, result) in
            switch result {
            case .success(let response):
                completion(response)
            //print( (response.raw.rawResponse?.description)! )
            case .failed(let error): print("Graph Request Failed: \(error)")
            }
        }
    }
}
