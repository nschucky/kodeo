//
//  FriendTableViewCell.swift
//  Kodeo
//
//  Created by Lucas Farah on 6/1/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

	@IBOutlet weak var imgvFriend: UIImageView!
	@IBOutlet weak var lblNameFriend: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}
