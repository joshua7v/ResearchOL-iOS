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
        var item = UIBarButtonItem.appearance()
        appearance.barTintColor = UIColor.whiteColor()
        item.tintColor = UIColor.blackColor()
    }
    
    override func awakeFromNib() {
        
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
