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
	var pointsDic: [String: Int]?

	init(name: String, totalPoints: Int, userPicURL: String, pointsDic: [String: Int]) {

		self.name = name
		self.totalPoints = totalPoints
		self.userPicURL = userPicURL
		self.pointsDic = pointsDic

		let image = UIImage(data: NSData(contentsOfURL: NSURL(string: userPicURL)!)!)
		self.userPic = image

	}

	init() {
		self.name = ""
		self.totalPoints = 0
		self.userPicURL = ""
	}
}
