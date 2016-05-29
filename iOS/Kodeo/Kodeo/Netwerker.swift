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

		Alamofire.request(.GET, "http://localhost:5000/getpointsForUser", parameters: ["user": user])
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

}
