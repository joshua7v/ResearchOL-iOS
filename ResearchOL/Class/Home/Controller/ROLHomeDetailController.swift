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
            })
        }
    }
    @IBAction func startBtnClicked() {
    
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
            self.startBtn.enabled = true
            self.watchBtn.enabled = true
            self.indicator.stopAnimating()
            self.indicator.hidden = true
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var dest = segue.destinationViewController as! ROLQuestionareController
        dest.questions = self.questionare.questions
        dest.questionareID = self.questionare.uuid
        // reset answers in memory
        ROLQuestionManager.sharedManager.resetAnswers()
    }
}
