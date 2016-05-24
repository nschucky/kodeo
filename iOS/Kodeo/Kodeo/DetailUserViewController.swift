//
//  DetailUserViewController.swift
//  Kodeo
//
//  Created by Lucas Farah on 5/23/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class DetailUserViewController: UIViewController {

	var user = User()
	var flowerChart: FlowerChart!
	var sizesArray = [5.0,6.0,7.0,8.0]
  var colorsArray: [UIColor] = [UIColor.blackColor(),UIColor.blueColor(),UIColor.greenColor(),UIColor.grayColor()]
	let totalPetals = 4 // Set any number of petals you need

  @IBOutlet weak var graph: UIView!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.

		if let issue = user.pointsDic!["IssueCommentEvent"] {
			print(issue)
		}

		let flowerChart = FlowerChart(petalCanvas: graph, totalPetals: totalPetals)
		self.flowerChart = flowerChart
		flowerChart.drawFlower(colorsArray)
		flowerChart.setPetalSizes(sizesArray)
    
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	/*
	 // MARK: - Navigation

	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	 // Get the new view controller using segue.destinationViewController.
	 // Pass the selected object to the new view controller.
	 }
	 */

}
