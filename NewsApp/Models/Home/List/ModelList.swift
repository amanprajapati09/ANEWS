//
//	ModelList.swift
//
//	Create by Aman Prajapati on 24/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class ModelList : ModelBaseHome {

	var address : String?
	var descriptionField : String?
	var emailId : String?
	var fullName : String?
	var image : String?
	var mobileNo : String?
	var regionId : String?

    override func mapping(map:Map) {
        super.mapping(map: map)
        address <- map["address"]		
		descriptionField <- map["description"]
		emailId <- map["email_id"]
		fullName <- map["full_name"]
		image <- map["image"]
		mobileNo <- map["mobile_no"]
		regionId <- map["region_id"]
		
	}
}
