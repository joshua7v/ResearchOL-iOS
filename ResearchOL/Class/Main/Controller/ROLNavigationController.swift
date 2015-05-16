//
//  ROLNavigationController.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/11.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit
import ObjectiveC

class ROLNavigationController: UINavigationController {
    
    let menuIcon = "SESideMenu.bundle/navi_menu"
    
    // MARK: initialize
    override class func initialize() {
        var appearance = UINavigationBar.appearance()
        appearance.barTintColor = UIColor.whiteColor()
    }
    
    override func awakeFromNib() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "")
        self.navigationItem.title = "哈哈"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers.first?.navigationItem.leftBarButtonItem = UIBarButtonItem(icon: menuIcon, highIcon: menuIcon, target: self, action: "menuBtnDidClicked")
    }
    
    @objc private func menuBtnDidClicked() {
        NSNotificationCenter.defaultCenter().postNotificationName(ROLNotifications.showMenuNotification, object: nil)
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
    }
}
