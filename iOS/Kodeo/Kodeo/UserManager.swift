//
//  UserManager.swift
//  Kodeo
//
//  Created by Lucas Farah on 5/18/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import Alamofire

class UserManager: AnyObject {

	var users: [User] = []

	init() {

	}

	func fetchUsers(usernameArray: [String], handler: (users: [User]) -> ()) {

		for user in usernameArray {

			Netwerker().downloadUser(user) { (error, json) in
				if error == "" {

					let parsedUser = self.parseUser(json!)
					self.users.append(parsedUser)
					self.users.sortInPlace() { $0.totalPoints > $1.totalPoints } // sort the fruit by name

					handler(users: self.users)
				}
			}
		}
	}

	func parseUser(user: [String: AnyObject]) -> User {

		if let name = user["username"] as? String, totalPoints = user["totalPoints"] as? Int, userPicURL = user["userPic"] as? String {

			guard let issueCommentEvent = user["IssueCommentEvent"] as? Int, issueEvent = user["IssueEvent"] as? Int, pushEvent = user["PushEvent"] as? Int, pullRequest = user["PushEvent"] as? Int else {

				return User()
			}

			let dic = ["IssueCommentEvent": issueCommentEvent, "IssueEvent": issueEvent, "PushEvent": pushEvent, "PullRequestEvent": pullRequest]
			let user = User(name: name, totalPoints: totalPoints, userPicURL: userPicURL, pointsDic: dic)
			return user
		}
		return User()
	}
}
