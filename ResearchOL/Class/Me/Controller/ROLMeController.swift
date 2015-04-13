//
//  ROLMeController.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/11.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLMeController: SESettingViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupGroup01()
        self.setupGroup02()
        self.setupHeaderView()
    }
    
    // MARK: - setup
    // MARK: setup first group
    func setupGroup01() {
        var group = self.addGroup()
        var item = SESettingArrowItem(icon: "tabbar_more", title: "个人信息", destVcClass: UITableViewController.classForCoder())
        group.items = [item]
    }
    
    // MARK: setup second group
    func setupGroup02() {
        var group = self.addGroup()
        var item = SESettingArrowItem(icon: "tabbar_more", title: "个人信息", destVcClass: UITableViewController.classForCoder())
        group.items = [item]
    }
    
    // MARK: setup headerView
    func setupHeaderView() {
        
    }
}

extension ROLMeController: UITabBarDelegate {
    
}