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
        
        return true
    }
    
    private func registerIQKeyboard() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
    }
    
}
