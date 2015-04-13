//
//  ROLMeProfileCell.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/13.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLMeProfileCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatar.image = UIImage.circleImageWithName("avatar", borderWidth: 0, borderColor: UIColor.whiteColor())
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func heightForProfileCell() -> CGFloat {
        return 100
    }
    
}
