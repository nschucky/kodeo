//
//  AddFriendViewController.swift
//  Kodeo
//
//  Created by Lucas Farah on 6/1/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class AddFriendViewController: UIViewController {

	@IBOutlet weak var table: UITableView!

	@IBOutlet weak var search: UISearchBar!

	var searchItems: [[String: String]] = []

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
		self.table.emptyDataSetSource = self

		// A little trick for removing the cell separators
		self.table.tableFooterView = UIView()

        self.title = "New Github user"
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

extension AddFriendViewController: UITableViewDataSource {

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return searchItems.count
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! FriendTableViewCell!

		if !(cell != nil) {
			cell = FriendTableViewCell(style: .Default, reuseIdentifier: "cell")
		}
		// setup cell without force unwrapping it

		cell.lblNameFriend!.text = searchItems[indexPath.row]["username"]

		let url = self.searchItems[indexPath.row]["imgvUrl"]
		let image = UIImage(data: NSData(contentsOfURL: NSURL(string: url!)!)!)
		cell.imgvFriend.image = image

		return cell
	}
}

extension AddFriendViewController: UITableViewDelegate {

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

		let selectedItem = self.searchItems[indexPath.row]
		if let arrUsers = NSUserDefaults.standardUserDefaults().arrayForKey("arrUsers") {

			var newArr = arrUsers as! [String]
			if !(newArr.contains(selectedItem["username"]!)) {
				newArr.append(selectedItem["username"]!)
				NSUserDefaults.standardUserDefaults().setObject(newArr, forKey: "arrUsers")
				NSUserDefaults.standardUserDefaults().synchronize()

				NSNotificationCenter.defaultCenter().postNotificationName("updateUsers", object: nil)

			}
		} else {

			let arrUsers: [String] = [selectedItem["username"]!]
			NSUserDefaults.standardUserDefaults().setObject(arrUsers, forKey: "arrUsers")
		}

		self.navigationController?.popViewControllerAnimated(true)
	}
}

extension AddFriendViewController: UISearchBarDelegate {

	func searchBarSearchButtonClicked(searchBar: UISearchBar) {

		searchBar.resignFirstResponder()
		self.searchItems.removeAll()

		print(searchBar.text!)
		Netwerker().searchUser(searchBar.text!) { (error, json) in

			for item in json!["items"] as! [AnyObject] {
				let imageURL = item["avatar_url"] as! String
				let username = item["login"] as! String

				let user = ["imgvUrl": imageURL, "username": username]

				self.searchItems.append(user)
			}

			self.table.reloadData()
		}
		print("SEARCH 3")
	}
}

extension AddFriendViewController: DZNEmptyDataSetSource {

	func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {

		return NSAttributedString(string: "Searching for something?")
	}

	func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {

		return NSAttributedString(string: "Search for a Github user")
	}
}
