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
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

extension ViewController: UITableViewDataSource {

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return 5
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell!
		if !(cell != nil) {
			cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
		}
		// setup cell without force unwrapping it
		cell.textLabel!.text = "Swift"
		return cell
	}
}

extension ViewController: UITableViewDelegate {

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

	}
}
