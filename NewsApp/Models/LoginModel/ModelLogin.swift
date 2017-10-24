//
//	ModelLogin.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/5/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation 
import ObjectMapper


class ModelLogin : BaseModel {

	var modelLoginData : ModelLoginData?

	class func newInstance(map: Map) -> Mappable?{
		return ModelLogin()
	}
	
	override func mapping(map: Map) {
        super.mapping(map: map)
		modelLoginData <- map["data"]		
    }

}
