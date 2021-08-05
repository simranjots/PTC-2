//
//  SideMenuTableViewCell.swift
//  PTC APP
//
//  Created by Jaldeep Patel on 2021-08-04.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var menuIconImageView: UIImageView!
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var menuIconView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        menuIconView.layer.borderWidth = 1
        menuIconView.layer.cornerRadius = 25
        menuIconView.layer.borderColor = Utilities.secondaryTextColor.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
