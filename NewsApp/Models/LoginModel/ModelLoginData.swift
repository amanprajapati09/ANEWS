//
//	ModelLoginData.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/5/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation 
import ObjectMapper


class ModelLoginData : BaseModel {

	var modelUser : ModelUser?

	class func newInstance(map: Map) -> Mappable?{
		return ModelLoginData()
	}
	
	override func mapping(map: Map) {
		modelUser <- map["User"]
	}

}
