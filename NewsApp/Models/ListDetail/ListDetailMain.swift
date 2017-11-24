
//
//  ListDetailMain.swift
//  NewsApp
//
//  Created by Aman Prajapati on 11/18/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import UIKit
import ObjectMapper

class ListDetailMain: BaseModel {

    var modelRatingData = [ModelList]()

    override func mapping(map: Map) {
        super.mapping(map: map)
        modelRatingData <- map["data"]
    }

}
