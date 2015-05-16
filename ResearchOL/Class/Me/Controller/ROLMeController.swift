//
//  ROLMeController.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/11.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLMeController: SESettingViewController {
    let storyboardIdForEdit = "ROLEditController"
    
    var editController: ROLNavigationController {
        get {
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(self.storyboardIdForEdit) as! ROLNavigationController
        }
    }
    
    @IBAction func logoutBtnDidClicked(sender: UIBarButtonItem) {
        ROLUserInfoManager.sharedManager.resignUser()
    }
    
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
        var phoneNumber = SESettingLabelArrowItem(icon: nil, title: "手机号", text: "未填写", destVcClass: nil)
        phoneNumber.operation = {
            var item: ROLEditItem = ROLEditItem()
            item.title = "手机号"
            item.type = 2
            var editNavVC = self.editController
            var editVC = editNavVC.viewControllers.first as! ROLEditController
            editVC.item = item
            editVC.delegate = self
            self.presentViewController(editNavVC, animated: true, completion: { () -> Void in
                
            })
        }
        
        var gender = SESettingLabelArrowItem(icon: nil, title: "性别", text: "未填写", destVcClass: nil)
        gender.operation = {
            var item: ROLEditItem = ROLEditItem()
            item.title = "性别"
            item.choices = ["男", "女"]
            item.type = 1
            var editNavVC = self.editController
            var editVC = editNavVC.viewControllers.first as! ROLEditController
            editVC.item = item
            editVC.delegate = self
            self.presentViewController(editNavVC, animated: true, completion: { () -> Void in
                
            })
        }
        var age = SESettingLabelArrowItem(icon: nil, title: "年龄", text: "未填写", destVcClass: nil)
        age.operation = {
            var item: ROLEditItem = ROLEditItem()
            item.title = "年龄"
            item.type = 2
            var editNavVC = self.editController
            var editVC = editNavVC.viewControllers.first as! ROLEditController
            editVC.item = item
            editVC.delegate = self
            self.presentViewController(editNavVC, animated: true, completion: { () -> Void in
                
            })
        }
        
        var hobby = SESettingLabelArrowItem(icon: nil, title: "爱好", text: "未填写", destVcClass: nil)
        hobby.operation = {
            var item: ROLEditItem = ROLEditItem()
            item.title = "爱好"
            item.choices = ["逛街", "游戏", "阅读", "旅行", "艺术"]
            item.type = 1
            var editNavVC = self.editController
            var editVC = editNavVC.viewControllers.first as! ROLEditController
            editVC.item = item
            editVC.delegate = self
            self.presentViewController(editNavVC, animated: true, completion: { () -> Void in
                
            })
        }
        
        var location = SESettingLabelArrowItem(icon: nil, title: "地区", text: "未填写", destVcClass: nil)
        location.operation = {
            var item: ROLEditItem = ROLEditItem()
            item.title = "地区"
            item.type = 2
            var editNavVC = self.editController
            var editVC = editNavVC.viewControllers.first as! ROLEditController
            editVC.item = item
            editVC.delegate = self
            self.presentViewController(editNavVC, animated: true, completion: { () -> Void in
                
            })
        }
        
        group.items = [phoneNumber, gender, age, hobby, location]
    }
    
    private func setupGroup2() {
        var group = self.addGroup()
        var income = SESettingLabelArrowItem(icon: nil, title: "月收入", text: "未填写", destVcClass: nil)
        income.operation = {
            var item: ROLEditItem = ROLEditItem()
            item.title = "月收入"
            item.choices = ["0 ~ 1999", "2000 ~ 3999", "4000 ~ 6999", "7000 ~ 9999", "10000 ~ 19999", "20000 以上"]
            item.type = 1
            var editNavVC = self.editController
            var editVC = editNavVC.viewControllers.first as! ROLEditController
            editVC.item = item
            editVC.delegate = self
            self.presentViewController(editNavVC, animated: true, completion: { () -> Void in
                
            })
        }
        
        var job = SESettingLabelArrowItem(icon: nil, title: "就业状态", text: "未填写", destVcClass: nil)
        job.operation = {
            var item: ROLEditItem = ROLEditItem()
            item.title = "就业状态"
            item.choices = ["未参加工作", "工作中", "待业中", "已退休"]
            item.type = 1
            var editNavVC = self.editController
            var editVC = editNavVC.viewControllers.first as! ROLEditController
            editVC.item = item
            editVC.delegate = self
            self.presentViewController(editNavVC, animated: true, completion: { () -> Void in
                
            })
        }
        
        var edu = SESettingLabelArrowItem(icon: nil, title: "教育程度", text: "未填写", destVcClass: nil)
        edu.operation = {
            var item: ROLEditItem = ROLEditItem()
            item.title = "教育程度"
            item.choices = ["小学", "初中", "高中", "大学", "硕士", "博士"]
            item.type = 1
            var editNavVC = self.editController
            var editVC = editNavVC.viewControllers.first as! ROLEditController
            editVC.item = item
            editVC.delegate = self
            self.presentViewController(editNavVC, animated: true, completion: { () -> Void in
                
            })
        }
        
        var marriage = SESettingLabelArrowItem(icon: nil, title: "婚姻状况", text: "未填写", destVcClass: nil)
        marriage.operation = {
            var item: ROLEditItem = ROLEditItem()
            item.title = "婚姻状况"
            item.choices = ["未婚", "已婚", "离异"]
            item.type = 1
            var editNavVC = self.editController
            var editVC = editNavVC.viewControllers.first as! ROLEditController
            editVC.item = item
            editVC.delegate = self
            self.presentViewController(editNavVC, animated: true, completion: { () -> Void in
                
            })
        }
        
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

extension ROLMeController: ROLEditControllerDelegate {
    func editControllerSaveButtonDidClicked(editController: ROLEditController) {
        
    }
}
