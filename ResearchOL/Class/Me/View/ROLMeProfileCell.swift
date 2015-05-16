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
//            var user = AVUser.currentUser()
//            var file: AVFile = user.objectForKey(ROLUserKeys.kUserAvatarKey) as! AVFile
            self.usernameLabel.text = item.username
        }
    }
    
    var delegate: ROLMeProfileCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        avatar.image = UIImage.circleImageWithName("avatar", borderWidth: 0, borderColor: UIColor.whiteColor())
        
        self.configueViews()
        self.configueNotifications()
        
//        self.avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    
    private func configueNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleAvatarDidChoseNotification:", name: "AvatarDidChoseNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleUserLoginNotification:", name: ROLNotifications.userLoginNotification, object: nil)
    }
    
    @objc private func handleUserLoginNotification(noti: NSNotification) {
        ROLUserInfoManager.sharedManager.getThumbnailAvatarForCurrentUser({ (image) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.avatar.image = image
            })
            }, failure: { (error) -> Void in
                
        })
    }
    
    @objc private func handleAvatarDidChoseNotification(noti: NSNotification) {
        self.avatar.image = noti.object as? UIImage
    }
    
    private func configueViews() {
        self.avatar.contentMode = UIViewContentMode.ScaleAspectFill;
        self.avatar.clipsToBounds = true;
        self.avatar.layer.cornerRadius = 5; //kAvatarHeight / 2.0;
        self.avatar.layer.borderColor = UIColor(fromHexString: "8A8A8A").CGColor;
        self.avatar.layer.borderWidth = 1.0
        
        if ROLUserInfoManager.sharedManager.isUserLogin {
            ROLUserInfoManager.sharedManager.getThumbnailAvatarForCurrentUser({ (image) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.avatar.image = image
                })
            }, failure: { (error) -> Void in
                
            })
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func heightForProfileCell() -> CGFloat {
        return 130
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "AvatarDidChoseNotification", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: ROLNotifications.userLoginNotification, object: nil)
    }
    
}
