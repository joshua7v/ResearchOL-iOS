//
//  ROLEditController.swift
//  ResearchOL
//
//  Created by Joshua on 15/5/16.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

protocol ROLEditControllerDelegate: NSObjectProtocol {
    func editControllerSaveButtonDidClicked(editController: ROLEditController, item: ROLEditItem, value: String)
}

class ROLEditController: SESettingViewController {

    var delegate: ROLEditControllerDelegate?
    var checkboxes: NSMutableArray = NSMutableArray()
    var isSingleChoice = true
    var textField = UITextField()
    var indexPath = NSIndexPath()
    
    var item: ROLEditItem = ROLEditItem() {
        didSet {
            self.title = item.title
            if item.type == 2 {
                var group = self.addGroup()
                var i = SESettingTextFieldItem(placeholder: self.item.title)
                self.textField = i.textField
                group.items = [i]
                group.header = "请输入"
            } else if item.type == 1 {
                var group = self.addGroup()
                var items: NSMutableArray = NSMutableArray()
                for i in 0 ..< item.choices.count {
//                    var cell = SESettingArrowItem(title: item.choices[i])
                    var cell = SESettingCheckboxItem(title: item.choices[i], checkState: false)
                    cell.checkbox.addTarget(self, action: "handleCheckboxTapped:", forControlEvents: UIControlEvents.TouchDown)
                    cell.checkbox.userInteractionEnabled = false
                    self.checkboxes.addObject(cell.checkbox)
                    items.addObject(cell)
                }
                group.items = items as [AnyObject]
                group.header = "请选择"
            }
        }
    }
    
    @objc private func handleCheckboxTapped(sender: M13Checkbox) {
        if self.isSingleChoice == false {
            if sender.checkState.value == M13CheckboxStateChecked.value {
                sender.checkState = M13CheckboxStateUnchecked
            } else {
                sender.checkState = M13CheckboxStateChecked
            }
            return
        }
        
        
        if sender.checkState.value == M13CheckboxStateChecked.value {
        } else {
            for i:M13Checkbox in self.checkboxes.copy() as! [M13Checkbox] {
                if i == sender {
                    i.checkState = M13CheckboxStateChecked
                } else {
                    i.checkState = M13CheckboxStateUnchecked
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "编辑信息"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style:  UIBarButtonItemStyle.Plain, target: self, action: "cancelBtnDidClicked")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style:  UIBarButtonItemStyle.Plain, target: self, action: "saveBtnDidClicked")
    }
    
    @objc private func saveBtnDidClicked() {
        println(item.title)
        
        var value = ""
        if item.type == 1 {
            if self.isSingleChoice {
                for i in enumerate(self.checkboxes.copy() as! [M13Checkbox]) {
                    if i.element.checkState.value == M13CheckboxStateChecked.value {
                        value = self.item.choices[i.index]
                    }
                }
            } else {
                for i in enumerate(self.checkboxes.copy() as! [M13Checkbox]) {
                    if i.element.checkState.value == M13CheckboxStateChecked.value {
                        value = value.stringByAppendingString("\(self.item.choices[i.index]), ")
                    }
                }
                var newValue: NSString = value
                value = newValue.substringToIndex(newValue.length - 2)
            }
        } else if item.type == 2 {
            value = self.textField.text
        }
        
        ROLUserInfoManager.sharedManager.saveAttributeForCurrentUser(item.title, value: value, success: { (finished) -> Void in
            println("attribute set success")
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
        }) { (error) -> Void in
            println("error \(error)")
            if error.code == 127 {
                SEProgressHUDTool.showError("请输入正确的手机号", toView: self.navigationController?.view)
            }
        }
        
        // change text in superview
        if (self.delegate?.respondsToSelector("editControllerSaveButtonDidClicked:") != nil) {
            self.delegate?.editControllerSaveButtonDidClicked(self, item: self.item, value: value)
        }
    }
    
    @objc private func cancelBtnDidClicked() {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ROLEditController: UITabBarDelegate {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var checkbox = self.checkboxes[indexPath.row] as! M13Checkbox
        self.handleCheckboxTapped(checkbox)
    }
}
