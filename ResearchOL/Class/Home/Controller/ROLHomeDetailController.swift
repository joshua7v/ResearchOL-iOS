//
//  ROLHomeDetailController.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/18.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

protocol ROLHomeDetailControllerDelegate: NSObjectProtocol {
    func homeDetailControllerDidGetQuestions(homeDetailController: ROLHomeDetailController, questionare: ROLQuestionare)
}

class ROLHomeDetailController: UITableViewController {
    
    var questionare: ROLQuestionare = ROLQuestionare()
    var delegate: ROLHomeDetailControllerDelegate?
    var watch = false
    var sysBtnColor: UIColor {
        get {
            return UIButton().tintColor!
        }
    }
    
    @IBOutlet weak var watchBtn: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var participantLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var requiredTimeLabel: UILabel!
    @IBAction func watchBtnDIdClicked(sender: UIButton) {
        if !ROLUserInfoManager.sharedManager.isUserLogin {
            SEProgressHUDTool.showError("需要登录", toView: self.navigationController?.view, yOffset: 200)
            return
        }
        if !self.watch {
            sender.enabled = false
            sender.setTitle("关注中...", forState: .Normal)
            ROLUserInfoManager.sharedManager.watchQuestionareForCurrentUser(self.questionare.uuid, success: { () -> Void in
                sender.setTitleColor(UIColor.coolGrayColor(), forState: .Normal)
                sender.setTitle("已关注 √", forState: .Normal)
                sender.enabled = true
                self.watch = true
            }, failure: { () -> Void in
                sender.setTitle("关注问卷", forState: .Normal)
                sender.setTitleColor(self.sysBtnColor, forState: .Normal)
                sender.enabled = true
                self.watch = false
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    SEProgressHUDTool.showError("请检查网络", toView: self.view)
                })
            })
        } else {
            sender.enabled = false
            sender.setTitle("取消关注中...", forState: .Normal)
            ROLUserInfoManager.sharedManager.unWatchQuestionareForCurrentUser(self.questionare.uuid, success: { () -> Void in
                sender.setTitleColor(self.sysBtnColor, forState: .Normal)
                sender.setTitle("关注问卷", forState: .Normal)
                sender.enabled = true
                self.watch = false
                }, failure: { () -> Void in
                    sender.setTitle("已关注 √", forState: .Normal)
                    sender.setTitleColor(UIColor.coolGrayColor(), forState: .Normal)
                    sender.enabled = true
                    self.watch = true
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        SEProgressHUDTool.showError("请检查网络", toView: self.view)
                    })
            })
        }
    }
    
    @IBAction func startBtnClicked() {
        if !ROLUserInfoManager.sharedManager.isUserLogin {
            var alert = AMSmoothAlertView(dropAlertWithTitle: "提示", andText: "未登陆无法获得奖励哦", andCancelButton: true, forAlertType: AlertType.Info, andColor: UIColor.blackColor(), withCompletionHandler: { (alertView, button) -> Void in
                if button == alertView.defaultButton {
                    self.presentViewController(UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! UINavigationController, animated: true, completion: { () -> Void in
                        
                    })
                } else {
                    var dest = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ROLQuestionareController") as! ROLQuestionareController
                    dest.questions = self.questionare.questions
                    dest.questionareID = self.questionare.uuid
                    dest.isAnonymous = true
                    // reset answers in memory
                    ROLQuestionManager.sharedManager.resetAnswers()
                    self.presentViewController(dest, animated: true) { () -> Void in
                        
                    }
                }
            })
            alert.defaultButton.setTitle("去登录", forState: .Normal)
            alert.cancelButton.setTitle("匿名答题", forState: .Normal)
            alert.defaultButton.titleLabel?.font = UIFont.systemFontOfSize(13)
            alert.cancelButton.titleLabel?.font = UIFont.systemFontOfSize(13)
            alert.cornerRadius = 5
            alert.show()
            
            return
        }
        
        
        var dest = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ROLQuestionareController") as! ROLQuestionareController
        dest.questions = self.questionare.questions
        dest.questionareID = self.questionare.uuid
        // reset answers in memory
        ROLQuestionManager.sharedManager.resetAnswers()
        self.presentViewController(dest, animated: true) { () -> Void in
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.setupData()
    }
    
    // MARK: - private
    func setup() {
        self.navigationItem.title = "问卷详情"
        titleLabel.text = questionare.title
        descLabel.text = questionare.desc
        participantLabel.text = String(format: "%d 人", questionare.participant)
        pointLabel.text = String(format: "%d 积分", questionare.point)
        requiredTimeLabel.text = String(format: "%d 分钟", 3)
        
        self.watchBtn.enabled = false
    }
    
    func setupData() {
        if questionare.questions.count == 0 {
            self.startBtn.enabled = false
            self.startBtn.setTitle("数据加载中", forState: .Normal)
            self.indicator.hidden = false
            self.indicator.startAnimating()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            ROLQuestionManager.sharedManager.getQuestions(questionare.questionCount, questionare: questionare) { () -> Void in
                println("get questions success -- ")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.startBtn.setTitle("马上参与", forState: .Normal)
                    self.watchBtn.setTitle("关注问卷", forState: .Normal)
                    self.startBtn.enabled = true
                    self.watchBtn.enabled = true
                    self.indicator.stopAnimating()
                    self.indicator.hidden = true
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                })
                if (self.delegate?.respondsToSelector("homeDetailControllerDidGetQuestions:") != nil) {
                    self.delegate?.homeDetailControllerDidGetQuestions(self, questionare: self.questionare)
                }
            }
        } else {
            self.startBtn.setTitle("马上参与", forState: .Normal)
            self.watchBtn.setTitle("关注问卷", forState: .Normal)
            self.startBtn.enabled = true
            self.watchBtn.enabled = true
            self.indicator.stopAnimating()
            self.indicator.hidden = true
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        
        var watchList = ROLUserInfoManager.sharedManager.getWatchListForCurrentUser()
        for i in watchList {
            if self.questionare.uuid == i {
                self.watchBtn.setTitle("已关注 √", forState: .Normal)
                self.watchBtn.setTitleColor(UIColor.coolGrayColor(), forState: .Normal)
                self.watch = true
                return
            }
        }
        self.watchBtn.setTitle("关注问卷", forState: .Normal)
        self.watchBtn.setTitleColor(self.sysBtnColor, forState: .Normal)
        self.watch = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var dest = segue.destinationViewController as! ROLQuestionareController
        dest.questions = self.questionare.questions
        dest.questionareID = self.questionare.uuid
        // reset answers in memory
        ROLQuestionManager.sharedManager.resetAnswers()
    }
}
