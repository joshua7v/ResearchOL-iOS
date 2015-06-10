//
//  ROLMoreController.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/12.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLMoreController: SESettingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "设置"
        self.setupGroup0()
        self.setupGroup1()
    }
    
    // MARK: - setup
    // MARK: group0 - contact us
    func setupGroup0() {
        var group = self.addGroup()
        var contact = SESettingArrowItem(title: "联系方式", destVcClass: UITableViewController.classForCoder())
        var bussiness = SESettingArrowItem(title: "我是企业 我要调查！", destVcClass: UITableViewController.classForCoder())
        group.items = [contact, bussiness]
    }
    
    // MARK: group1 - about
    func setupGroup1() {
        var group = self.addGroup()
        var rate = SESettingArrowItem(title: "评分", destVcClass: UITableViewController.classForCoder())
        var version = SESettingLabelItem(title: "版本", text: "0.1.4")
        var questions = SESettingArrowItem(title: "常见问题", destVcClass: UITableViewController.classForCoder())
        group.items = [rate, version, questions]
    }
}
