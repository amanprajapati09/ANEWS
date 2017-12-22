//
//  ModelSocialRegister.swift
//  NewsApp
//
//  Created by Aman Prajapati on 12/22/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation
import ObjectMapper

//ModelUser
class ModelSocialRegister: BaseModel {
    
    var data = ModelSocialData()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        data <- map["data"]
    }
}

class ModelSocialData: BaseModel {
    
    var modelUser = ModelUser()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        modelUser <- map["User"]
    }
}
