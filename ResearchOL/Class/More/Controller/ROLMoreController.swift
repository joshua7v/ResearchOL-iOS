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
        
        self.setupGroup0()
        self.setupGroup1()
    }
    
    // MARK: - setup
    // MARK: group0 - contact us
    func setupGroup0() {
        var group = self.addGroup()
        group.header = "联系我们"
        var contact = SESettingArrowItem(title: "联系方式", destVcClass: UIViewController.classForCoder())
        var bussiness = SESettingArrowItem(title: "我是企业 我要调查！", destVcClass: UIViewController.classForCoder())
        group.items = [contact, bussiness]
    }
    
    // MARK: group1 - about
    func setupGroup1() {
        var group = self.addGroup()
        group.header = "关于"
        var rate = SESettingArrowItem(title: "评分", destVcClass: UIViewController.classForCoder())
        var version = SESettingArrowItem(title: "当前版本", destVcClass: UIViewController.classForCoder())
        var questions = SESettingArrowItem(title: "常见问题", destVcClass: UIViewController.classForCoder())
        group.items = [rate, version, questions]
    }
}
