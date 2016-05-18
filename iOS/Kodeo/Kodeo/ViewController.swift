//
//  ViewController.swift
//  Kodeo
//
//  Created by Lucas Farah on 5/16/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var table: UITableView!

	var arrayUsers: [User] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		let names = ["lfarah", "krausefx", "dkhamsing", "troydo42"]
		UserManager().fetchUsers(names) { (users) in
			self.arrayUsers = users
			self.table.reloadData()
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

extension ViewController: UITableViewDataSource {

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return self.arrayUsers.count
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell!
		if !(cell != nil) {
			cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
		}
		// setup cell without force unwrapping it

		let user = arrayUsers[indexPath.row]

		cell.textLabel!.text = user.name
		cell.detailTextLabel?.text = "\(user.totalPoints)"

		return cell
	}
}

extension ViewController: UITableViewDelegate {

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

	}
}
