//
//	ModelRatingData.swift
//
//	Create by Aman Prajapati on 18/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class ModelRatingData : BaseModel {

	var id : String?
	var listId : String?
	var rateValue : String = "0.0"
	var review : String?
	var userId : String?
	var userName : String?

	override func mapping(map: Map)
	{        
		id <- map["id"]
		listId <- map["list_id"]
		rateValue <- map["rate_value"]
		review <- map["review"]
		userId <- map["user_id"]
		userName <- map["user_name"]
	}
    
}
