//
//  ViewController.swift
//  Kodeo
//
//  Created by Lucas Farah on 5/16/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import DGElasticPullToRefresh
import MGSwipeTableCell
import EZLoadingActivity

class ViewController: UIViewController {

	@IBOutlet weak var table: UITableView!

	@IBOutlet var topPanel: UIImageView!
	var arrayUsers: [User] = []
	var manager = UserManager()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		topPanel.layer.shadowColor = UIColor.blackColor().CGColor
		topPanel.layer.shadowOffset = CGSizeMake(0, 2)
		topPanel.layer.shadowOpacity = 1
		topPanel.layer.shadowRadius = 1.0
		topPanel.clipsToBounds = false
		topPanel.layer.masksToBounds = false

		let loadingView = DGElasticPullToRefreshLoadingViewCircle()
		loadingView.tintColor = UIColor(red: 78 / 255.0, green: 221 / 255.0, blue: 200 / 255.0, alpha: 1.0)
		table.dg_addPullToRefreshWithActionHandler({ [weak self]() -> Void in
			// Add your logic here
			// Do not forget to call dg_stopLoading() at the end
			self!.fetchUsers()

			self!.table.dg_stopLoading()
			}, loadingView: loadingView)
		table.dg_setPullToRefreshFillColor(UIColor(red: 57 / 255.0, green: 67 / 255.0, blue: 89 / 255.0, alpha: 1.0))
		table.dg_setPullToRefreshBackgroundColor(table.backgroundColor!)

		fetchUsers()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(fetchUsers), name: "updateUsers", object: nil)

	}

	func fetchUsers() {

		if let arrUsers = NSUserDefaults.standardUserDefaults().arrayForKey("arrUsers") as? [String] {


			manager.fetchUsers(arrUsers) { (users) in
				self.arrayUsers = users
				self.table.reloadData()

			}
		}
	}

	@IBAction func butRefresh(sender: AnyObject) {

		fetchUsers()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func uniq < S: SequenceType, E: Hashable where E == S.Generator.Element > (source: S) -> [E] {
		var seen: [E: Bool] = [:]
		return source.filter { seen.updateValue(true, forKey: $0) == nil }
	}

}

extension UIScrollView {
	func dg_stopScrollingAnimation() { }
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
		points += NSAttributedString(string: " pts")

		cell.lblPointsUser.attributedText = points
		cell.imgvUser.image = user.userPic

		let ranking = indexPath.row + 1

		if ranking == 1 {
			cell.lblRankingUser.backgroundColor = UIColor(red: 245 / 255, green: 166 / 255, blue: 35 / 255, alpha: 1)
		}

		cell.lblRankingUser.text = "\(ranking)"

		// Sliding
		cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: UIColor.redColor(), callback: {
			(sender: MGSwipeTableCell!) -> Bool in
			print("Convenience callback for swipe buttons!")
			self.arrayUsers.removeAtIndex((self.table.indexPathForCell(cell)?.row)!)

			var names: [String] = []
			for user in self.arrayUsers {

				names.append(user.name)
			}
			NSUserDefaults.standardUserDefaults().setObject(names, forKey: "arrUsers")
			NSUserDefaults.standardUserDefaults().synchronize()

			self.table.reloadData()
			return true
			})
		]
		cell.leftSwipeSettings.transition = MGSwipeTransition.Rotate3D

		return cell
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

		if let detail = segue.destinationViewController as? DetailUserViewController {
			detail.user = arrayUsers[sender as! Int]

			let backItem = UIBarButtonItem()
			backItem.title = ""

			navigationItem.backBarButtonItem = backItem
		}
	}
}

extension ViewController: UITableViewDelegate {

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

		self.performSegueWithIdentifier("detail", sender: indexPath.row)
	}
}

