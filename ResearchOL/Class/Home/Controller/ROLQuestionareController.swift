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
        self.tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 44, right: 0)
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
            title.text = "单选"
        } else if type == 2 {
            title.text = "多选"
        } else if type == 3 {
            title.text = "填写"
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
}