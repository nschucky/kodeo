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
    var PullRequest: Int
    var Push: Int
    var NewIssue: Int
    var Comment: Int
    
	var userPicURL: String
	var userPic: UIImage?
	var pointsDic: [String: Int]?

    init(name: String, totalPoints: Int, PullRequest: Int, Push: Int, NewIssue: Int, Comment: Int, userPicURL: String, pointsDic: [String: Int]) {

		self.name = name
		self.totalPoints = totalPoints
        self.PullRequest = PullRequest
        self.Push = Push
        self.NewIssue = NewIssue
        self.Comment = Comment
        
		self.userPicURL = userPicURL
		self.pointsDic = pointsDic

		let image = UIImage(data: NSData(contentsOfURL: NSURL(string: userPicURL)!)!)
		self.userPic = image

	}

	init() {
		self.name = ""
		self.totalPoints = 0
        self.PullRequest = 0
        self.Push = 0
        self.NewIssue = 0
        self.Comment = 0
		self.userPicURL = ""
	}
}
