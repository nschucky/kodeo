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
	var userPicURL: String
	var userPic: UIImage?

	init(name: String, totalPoints: Int, userPicURL: String) {

		self.name = name
		self.totalPoints = totalPoints
		self.userPicURL = userPicURL

		let image = UIImage(data: NSData(contentsOfURL: NSURL(string: userPicURL)!)!)
    self.userPic = image
	}

	init() {
		self.name = ""
		self.totalPoints = 0
    self.userPicURL = ""
	}
}
