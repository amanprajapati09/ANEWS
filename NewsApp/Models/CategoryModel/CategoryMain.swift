//
//	CategoryMain.swift
//
//	Create by Aman Prajapati on 30/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class CategoryMain : BaseModel{

	var data : Data?
    
	override func mapping(map: Map)	{
		data <- map["data"]
	}
}
