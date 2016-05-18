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

		if let name = user["username"] as? String, totalPoints = user["totalPoints"] as? Int {

			let user = User(name: name, totalPoints: totalPoints)
			return user
		}
		return User()
	}

}
