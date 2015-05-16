//
//  ROLMeController.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/11.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLMeController: SESettingViewController {
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.tableView.registerNib(UINib(nibName: ROLCellIdentifiers.ROLMeProfileCell, bundle: nil), forCellReuseIdentifier: ROLCellIdentifiers.ROLMeProfileCell)
        self.tableView.registerNib(UINib(nibName: ROLCellIdentifiers.ROLNeedToLoginCell, bundle: nil), forCellReuseIdentifier: ROLCellIdentifiers.ROLNeedToLoginCell)
    }
    
    // MARK: - setup
    private func setup() {
        //        ROLUserInfoManager.sharedManager.isUserLogin
        self.tableView.contentInsetTop = -44;
        self.setupGroup0()
        self.setupGroup1()
        self.setupGroup2()
        self.setupHeaderView()
    }
    
    // MARK: setup first group
    private func setupGroup0() {
        var group = self.addGroup()
        var item = SESettingItem()
        group.items = [item]
    }
    
    // MARK: setup second group
    private func setupGroup1() {
        var group = self.addGroup()
//        var phoneNumber = SESettingArrowItem(icon: nil, title: "手机号", destVcClass: ROLProfileDetailController.classForCoder())
        var phoneNumber = SESettingLabelItem(title: "手机号", text: "未填写")
        phoneNumber.operation = {
            self.navigationController?.pushViewController(UIViewController(), animated: true)
        }
        var gender = SESettingArrowItem(icon: nil, title: "性别", destVcClass: ROLProfileDetailController.classForCoder())
        var age = SESettingArrowItem(icon: nil, title: "年龄", destVcClass: ROLProfileDetailController.classForCoder())
        var hobby = SESettingArrowItem(icon: nil, title: "爱好", destVcClass: ROLProfileDetailController.classForCoder())
        var location = SESettingArrowItem(icon: nil, title: "地区", destVcClass: ROLProfileDetailController.classForCoder())
        group.items = [phoneNumber, gender, age, hobby, location]
    }
    
    private func setupGroup2() {
        var group = self.addGroup()
        var income = SESettingArrowItem(icon: nil, title: "年收入", destVcClass: ROLProfileDetailController.classForCoder())
        var job = SESettingArrowItem(icon: nil, title: "就业状态", destVcClass: ROLProfileDetailController.classForCoder())
        var edu = SESettingArrowItem(icon: nil, title: "教育程度", destVcClass: ROLProfileDetailController.classForCoder())
        var marriage = SESettingArrowItem(icon: nil, title: "婚姻状况", destVcClass: ROLProfileDetailController.classForCoder())
        group.items = [income, job, edu, marriage]
    }
    
    // MARK: setup headerView
    private func setupHeaderView() {
        
    }
}

extension ROLMeController: UITableViewDataSource {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if ROLUserInfoManager.sharedManager.isUserLogin {
            return super.numberOfSectionsInTableView(tableView)
        } else {
            return 1
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ROLUserInfoManager.sharedManager.isUserLogin {
            return super.tableView(tableView, numberOfRowsInSection: section)
        } else {
            return 1
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if ROLUserInfoManager.sharedManager.isUserLogin {
            if (indexPath.section == 0) {
                var cell: ROLMeProfileCell = tableView.dequeueReusableCellWithIdentifier(ROLCellIdentifiers.ROLMeProfileCell, forIndexPath: indexPath) as! ROLMeProfileCell
                cell.item = AVUser.currentUser()
                cell.delegate = self
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
        if ROLUserInfoManager.sharedManager.isUserLogin {
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

extension ROLMeController: ROLMeProfileCellDelegate {
    func meProfileCellAvatarDidClicked(cell: ROLMeProfileCell) {
        
        var imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
}

extension ROLMeController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        NSNotificationCenter.defaultCenter().postNotificationName("AvatarDidChoseNotification", object: image, userInfo: nil)
        
        var imageData = UIImageJPEGRepresentation(image, 0.5)
        ROLUserInfoManager.sharedManager.saveAvatarForCurrentUser(imageData)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
