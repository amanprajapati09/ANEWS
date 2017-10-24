//
//	ModelListMain.swift
//
//	Create by Aman Prajapati on 24/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class ModelListMain : BaseModel {

	var modelList : [ModelList]?
	
	var totalPageCount : Int?

	override func mapping(map: Map) {
        super.mapping(map: map)
		modelList <- map["ModelList"]
		status <- map["status"]
		totalPageCount <- map["total_page_count"]		
	}
}
