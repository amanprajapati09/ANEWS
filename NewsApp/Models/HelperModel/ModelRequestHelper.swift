
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
    var modelList = [ModelList]()
    var page = 1
    
}

class ModelRequestBullatine {
    
    static let sharedObject =  ModelRequestBullatine()
    var isRequestSend:Bool = false
    var modelBullatineList = [ModelBulletin]()
    var page = 1
}

class ModelRequestJob {
    
    static let sharedObject = ModelRequestJob()
    var isRequestSend:Bool = false
    var modelJobList = [ModelJob]()
    var page = 1
}

class ModelRequestMedia {
    
    static let sharedObject = ModelRequestMedia()
    var isRequestSend:Bool = false
    var modelMedia = [ModelMedia]()
    var page = 1
}

class ModelCategorySingleTone {
    static let sharedObject = ModelCategorySingleTone()
    var objCategory:CategoryMain?
    
}
