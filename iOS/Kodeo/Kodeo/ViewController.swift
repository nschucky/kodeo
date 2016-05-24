//
//  ViewController.swift
//  Kodeo
//
//  Created by Lucas Farah on 5/16/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class ViewController: UIViewController {

	@IBOutlet weak var table: UITableView!

	var arrayUsers: [User] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		fetchUsers()
	}

	func fetchUsers() {
		let names = ["lfarah", "krausefx", "dkhamsing", "troydo42"]
		UserManager().fetchUsers(names) { (users) in
			self.arrayUsers = users
			self.table.reloadData()
		}

	}

	@IBAction func butRefresh(sender: AnyObject) {

    fetchUsers()
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
		var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UserTableViewCell!
		if !(cell != nil) {
			cell = UserTableViewCell(style: .Default, reuseIdentifier: "cell")
		}
		// setup cell without force unwrapping it

		let user = arrayUsers[indexPath.row]

		cell.lblNameUser.text = user.name

		var points = "\(user.totalPoints)".bold()
		points += NSAttributedString(string: " points")

		cell.lblPointsUser.attributedText = points
		cell.imgvUser.image = user.userPic

		let ranking = indexPath.row + 1

		if ranking == 1 {
			cell.lblRankingUser.backgroundColor = UIColor(red: 245 / 255, green: 166 / 255, blue: 35 / 255, alpha: 1)
		}

		cell.lblRankingUser.text = "\(ranking)"

		return cell
	}
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if let detail = segue.destinationViewController as? DetailUserViewController {
      detail.user = arrayUsers[sender as! Int]
    }
  }
}

extension ViewController: UITableViewDelegate {

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    self.performSegueWithIdentifier("detail", sender: indexPath.row)
	}
}
