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
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var participantLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var requiredTimeLabel: UILabel!
    @IBAction func startBtnClicked() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    // MARK: - private
    func setup() {
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
                    self.startBtn.enabled = true
                    self.indicator.hidden = true
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                })
                if (self.delegate?.respondsToSelector("homeDetailControllerDidGetQuestions:") != nil) {
                    self.delegate?.homeDetailControllerDidGetQuestions(self, questionare: self.questionare)
                }
            }
        }
        self.navigationItem.title = "问卷详情"
        titleLabel.text = questionare.title
        descLabel.text = questionare.desc
        participantLabel.text = String(format: "%d 人", questionare.participant)
        pointLabel.text = String(format: "%d 积分", questionare.point)
        requiredTimeLabel.text = String(format: "%d 分钟", 3)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var dest = segue.destinationViewController as! ROLQuestionareController
        dest.questions = self.questionare.questions
        dest.questionareID = self.questionare.uuid
        // reset answers in memory
        ROLQuestionManager.sharedManager.resetAnswers()
    }
}
