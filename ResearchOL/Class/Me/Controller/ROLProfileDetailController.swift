//
//  ROLProfileDetailController.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/13.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLProfileDetailController: SESettingViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = SEColor(226, 226, 226)
        self.setupGroup0()
        self.hidesBottomBarWhenPushed = true
    }
    
    // MARK: - setup
    // MARK: setup first group
    func setupGroup0() {
        var group = self.addGroup()
        var nickName = SESettingArrowItem(title: "昵称:", destVcClass: UIViewController.classForCoder())
        var name = SESettingArrowItem(title: "姓名:", destVcClass: UIViewController.classForCoder())
        var identity = SESettingArrowItem(title: "身份证:", destVcClass: UIViewController.classForCoder())
        var gender = SESettingArrowItem(title: "性别:", destVcClass: UIViewController.classForCoder())
        var birth = SESettingArrowItem(title: "生日:", destVcClass: UIViewController.classForCoder())
        var mail = SESettingArrowItem(title: "邮箱:", destVcClass: UIViewController.classForCoder())
        group.items = [nickName, name, identity, gender, birth, mail]
    }
}
