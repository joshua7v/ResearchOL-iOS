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
    var selectedIndexPath: NSIndexPath?
    var heightForCell = CGFloat()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBAction func skipBtnClicked() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
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
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "beginEditing", object: nil)
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
        cell.index = indexPath.section
        cell.item = self.questions[indexPath.section]
        heightForCell = cell.heightForQuestionCell()
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view = UIView()
        var title = UILabel(frame: CGRectMake(10, 3, 100, 20))
        let type = self.questions[section].type
        if type == 1 {
            title.text = "\(section). " + "单选"
        } else if type == 2 {
            title.text = "\(section). " + "多选"
        } else if type == 3 {
            title.text = "\(section). " + "填写"
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
