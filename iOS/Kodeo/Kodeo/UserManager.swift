//
//  UserManager.swift
//  Kodeo
//
//  Created by Lucas Farah on 5/18/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import Alamofire
import EZLoadingActivity
class UserManager: AnyObject {

	var users: [User] = []

	init() {

	}

	func fetchUsers(usernameArray: [String], handler: (users: [User]) -> ()) {

        self.users.removeAll()
        EZLoadingActivity.show("Loading...", disableUI: false)

        var count = 0
		for user in usernameArray {

			Netwerker().downloadUser(user) { (error, json) in
				if error == "" {

					let parsedUser = self.parseUser(json!)
					self.users.append(parsedUser)
					self.users.sortInPlace() { $0.totalPoints > $1.totalPoints } // sort the fruit by name
                    
                    count += 1
                    if count == usernameArray.count {
                        
                        EZLoadingActivity.hide(success: true, animated: true)
                    }
                    
					handler(users: self.users)
				}
			}
		}
        

	}
	// PullRequestEvent: 17,
	// IssueEvent: 0,
	// IssueCommentEvent: 42,
	// PushEvent: 86,
	func parseUser(user: [String: AnyObject]) -> User {

		if let
		name = user["username"] as? String,
			totalPoints = user["totalPoints"] as? Int,
			dailyPoints = user["dailyPoints"] as? [String: Int],
			userPicURL = user["userPic"] as? String
		{

			guard let issueCommentEvent = user["IssueCommentEvent"] as? Int, issueEvent = user["IssueEvent"] as? Int, pushEvent = user["PushEvent"] as? Int, pullRequest = user["PullRequestEvent"] as? Int else {

				return User()
			}

			let dic = ["IssueCommentEvent": issueCommentEvent, "IssueEvent": issueEvent, "PushEvent": pushEvent, "PullRequestEvent": pullRequest]

			let user = User(name: name, totalPoints: totalPoints, PullRequest: pullRequest, Push: pushEvent, NewIssue: issueEvent, Comment: issueCommentEvent, userPicURL: userPicURL, dailyPoints: dailyPoints, pointsDic: dic)

			return user
		}
		return User()
	}

}
