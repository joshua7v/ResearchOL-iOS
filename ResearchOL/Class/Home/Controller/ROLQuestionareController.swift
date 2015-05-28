//
//  ROLQuestionareController.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/18.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLQuestionareController: UIViewController {

    lazy var questions: [ROLQuestion] = []
    var questionareID = ""
    var selectedIndexPath: NSIndexPath?
    var heightForCell = CGFloat()
    var answeredQuestions: NSMutableArray = NSMutableArray()
    var anonymousCheckbox = M13Checkbox()
    var isAnonymous = false
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - private
    func setup() {
        self.tableView.backgroundColor = SEColor(231, 231, 236)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.registerNib(UINib(nibName: ROLCellIdentifiers.ROLQuestionCell, bundle: nil), forCellReuseIdentifier: ROLCellIdentifiers.ROLQuestionCell)
        self.tableView.estimatedRowHeight = 44
        self.tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 44, right: 0)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "beginEditing:", name: "beginEditing", object: nil)
        
        var checkbox = M13Checkbox(title: "匿名")
        checkbox.checkAlignment = M13CheckboxAlignmentLeft
        checkbox.centerY = self.titleView.centerY
        checkbox.right = UIScreen.width() - 10
        checkbox.checkColor = UIColor.blackColor()
        checkbox.strokeColor = UIColor.blackColor()
        checkbox.radius = 30
        checkbox.titleLabel.font = UIFont.systemFontOfSize(14)
        if self.isAnonymous {
            checkbox.checkState = M13CheckboxStateChecked
            checkbox.enabled = false
        } else {
            checkbox.checkState = M13CheckboxStateUnchecked
            checkbox.enabled = true
        }
        self.anonymousCheckbox = checkbox
        self.topView.addSubview(checkbox)
    }
    
    func setFinishBtn() {
        if self.answeredQuestions.count != self.questions.count {
            self.finishBtn.enabled = false
        } else {
            self.finishBtn.enabled = true
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "beginEditing", object: nil)
    }
    
    // MARK: action
    @IBAction func skipBtnClicked() {
        ROLQuestionManager.sharedManager.saveAswerToMemoryWithQuestionareID(self.questionareID)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func finishBtnClicked(sender: UIButton) {
        if self.anonymousCheckbox.checkState.value == M13CheckboxStateUnchecked.value {
            ROLQuestionManager.sharedManager.setAnswerSheetToServer(ROLUserInfoManager.sharedManager.currentUser!, questionareID: self.questionareID, success: { () -> Void in
                ROLUserInfoManager.sharedManager.setAnsweredQuestionareForCurrentUser(self.questionareID, success: { () -> Void in
                    NSNotificationCenter.defaultCenter().postNotificationName(ROLNotifications.userDidFinishedAnswerQuestionareNotification, object: nil)
                }, failure: { () -> Void in
                    
                })
                println("save to server - success")
            })
        } else if self.anonymousCheckbox.checkState.value == M13CheckboxStateChecked.value {
            var user = AVUser()
            user.username = "anonymous"
            ROLQuestionManager.sharedManager.setAnswerSheetToServer(user, questionareID: self.questionareID, success: { () -> Void in
                println("save to server - success")
            })
        }
        NSNotificationCenter.defaultCenter().postNotificationName(ROLNotifications.userFinishedAnswerQuestionareNotification, object: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: notification
    func beginEditing(noti: NSNotification) {
        var indexPath = NSIndexPath(forRow: 0, inSection: noti.object! as! Int)
        self.selectedIndexPath = indexPath
    }
    
    func keyboardWillShow(noti: NSNotification) {
        // frame
        var keyboardF = noti.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
        
        // duration
        var duration = noti.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        
        // animate
        UIView.animateWithDuration(duration, animations: { () -> Void in
            if self.selectedIndexPath?.section > 1 {
                self.view.transform = CGAffineTransformMakeTranslation(0, -keyboardF!.height)
            } else {
                self.bottomView.transform = CGAffineTransformMakeTranslation(0, -keyboardF!.height)
            }
        }, completion: nil)
    }
    
    func keyboardWillHide(noti: NSNotification) {
        // duration
        var duration = noti.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        
        // animate
        UIView.animateWithDuration(duration, animations: { () -> Void in
            if self.selectedIndexPath?.section > 1 {
                self.view.transform = CGAffineTransformIdentity
            } else {
                self.bottomView.transform = CGAffineTransformIdentity
            }
        }, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource
extension ROLQuestionareController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.questions.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = ROLQuestionCell.cellWithTableView(tableView, indexPath: indexPath)
        cell.delegate = self
        cell.index = indexPath.section
        cell.item = self.questions[indexPath.section]
        
//        var dict = ROLQuestionManager.sharedManager.answerDict[self.questionareID]
//        if dict != nil {
//            var answer = dict![indexPath.section]
//            if answer != nil {
//                cell.cachedAnswer = answer!
//            }
//        }
        
        heightForCell = cell.heightForQuestionCell()
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view = UIView()
        var title = UILabel(frame: CGRectMake(10, 3, 100, 20))
        let type = self.questions[section].type
        if type == 1 {
            title.text = "\(section+1). " + "单选"
        } else if type == 2 {
            title.text = "\(section+1). " + "多选"
        } else if type == 3 {
            title.text = "\(section+1). " + "填写"
        }
        
        title.font = UIFont.systemFontOfSize(13)
        title.textColor = UIColor.black50PercentColor()
        view.addSubview(title)
        return view
    }
}

// MARK: - UITableViewDelegate
extension ROLQuestionareController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return heightForCell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension ROLQuestionareController: ROLQuestionCellDelegate {
    func questionCellDidSelectAnswer(questionCell: ROLQuestionCell, indexPath: NSIndexPath) {
        if !self.answeredQuestions.containsObject(indexPath.section) {
            self.answeredQuestions.addObject(indexPath.section)
        }
        self.setFinishBtn()
    }
    func questionCellDidDeSelectAnswer(questionCell: ROLQuestionCell, indexPath: NSIndexPath) {
        if self.answeredQuestions.containsObject(indexPath.section) {
            self.answeredQuestions.removeObject(indexPath.section)
        }
        self.setFinishBtn()
    }
}
