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
    
    var phoneNumber = SESettingLabelArrowItem()
    var gender = SESettingLabelArrowItem()
    var age = SESettingLabelArrowItem()
    var hobby = SESettingLabelArrowItem()
    var location = SESettingLabelArrowItem()
    var income = SESettingLabelArrowItem()
    var job = SESettingLabelArrowItem()
    var edu = SESettingLabelArrowItem()
    var marriage = SESettingLabelArrowItem()
    
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
        var phoneNumberText = ROLUserInfoManager.sharedManager.getAttributeForCurrentUser(ROLUserKeys.kMobilePhoneNumberKey)
        var phoneNumber = SESettingLabelArrowItem(icon: nil, title: "手机号", text: phoneNumberText == "" ? "未填写" : phoneNumberText, destVcClass: nil)
        phoneNumber.operation = {
            var item: ROLEditItem = ROLEditItem()
            item.title = "手机号"
            item.type = 2
            var editNavVC = self.editController
            var editVC = editNavVC.viewControllers.first as! ROLEditController
            editVC.item = item
            editVC.delegate = self
            self.presentViewController(editNavVC, animated: true, completion: { () -> Void in
                editVC.indexPath = NSIndexPath(forRow: 0, inSection: 1)
            })
        }
        
        var genderText = ROLUserInfoManager.sharedManager.getAttributeForCurrentUser(ROLUserKeys.kGenderKey)
        var gender = SESettingLabelArrowItem(icon: nil, title: "性别", text: genderText == "" ? "未填写" : genderText, destVcClass: nil)
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
                editVC.indexPath = NSIndexPath(forRow: 1, inSection: 1)
            })
        }
        
        var ageText = ROLUserInfoManager.sharedManager.getAttributeForCurrentUser(ROLUserKeys.kAgeKey)
        var age = SESettingLabelArrowItem(icon: nil, title: "年龄", text: ageText == "" ? "未填写" : ageText, destVcClass: nil)
        age.operation = {
            var item: ROLEditItem = ROLEditItem()
            item.title = "年龄"
            item.type = 2
            var editNavVC = self.editController
            var editVC = editNavVC.viewControllers.first as! ROLEditController
            editVC.item = item
            editVC.delegate = self
            self.presentViewController(editNavVC, animated: true, completion: { () -> Void in
                editVC.indexPath = NSIndexPath(forRow: 2, inSection: 1)
            })
        }
        
        var hobbyText = ROLUserInfoManager.sharedManager.getAttributeForCurrentUser(ROLUserKeys.kHobbyKey)
        var hobby = SESettingLabelArrowItem(icon: nil, title: "爱好", text: hobbyText == "" ? "未填写" : hobbyText, destVcClass: nil)
        hobby.operation = {
            var item: ROLEditItem = ROLEditItem()
            item.title = "爱好"
            item.choices = ["逛街", "游戏", "阅读", "旅行", "艺术"]
            item.type = 1
            var editNavVC = self.editController
            var editVC = editNavVC.viewControllers.first as! ROLEditController
            editVC.item = item
            editVC.isSingleChoice = false
            editVC.delegate = self
            self.presentViewController(editNavVC, animated: true, completion: { () -> Void in
                editVC.indexPath = NSIndexPath(forRow: 3, inSection: 1)
            })
        }
        
        var locationText = ROLUserInfoManager.sharedManager.getAttributeForCurrentUser(ROLUserKeys.kLocationKey)
        var location = SESettingLabelArrowItem(icon: nil, title: "地区", text: locationText == "" ? "未填写" : locationText, destVcClass: nil)
        location.operation = {
            var item: ROLEditItem = ROLEditItem()
            item.title = "地区"
            item.type = 2
            var editNavVC = self.editController
            var editVC = editNavVC.viewControllers.first as! ROLEditController
            editVC.item = item
            editVC.delegate = self
            self.presentViewController(editNavVC, animated: true, completion: { () -> Void in
                editVC.indexPath = NSIndexPath(forRow: 4, inSection: 1)
            })
        }
        
        group.items = [phoneNumber, gender, age, hobby, location]
        
        self.phoneNumber = phoneNumber
        self.gender = gender
        self.age = age
        self.hobby = hobby
        self.location = location
    }
    
    private func setupGroup2() {
        var group = self.addGroup()
        var incomeText = ROLUserInfoManager.sharedManager.getAttributeForCurrentUser(ROLUserKeys.kMonthlyIncomeKey)
        var income = SESettingLabelArrowItem(icon: nil, title: "月收入", text: incomeText == "" ? "未填写" : incomeText, destVcClass: nil)
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
                editVC.indexPath = NSIndexPath(forRow: 0, inSection: 2)
            })
        }
        
        var jobText = ROLUserInfoManager.sharedManager.getAttributeForCurrentUser(ROLUserKeys.kJobStateIncomeKey)
        var job = SESettingLabelArrowItem(icon: nil, title: "就业状态", text: jobText == "" ? "未填写" : jobText, destVcClass: nil)
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
                editVC.indexPath = NSIndexPath(forRow: 1, inSection: 2)
            })
        }
        
        var eduText = ROLUserInfoManager.sharedManager.getAttributeForCurrentUser(ROLUserKeys.kEducationStateKey)
        var edu = SESettingLabelArrowItem(icon: nil, title: "教育程度", text: eduText == "" ? "未填写" : eduText, destVcClass: nil)
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
                editVC.indexPath = NSIndexPath(forRow: 2, inSection: 2)
            })
        }
        
        var marriageText = ROLUserInfoManager.sharedManager.getAttributeForCurrentUser(ROLUserKeys.kMarriageStateKey)
        var marriage = SESettingLabelArrowItem(icon: nil, title: "婚姻状况", text: marriageText == "" ? "未填写" : marriageText, destVcClass: nil)
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
                editVC.indexPath = NSIndexPath(forRow: 3, inSection: 2)
            })
        }
        
        group.items = [income, job, edu, marriage]
        
        self.income = income
        self.job = job
        self.edu = edu
        self.marriage = marriage
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
    func editControllerSaveButtonDidClicked(editController: ROLEditController, item: ROLEditItem, value: String) {
        self.setNewData(editController, item: item, value: value)
    }
    
    private func setNewData(editController: ROLEditController, item: ROLEditItem, value: String) {
        if editController.indexPath.section == 1 {
            switch editController.indexPath.row {
            case 0:
                self.phoneNumber.text = value
                self.tableView.reloadData()
            case 1:
                self.gender.text = value
                self.tableView.reloadData()
            case 2:
                self.age.text = value
                self.tableView.reloadData()
            case 3:
                self.hobby.text = value
                self.tableView.reloadData()
            case 4:
                self.location.text = value
                self.tableView.reloadData()
            default:
                println("----default----")
            }
        } else if editController.indexPath.section == 2 {
            switch editController.indexPath.row {
            case 0:
                self.income.text = value
                self.tableView.reloadData()
            case 1:
                self.job.text = value
                self.tableView.reloadData()
            case 2:
                self.edu.text = value
                self.tableView.reloadData()
            case 3:
                self.marriage.text = value
                self.tableView.reloadData()
            default:
                println("----default----")
            }
        }
    }
}
