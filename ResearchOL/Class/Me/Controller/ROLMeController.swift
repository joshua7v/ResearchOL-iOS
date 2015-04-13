//
//  ROLMeController.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/11.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLMeController: SESettingViewController {

    struct TableViewCellIdentifiers {
        static let ROLMeProfileCell = "ROLMeProfileCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupGroup0()
        self.setupGroup1()
        self.setupHeaderView()
        self.tableView.registerNib(UINib(nibName: TableViewCellIdentifiers.ROLMeProfileCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.ROLMeProfileCell)
    }
    
    // MARK: - setup
    // MARK: setup first group
    func setupGroup0() {
        var group = self.addGroup()
        var item = SESettingItem()
        group.items = [item]
    }
    
    // MARK: setup second group
    func setupGroup1() {
        var group = self.addGroup()
        var item = SESettingArrowItem(icon: "tabbar_more", title: "个人信息", destVcClass: ROLProfileDetailController.classForCoder())
        group.items = [item]
    }
    
    // MARK: setup headerView
    func setupHeaderView() {
        
    }
}

extension ROLMeController: UITableViewDataSource {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return super.numberOfSectionsInTableView(tableView)
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0) {
            var cell: ROLMeProfileCell = tableView.dequeueReusableCellWithIdentifier(TableViewCellIdentifiers.ROLMeProfileCell, forIndexPath: indexPath) as! ROLMeProfileCell
            return cell
        }
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
}

extension ROLMeController: UITableViewDelegate {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return ROLMeProfileCell.heightForProfileCell()
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}

