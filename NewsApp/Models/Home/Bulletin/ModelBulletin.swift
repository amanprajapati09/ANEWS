//
//	ModelBulletin.swift
//
//	Create by Aman Prajapati on 24/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class ModelBulletin : ModelBaseHome {

	
	var descriptionField : String?
	
	var mobileNo : String = ""
	var webLink : String = ""


    override func mapping(map:Map) {
        super.mapping(map: map)
		descriptionField <- map["description"]
		mobileNo <- map["mobile_no"]
		webLink <- map["web_link"]
		
	}
}
