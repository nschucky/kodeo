//
//  ViewController.swift
//  Kodeo
//
//  Created by Lucas Farah on 5/16/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

	@IBOutlet weak var table: UITableView!

	var dicUsers: [[String: AnyObject]] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		getUser("dkhamsing")
		getUser("lfarah")
		getUser("krausefx")

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func getUser(user: String) {

		Alamofire.request(.GET, "https://kodeo.herokuapp.com/getpointsForUser", parameters: ["user": user])
			.responseJSON { response in

				if let json = response.result.value {

					self.dicUsers.append(json as! [String: AnyObject])
					self.table.reloadData()
					print(json)
				}
		}

	}

}

extension ViewController: UITableViewDataSource {

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return self.dicUsers.count
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell!
		if !(cell != nil) {
			cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
		}
		// setup cell without force unwrapping it

		let user = dicUsers[indexPath.row]

		if let totalPoints = user["totalPoints"], username = user["username"] {
			cell.textLabel!.text = "\(username)"
			cell.detailTextLabel?.text = "\(totalPoints)"
		}
    
		return cell
	}
}

extension ViewController: UITableViewDelegate {

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

	}
}
