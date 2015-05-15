//
//  ROLMeProfileCell.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/13.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

protocol ROLMeProfileCellDelegate: NSObjectProtocol {
    func meProfileCellAvatarDidClicked(cell: ROLMeProfileCell)
}

class ROLMeProfileCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var answeredQuestionaresLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBAction func avatarDidClicked(sender: UIButton) {
        if (self.delegate?.respondsToSelector("meProfileCellAvatarDidClicked:") != nil) {
            self.delegate?.meProfileCellAvatarDidClicked(self)
        }
    }
    var item: AVUser = AVUser() {
        didSet {
            self.usernameLabel.text = item.username
        }
    }
    
    var delegate: ROLMeProfileCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        avatar.image = UIImage.circleImageWithName("avatar", borderWidth: 0, borderColor: UIColor.whiteColor())
        
        self.configueViews()
        
//        self.avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    
    private func configueViews() {
        self.avatar.contentMode = UIViewContentMode.ScaleAspectFill;
        self.avatar.clipsToBounds = true;
        self.avatar.layer.cornerRadius = 5; //kAvatarHeight / 2.0;
        self.avatar.layer.borderColor = UIColor(fromHexString: "8A8A8A").CGColor;
        self.avatar.layer.borderWidth = 1.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func heightForProfileCell() -> CGFloat {
        return 130
    }
    
}
