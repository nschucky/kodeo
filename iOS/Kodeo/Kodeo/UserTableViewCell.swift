//
//  UserTableViewCell.swift
//  Kodeo
//
//  Created by Lucas Farah on 5/19/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

  @IBOutlet weak var imgvUser: UIImageView!
  @IBOutlet weak var lblNameUser: UILabel!
  
  @IBOutlet weak var lblPointsUser: UILabel!
  @IBOutlet weak var lblRankingUser: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
