
//
//  ModelRequestHelper.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/24/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation

class ModelRequestFlash {
    
    static let sharedObject = ModelRequestFlash()
    var isRequestSend:Bool = false
    var modelFlash:ModelFlashMain?
    
}

class ModelRequestList {
    
    static let sharedObject = ModelRequestList()
    var isRequestSend:Bool = false
    var modelList:ModelListMain?
    
}

class ModelRequestBullatine {
    
    static let sharedObject =  ModelRequestBullatine()
    var isRequestSend:Bool = false
    var modelBullatine:ModelBulletinMain?
    
}

class ModelRequestJob {
    
    static let sharedObject = ModelRequestJob()
    var isRequestSend:Bool = false
    var modelJob:ModelFlashMain?
    
}

class ModelRequestMedia {
    
    static let sharedObject = ModelRequestMedia()
    var isRequestSend:Bool = false
    var modelMedia:ModelMediaMain?
    
}
