//
//  UserTableViewCell.swift
//  Kodeo
//
//  Created by Lucas Farah on 5/19/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import MGSwipeTableCell
class UserTableViewCell: MGSwipeTableCell {

  @IBOutlet weak var imgvUser: UIImageView!
  @IBOutlet weak var lblNameUser: UILabel!
  
  @IBOutlet weak var lblPointsUser: UILabel!
  @IBOutlet weak var lblRankingUser: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        imgvUser.layer.borderWidth = 0
        imgvUser.layer.masksToBounds = false
        imgvUser.layer.borderColor = UIColor.whiteColor().CGColor
        imgvUser.layer.cornerRadius = imgvUser.frame.height/2
        imgvUser.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
