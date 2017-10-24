//
//	ModelFlashMain.swift
//
//	Create by Aman Prajapati on 24/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class ModelFlashMain : BaseModel {

	var modelFlash : [ModelFlash]?
	var totalPageCount : Int?

	override func mapping(map: Map) {
        super.mapping(map: map)
		modelFlash <- map["ModelFlash"]
		message <- map["message"]
		totalPageCount <- map["total_page_count"]
	}

}
