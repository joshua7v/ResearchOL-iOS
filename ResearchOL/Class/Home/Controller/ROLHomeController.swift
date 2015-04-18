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
    
    lazy var questionares: [ROLQuestionare] = []
    var currentIndex = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = SEColor(226, 226, 226)
        
//        let questionareRef = firebaseRef.childByAppendingPath("questionares").childByAutoId()
//        var question = ["title" : "xxx"]
//        questionareRef.setValue(question)
        
        ROLQuestionManager.sharedManager.getQuestionares { () -> Void in
            self.questionares = ROLQuestionManager.sharedManager.questionares
            self.tableView.reloadData()
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var dest = segue.destinationViewController as! ROLHomeDetailController
        dest.questionare = self.questionares[self.currentIndex]
    }
}

// MARK: - UITableViewDataSource
extension ROLHomeController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questionares.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = ROLHomeCell.cellWithTableView(tableView)
        cell.item = self.questionares[indexPath.row]
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ROLHomeController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ROLHomeCell.heightForHomeCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.currentIndex = indexPath.row
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier(segueId, sender: nil)
    }
}
