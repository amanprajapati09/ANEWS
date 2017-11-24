//
//	RatingListMain.swift
//
//	Create by Aman Prajapati on 18/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class RatingListMain : BaseModel{

	var modelRatingData : [ModelRatingData]?
	
	override func mapping(map: Map) {
        super.mapping(map: map)
		modelRatingData <- map["data"]
	}

}
