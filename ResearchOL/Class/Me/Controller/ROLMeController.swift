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
        
        self.setup()
        self.setupGroup0()
        self.setupGroup1()
        self.setupHeaderView()
        self.tableView.registerNib(UINib(nibName: ROLCellIdentifiers.ROLMeProfileCell, bundle: nil), forCellReuseIdentifier: ROLCellIdentifiers.ROLMeProfileCell)
        self.tableView.registerNib(UINib(nibName: ROLCellIdentifiers.ROLNeedToLoginCell, bundle: nil), forCellReuseIdentifier: ROLCellIdentifiers.ROLNeedToLoginCell)
    }
    
    // MARK: - setup
    func setup() {
        ROLUserInfoManager.sharedManager.isUserLogin()
    }
    
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
        if ROLUserInfoManager.sharedManager.isUserLogin() {
            return super.numberOfSectionsInTableView(tableView)
        } else {
            return 1
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ROLUserInfoManager.sharedManager.isUserLogin() {
            return super.tableView(tableView, numberOfRowsInSection: section)
        } else {
            return 1
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if ROLUserInfoManager.sharedManager.isUserLogin() {
            if (indexPath.section == 0) {
            var cell: ROLMeProfileCell = tableView.dequeueReusableCellWithIdentifier(ROLCellIdentifiers.ROLMeProfileCell, forIndexPath: indexPath) as! ROLMeProfileCell
                return cell
            } else {
                return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
            }
        } else {
            var cell = ROLNeedToLoginCell.cellWithTableView(tableView, indexPath: indexPath)
            cell.delegate = self
            
            return cell
        }
    }
}

extension ROLMeController: UITableViewDelegate {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if ROLUserInfoManager.sharedManager.isUserLogin() {
            if (indexPath.section == 0) {
                return ROLMeProfileCell.heightForProfileCell()
            }
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        } else {
            return ROLNeedToLoginCell.heightForNeedToLoginCel()
        }
    }
}

extension ROLMeController: ROLNeedToLoginCellDelegate {
    func needToLoginCellLoginBtnDidClicked(cell: ROLNeedToLoginCell) {
        self.presentViewController(UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! UIViewController, animated: true, completion: nil)
    }
}
