//
//  Netwerker.swift
//  Kodeo
//
//  Created by Lucas Farah on 5/18/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import Alamofire

class Netwerker: AnyObject {

	init() {

	}

	func downloadUser(user: String, handler: (error: String, json: [String: AnyObject]?) -> ()) {

		Alamofire.request(.GET, "https://secure-castle-66440.herokuapp.com/getpointsForUser", parameters: ["user": user])
			.responseJSON { response in

				if let json = response.result.value {
					print(json)
					handler(error: "", json: json as? [String: AnyObject])
				} else {
					print("EROR")
					handler(error: "NetworkError", json: nil)
				}
		}
	}

	func searchUser(user: String, handler: (error: String, json: [String: AnyObject]?) -> ()) {

		let cleanUser = user.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    
		let url = "https://api.github.com/search/users?q=\(cleanUser)&client_id=39c9aaea6e3c93cc9247&client_secret=01203f23db09a26aa448511f9c0ddd68a2f7ad43"
		Alamofire.request(.GET, url, parameters: [:])
			.responseJSON { response in

				if let json = response.result.value {
					print(json)
					handler(error: "", json: json as? [String: AnyObject])
				} else {
					print("ERROR")
					print(response)
					handler(error: "NetworkError", json: nil)
				}
		}
	}
}
