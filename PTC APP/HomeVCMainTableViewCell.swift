//
//  HomeVCMainTableViewCell.swift
//  PTC APP
//
//  Created by Jaldeep Patel on 2021-08-05.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import UIKit

class HomeVCMainTableViewCell: UITableViewCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var documentImageView: UIImageView!
    @IBOutlet var acitivityNameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        Utilities.addShadowAndBorderToView(containerView)
//        containerView.layer.borderWidth = 0
//        containerView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
