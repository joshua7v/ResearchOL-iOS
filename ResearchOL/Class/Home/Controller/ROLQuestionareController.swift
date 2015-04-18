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
    var heightForCell = CGFloat()
    @IBOutlet weak var tableView: UITableView!
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
        self.tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - UITableViewDataSource
extension ROLQuestionareController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = ROLQuestionCell.cellWithTableView(tableView, indexPath: indexPath)
        cell.item = self.questions[indexPath.row]
        heightForCell = cell.heightForQuestionCell()
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ROLQuestionareController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return heightForCell
    }
}