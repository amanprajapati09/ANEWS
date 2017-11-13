//
//	ModelMediaMain.swift
//
//	Create by Aman Prajapati on 24/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class ModelMediaMain : BaseModel {

	var MediaList = [ModelMedia]()

    override func mapping(map:Map) {
        super.mapping(map: map)
		MediaList <- map["data"]
		
	}
}
