//
//  AppdelegateExtension.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/10/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces
import GoogleSignIn
import Firebase
import FacebookLogin
import FacebookCore

extension AppDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Provide the Places API with your API key.
        GMSPlacesClient.provideAPIKey(kPlacesAPIKey)
        // Provide the Maps API with your API key. We need to provide this as well because the Place
        // Picker displays a Google Map.
        GMSServices.provideAPIKey(kMapsAPIKey)

        if (userDefault.object(forKey: MyUserDefault.USER_ID) != nil) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController =  MainainStoryboard.instantiateViewController(withIdentifier: StoryBoardId.homeNavigation)
        }
        
        //Code For google sign in config
        FirebaseApp.configure()
       GIDSignIn.sharedInstance().clientID = kGoogleClientID
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    private func registerIQKeyboard() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url,
                                                                   sourceApplication: sourceApplication,
                                                                   annotation: annotation)
        
        let facebookDidHandle = SDKApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        
        return googleDidHandle || facebookDidHandle
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        
        let facebookDidHandle = SDKApplicationDelegate.shared.application(app, open: url, options: options)
        
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return googleDidHandle || facebookDidHandle
    }
    
}
