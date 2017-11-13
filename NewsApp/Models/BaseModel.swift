//
//  BaseModel.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/5/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseModel: NSObject, Mappable {
    
    var status:Bool = false
    var message:String = ""
    var totalPageCount = 0
    
    
    override init() {
        
    }
    
    init(coder aDecoder: NSCoder) {
        
    }
    
    required init?(map: Map) {
        //fatalError("init(map:) has not been implemented")
    }
    
    func mapping(map: Map) {
        
        status <- map["status"]
        message <- map["message"]
        totalPageCount <- map["total_page_count"]
    }
}

