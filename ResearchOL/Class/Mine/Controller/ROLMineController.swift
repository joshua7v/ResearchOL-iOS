//
//  ROLMineController.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/21.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLMineController: UIViewController {

    @IBOutlet weak var finishedBtn: UIButton!
    @IBOutlet weak var watchBtn: UIButton!
    @IBOutlet weak var todoBtn: UIButton!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navViewUnderLine: UIView!
    @IBAction func todoBtnDidClicked(sender: UIButton) {
        self.configueUnderLineWithBtn(sender)
    }
    @IBAction func finishedBtnDidClicked(sender: UIButton) {
        self.configueUnderLineWithBtn(sender)
    }
    @IBAction func watchBtnDidClicked(sender: UIButton) {
        self.configueUnderLineWithBtn(sender)
    }
    
    private func configueUnderLineWithBtn(btn: UIButton) {
        UIView.animateWithDuration(NSTimeInterval(0.7), delay: 0, usingSpringWithDamping: 5.0, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.navViewUnderLine.x = btn.x
            self.navViewUnderLine.y = btn.height + 2
            self.navViewUnderLine.width = btn.width
        }) { (finished) -> Void in
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configueViews()
        self.configueNotifications()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.todoBtnDidClicked(self.todoBtn)
    }
    
    private func configueViews() {
        
//        self.tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 44, right: 0)
        self.tableView.registerNib(UINib(nibName: ROLCellIdentifiers.ROLNeedToLoginCell, bundle: nil), forCellReuseIdentifier: ROLCellIdentifiers.ROLNeedToLoginCell)
        self.tableView.backgroundColor = ROLColors.coolGrayColor
        
        if ROLUserInfoManager.sharedManager.isUserLogin {
            self.navView.hidden = false
        } else {
            self.navView.hidden = true
        }
    }
    
    private func configueNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleUserLoginNotification", name: ROLNotifications.userLoginNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleUserLogoutNotification", name: ROLNotifications.userLogoutNotification, object: nil)
    }
    
    @objc private func handleUserLoginNotification() {
        self.navView.hidden = false
    }
    
    @objc private func handleUserLogoutNotification() {
        self.navView.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: ROLNotifications.userLoginNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: ROLNotifications.userLogoutNotification, object: nil)
    }
}

extension ROLMineController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if ROLUserInfoManager.sharedManager.isUserLogin {
            return 0
        } else {
            return 1
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ROLUserInfoManager.sharedManager.isUserLogin {
            return 0
        } else {
            return 1
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if ROLUserInfoManager.sharedManager.isUserLogin {
            return UITableViewCell()
        } else {
            var cell = ROLNeedToLoginCell.cellWithTableView(tableView, indexPath: indexPath)
            cell.delegate = self
            
            return cell
        }
    }
}

extension ROLMineController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if ROLUserInfoManager.sharedManager.isUserLogin {
            return ROLMeProfileCell.heightForProfileCell()
        } else {
            return ROLNeedToLoginCell.heightForNeedToLoginCel()
        }
    }
}

extension ROLMineController: ROLNeedToLoginCellDelegate {
    func needToLoginCellLoginBtnDidClicked(cell: ROLNeedToLoginCell) {
        self.presentViewController(UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! UIViewController, animated: true, completion: nil)
    }
}