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
    @IBOutlet weak var signinBtn: UIButton!
    @IBAction func signinBtnDidClicked(sender: UIButton) {
        sender.setTitle("签到中...", forState: .Normal)
        ROLUserInfoManager.sharedManager.addPointsForCurrentUser(5, success: { () -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                sender.setTitle("已签到", forState: .Normal)
                sender.enabled = false
//                var dict = [ROLUserInfoManager.sharedManager.currentUser?.objectId : NSDate.timeIntervalTo24()]
                var dict = NSMutableDictionary()
                dict.setObject(NSDate.timeIntervalTo24(), forKey: ROLUserInfoManager.sharedManager.currentUser!.objectId)
                NSUserDefaults.standardUserDefaults().setObject(dict, forKey: ROLUserKeys.kSignInTimeKey)
                NSUserDefaults.standardUserDefaults().synchronize()
            })
        }) { () -> Void in
                sender.setTitle("签到", forState: .Normal)
        }
    }
    
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
        self.pointsLabel.text = String(ROLUserInfoManager.sharedManager.getPointsForCurrentUser())
        self.answeredQuestionaresLabel.text = String(ROLUserInfoManager.sharedManager.getAnsweredQuestionaresNumberForCurrentUser())
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
        self.signinBtn.layer.borderWidth = 1
        self.signinBtn.layer.cornerRadius = 5
        self.signinBtn.layer.masksToBounds = true
        
        if ROLUserInfoManager.sharedManager.isUserLogin {
            self.pointsLabel.text = String(ROLUserInfoManager.sharedManager.getPointsForCurrentUser())
            self.answeredQuestionaresLabel.text = String(ROLUserInfoManager.sharedManager.getAnsweredQuestionaresNumberForCurrentUser())
            ROLUserInfoManager.sharedManager.getThumbnailAvatarForCurrentUser({ (image) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.avatar.image = image
                })
            }, failure: { (error) -> Void in
                
            })
        }
    
        var today = NSDate()
        var nowInterval = today.timeIntervalSince1970
        var dict = NSUserDefaults.standardUserDefaults().objectForKey(ROLUserKeys.kSignInTimeKey) as? NSMutableDictionary
        var interval = dict?.objectForKey(ROLUserInfoManager.sharedManager.currentUser!.objectId) as? NSTimeInterval
        if interval == nil { return }
        if nowInterval > interval {
            // enable signin
            self.signinBtn.setTitle("签到", forState: .Normal)
            self.signinBtn.enabled = true
        } else {
            // unenable signin
            self.signinBtn.setTitle("已签到", forState: .Normal)
            self.signinBtn.enabled = false
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
