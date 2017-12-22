//
//	ModelUser.swift
//  NewsApp
//
//  Created by Aman Prajapati on 10/5/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation 
import ObjectMapper


class ModelUser : BaseModel {

	var address : String?
	var emailId : String?
	var firstName : String?
	var id : String?
	var mobileNo : String?
	var roleId : String?
	var userStatus : String?


	class func newInstance(map: Map) -> Mappable?{
		return ModelUser()
	}
	
	override func mapping(map: Map) {
        
		address <- map["address"]
		emailId <- map["email_id"]
		firstName <- map["first_name"]
		id <- map["id"]
		mobileNo <- map["mobile_no"]
		roleId <- map["role_id"]
		userStatus <- map["status"]
	}
}
