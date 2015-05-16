//
//  ROLEditController.swift
//  ResearchOL
//
//  Created by Joshua on 15/5/16.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

protocol ROLEditControllerDelegate: NSObjectProtocol {
    func editControllerSaveButtonDidClicked(editController: ROLEditController)
}

class ROLEditController: SESettingViewController {

    var delegate: ROLEditControllerDelegate?
    
    var item: ROLEditItem = ROLEditItem() {
        didSet {
            self.title = item.title
            if item.type == 2 {
                var group = self.addGroup()
                var i = SESettingTextFieldItem(placeholder: self.item.title)
                group.items = [i]
                group.header = "请输入"
            } else if item.type == 1 {
                var group = self.addGroup()
                var items: NSMutableArray = NSMutableArray()
                for i in 0 ..< item.choices.count {
                    var cell = SESettingArrowItem(title: item.choices[i])
                    items.addObject(cell)
                }
                group.items = items as [AnyObject]
                group.header = "请选择"
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
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    @objc private func cancelBtnDidClicked() {
        if (self.delegate?.respondsToSelector("editControllerSaveButtonDidClicked:") != nil) {
            self.delegate?.editControllerSaveButtonDidClicked(self)
        }
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
