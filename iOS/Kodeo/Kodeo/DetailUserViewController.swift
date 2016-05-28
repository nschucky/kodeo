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
////	var flowerChart: FlowerChart!
//	var sizesArray = [5.0,6.0,7.0,8.0]
//  var colorsArray: [UIColor] = [UIColor.blackColor(),UIColor.blueColor(),UIColor.greenColor(),UIColor.grayColor()]
//	let totalPetals = 4 // Set any number of petals you need

    @IBOutlet var userProfile: UIImageView!
    @IBOutlet var animatedGraph: UIView!
    @IBOutlet var Graph: UIView!
    
    @IBOutlet var pullStats: UILabel!
    @IBOutlet var pushStats: UILabel!
    @IBOutlet var issueStats: UILabel!
    @IBOutlet var commentStats: UILabel!
    
    
  
    var graphView = GraphView()
    var currentGraphType = GraphType.Dark
    var graphConstraints = [NSLayoutConstraint]()
    
    var label = UILabel()
    var labelConstraints = [NSLayoutConstraint]()
    
    // Data
    let numberOfDataItems = 29
    
    lazy var data: [Double] = self.generateRandomData(self.numberOfDataItems, max: 50)
    lazy var labels: [String] = self.generateSequentialLabels(self.numberOfDataItems, text: "FEB")

	override func viewDidLoad() {
		super.viewDidLoad()
        graphView = GraphView(frame: self.animatedGraph.frame)
        graphView = createDarkGraph(self.view.frame)
        graphView.setData(data, withLabels: labels)
        
        self.view.addSubview(graphView)
        print(user.userPic)
        self.userProfile.image = user.userPic
        self.userProfile.layer.borderWidth = 0
        self.userProfile.layer.masksToBounds = false
        self.userProfile.layer.cornerRadius = userProfile.frame.height/2
        self.userProfile.clipsToBounds = true
        
        
        print(user.PullRequest)
        self.pullStats.text = user.PullRequest.toString
        
        print(user.Push)
        self.pushStats.text = user.Push.toString
        
        print(user.NewIssue)
        self.issueStats.text = user.NewIssue.toString
        
        print(user.Comment)
        self.commentStats.text = user.Comment.toString
       
        setupConstraints()
        

		// Do any additional setup after loading the view.

//		if let issue = user.pointsDic!["IssueCommentEvent"] {
//			print(issue)
//		}
//
//		let flowerChart = FlowerChart(petalCanvas: graph, totalPetals: totalPetals)
//		self.flowerChart = flowerChart
//		flowerChart.drawFlower(colorsArray)
//		flowerChart.setPetalSizes(sizesArray)
    
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

    private func createDarkGraph(frame: CGRect) -> GraphView {
        let graphView = GraphView(frame: frame)
        
        graphView.backgroundFillColor = UIColor.colorFromHex("#333333")
        
        graphView.lineWidth = 1
        graphView.lineColor = UIColor.colorFromHex("#777777")
        graphView.lineStyle = GraphViewLineStyle.Smooth
        
        graphView.shouldFill = true
        graphView.fillType = GraphViewFillType.Gradient
        graphView.fillColor = UIColor.colorFromHex("#555555")
        graphView.fillGradientType = GraphViewGradientType.Linear
        graphView.fillGradientStartColor = UIColor.colorFromHex("#555555")
        graphView.fillGradientEndColor = UIColor.colorFromHex("#444444")
        
        graphView.dataPointSpacing = 80
        graphView.dataPointSize = 2
        graphView.dataPointFillColor = UIColor.whiteColor()
        
        graphView.referenceLineLabelFont = UIFont.boldSystemFontOfSize(8)
        graphView.referenceLineColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
        graphView.referenceLineLabelColor = UIColor.whiteColor()
        graphView.numberOfIntermediateReferenceLines = 5
        graphView.dataPointLabelColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
        graphView.shouldAnimateOnStartup = true
        graphView.shouldAdaptRange = true
        graphView.adaptAnimationType = GraphViewAnimationType.Elastic
        graphView.animationDuration = 1.5
        graphView.rangeMax = 50
        graphView.shouldRangeAlwaysStartAtZero = true
        
        return graphView
    }
    private func setupConstraints() {
        
        self.graphView.translatesAutoresizingMaskIntoConstraints = false
        graphConstraints.removeAll()
        
        let topConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 250)
        let rightConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
        
        //let heightConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
        
        graphConstraints.append(topConstraint)
        graphConstraints.append(bottomConstraint)
        graphConstraints.append(leftConstraint)
        graphConstraints.append(rightConstraint)
        
        //graphConstraints.append(heightConstraint)
        
        self.view.addConstraints(graphConstraints)
    }
    
    //Data Generation
    private func generateRandomData(numberOfItems: Int, max: Double) -> [Double] {
        var data = [Double]()
        for _ in 0 ..< numberOfItems {
            var randomNumber = Double(random()) % max
            
            if(random() % 100 < 10) {
                randomNumber *= 3
            }
            
            data.append(randomNumber)
        }
        return data
    }
    
    private func generateSequentialLabels(numberOfItems: Int, text: String) -> [String] {
        var labels = [String]()
        for i in 0 ..< numberOfItems {
            labels.append("\(text) \(i+1)")
        }
        return labels
    }
    
    // The type of the current graph we are showing.
    enum GraphType {
        case Dark
        case Dot
        case Pink
        
        mutating func next() {
            switch(self) {
            case .Dark:
                self = GraphType.Dot
            case .Dot:
                self = GraphType.Pink
            case .Pink:
                self = GraphType.Dark
            }
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
