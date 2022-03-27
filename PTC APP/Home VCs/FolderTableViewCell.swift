//
//  FolderTableViewCell.swift
//  PTC APP
//
//  Created by Simranjot Singh on 2022-03-27.
//  Copyright © 2022 Gurlagan Bhullar. All rights reserved.
//


import UIKit

class FolderTableViewCell: UITableViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var documentImageView: UIImageView!
    @IBOutlet var folderNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
