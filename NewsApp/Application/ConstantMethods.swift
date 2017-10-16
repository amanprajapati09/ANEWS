//
//  ConstantMethods.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/12/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation
import UIKit
import BPStatusBarAlert
import CRNotifications

func showTitleBarAlert(message:String) {
    BPStatusBarAlert()
        .message(message: message)
        .show()
}

func showNotificationAlert(type: CRNotificationType, title:String, message:String)  {
    CRNotifications.showNotification(type: type,
                                     title: title,
                                     message: message,
                                     dismissDelay: 3)
}
