//
//  ROLHomeController.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/16.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLHomeController: UIViewController {
    
    let firebaseRef = Firebase(url: "https://researchol.firebaseio.com")
    let segueId = "HOME2DETAIL"
    var heightForCell = CGFloat()
    var currentCell: ROLHomeCell = ROLHomeCell()
    
    lazy var questionares: [ROLQuestionare] = []
    var currentIndex = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let questionaresRef = firebaseRef.childByAppendingPath("questionares")
//        let questionare1 = ["title": "标题", "description": "描述"]
//        let questionare1Ref = questionaresRef.childByAutoId()
//        questionare1Ref.setValue(questionare1)
//
//        let questionare2 = ["title": "alanisawesome", "description": "The Turing Machine"]
//        let questionare2Ref = questionaresRef.childByAutoId()
//        questionare2Ref.setValue(questionare2)
//        let questionareRef = firebaseRef.childByAppendingPath("questionares").childByAutoId()
//        var question = ["title" : "xxx"]
//        questionareRef.setValue(question)
        
        self.setup()
    }
    
    // MARK: - private
    func setup() {
        tableView.registerNib(UINib(nibName: ROLCellIdentifiers.ROLHomeCell, bundle: nil), forCellReuseIdentifier: ROLCellIdentifiers.ROLHomeCell)
        self.tableView.backgroundColor = SEColor(226, 226, 226)
        
        // setup data
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        ROLQuestionManager.sharedManager.getQuestionares(6, success: { () -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                self.questionares = ROLQuestionManager.sharedManager.questionares
                self.tableView.reloadData()
            })
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var dest = segue.destinationViewController as! ROLHomeDetailController
        dest.questionare = self.questionares[self.currentIndex]
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ROLHomeController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questionares.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = ROLHomeCell.cellWithTableView(tableView, indexPath: indexPath)
        cell.item = self.questionares[indexPath.row]
        heightForCell = cell.heightForHomeCell()
        currentCell = cell
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ROLHomeController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return heightForCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.currentIndex = indexPath.row
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier(segueId, sender: nil)
        self.tableView.reloadData()
    }
}

// MARK: - ROLHomeDetailControllerDelegate
extension ROLHomeController: ROLHomeDetailControllerDelegate {
    func homeDetailControllerDidGetQuestions(homeDetailController: ROLHomeDetailController, questionare: ROLQuestionare) {
        self.questionares[self.currentIndex] = questionare
    }
}
