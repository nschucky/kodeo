//
//  User.swift
//  Kodeo
//
//  Created by Lucas Farah on 5/18/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import Alamofire

class User: AnyObject {

	var name: String
	var totalPoints: Int

	init(name: String, totalPoints: Int) {

		self.name = name
		self.totalPoints = totalPoints
	}

	init() {
		self.name = ""
		self.totalPoints = 0
	}
}
