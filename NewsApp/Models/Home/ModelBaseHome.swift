//
//  ModelBaseHome.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/24/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit
import ObjectMapper

class ModelBaseHome: BaseModel {

    var id : String?
    var created : String = ""
    var modified : String = ""
    var listStatus : String = ""
    var title : String = ""
    var categoryId : String = ""
    
    override func mapping(map:Map) {
        super.mapping(map: map)
        categoryId <- map["category_id"]
        created <- map["created"]
        id <- map["id"]
        modified <- map["modified"]
        listStatus <- map["status"]
        title <- map["title"]
    }

}
