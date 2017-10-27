//
//	Job.swift
//
//	Create by Aman Prajapati on 27/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Job : ModelBaseHome {

	var modelJob : ModelJob?

	override func mapping(map: Map)
	{
        super.mapping(map: map)
		modelJob <- map["job"]
		
	}

}
