//
//  ROLTabBarController.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/11.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLTabBarController: UITabBarController, UIGestureRecognizerDelegate {

    let sideMenu = SESideMenu()
    let kMenuWidth: CGFloat = 240
    let coverView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.width(), height: UIScreen.height()))
//    var edgePanRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "handleEdgePanRecognizer:")
    let storyboardIdForMe = "ROLMeController"
    let storyboardIdForMore = "ROLMoreController"
    let storyboardIdForAbout = "ROLAboutController"
    let storyboardIdForFeedback = "ROLFeedbackController"
    let coverViewAlpha: CGFloat = 0.25
    
    var progress: CGFloat = 0
    var currentIndex = 0
    var edgePanRecognizer: UIScreenEdgePanGestureRecognizer?
    var coverTapRecognizer: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configueBlocks()
        self.configueGestrues()
        self.configueViews()
        self.configueNotifications()
//        self.setBlurredScreenShoot()
    }
    
    private func configueNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "sideMenuWillShow", name: ROLNotifications.showMenuNotification, object: nil)
    }
    
    @objc private func sideMenuWillShow() {
        self.coverView.hidden = false
        self.coverView.alpha = 0
        UIView.animateWithDuration(NSTimeInterval(0.5), delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.coverView.alpha = self.coverViewAlpha
                self.setMenuOffset(self.kMenuWidth)
            }) { (finished) -> Void in
        }
    }
    
    private func configueBlocks() {
        self.sideMenu.avatarBtnDidClickedBlock = {
            if ROLUserInfoManager.sharedManager.isUserLogin {
                UIView.animateWithDuration(NSTimeInterval(0.3), animations: { () -> Void in
                    self.setMenuOffset(0)
                    self.coverView.hidden = true
                })
                self.showControllerWithIndex(5)
            } else {
                UIView.animateWithDuration(NSTimeInterval(0.3), animations: { () -> Void in
                    self.setMenuOffset(0)
                    self.coverView.hidden = true
                })
                
                UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! UINavigationController, animated: true, completion: { () -> Void in
                    
                })
            }
        }
        
        self.sideMenu.didSelectedIndexBlock = { (index) -> Void in
            UIView.animateWithDuration(NSTimeInterval(0.3), animations: { () -> Void in
                self.setMenuOffset(0)
                self.coverView.hidden = true
            })
            self.showControllerWithIndex(index)
        }
    }
    
    private func showControllerWithIndex(index: NSInteger) {
        if currentIndex == index { return }
        self.sideMenu.removeFromSuperview()
        self.coverView.removeFromSuperview()
        self.coverView.hidden = true
        
        var nextController: UIViewController? = nil
        switch index {
        case 0:
            nextController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ROLTabBarController
            self.currentIndex = 0
        case 1:
            nextController = UITableViewController()
            self.currentIndex = 1
        case 2:
            nextController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(self.storyboardIdForMore) as! ROLNavigationController
            self.currentIndex = 2
        case 3:
            nextController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(self.storyboardIdForFeedback) as! ROLNavigationController
            self.currentIndex = 3
        case 4:
            nextController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(self.storyboardIdForAbout) as! ROLNavigationController
            self.currentIndex = 4
        case 5:
            nextController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(self.storyboardIdForMe) as! ROLNavigationController
            self.currentIndex = 5
        default:
            nextController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ROLTabBarController
            self.currentIndex = 0
        }
        
        if !nextController!.isKindOfClass(ROLTabBarController.classForCoder()) {
            nextController?.view.addGestureRecognizer(self.edgePanRecognizer!)
            nextController?.view.addSubview(self.coverView)
            nextController?.view.subviews.last!.addGestureRecognizer(self.coverTapRecognizer!)
            nextController?.view.addSubview(self.sideMenu)
        }
        
        UIApplication.sharedApplication().keyWindow?.rootViewController = nextController
//        self.view.window?.rootViewController = nextController
    }
    
    deinit {
        println("--------deinit-----")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: ROLNotifications.showMenuNotification, object: nil)
    }
    
    private func configueViews() {
        self.coverView.backgroundColor = UIColor(hexString: "000000")
        self.coverView.hidden          = true
        self.coverView.alpha = self.coverViewAlpha
        self.view.addSubview(self.coverView)

        self.sideMenu.frame            = CGRect(x: -kMenuWidth, y: 0, width: kMenuWidth, height: UIScreen.height())
        self.view.addSubview(self.sideMenu)
    }
    
    private func configueGestrues() {
        var edgePanRecognizer      = UIScreenEdgePanGestureRecognizer(target: self, action: "handleEdgePanRecognizer:")
        edgePanRecognizer.edges    = UIRectEdge.Left
        edgePanRecognizer.delegate = self
        self.edgePanRecognizer = edgePanRecognizer
        self.view.addGestureRecognizer(edgePanRecognizer)

        var coverTapRecognizer      = UITapGestureRecognizer(target: self, action: "handleCoverTapRecognizer:")
        coverTapRecognizer.delegate = self
        self.coverTapRecognizer = coverTapRecognizer
        self.coverView.addGestureRecognizer(coverTapRecognizer)
    }
    
    private func setBlurredScreenShoot() {
        var screenShot = self.view.screenshot()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            var blurColor = UIColor(white: 0.970, alpha: self.coverViewAlpha)
            screenShot = screenShot.applyBlurWithRadius(12.0, tintColor: blurColor, saturationDeltaFactor: 1, maskImage: nil)
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.sideMenu.blurredImage = screenShot
            })
        })
    }
    
    @objc private func leftBarButtonItemDidClicked() {
        UIView.animateWithDuration(NSTimeInterval((1 - progress) / 1.5), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.setMenuOffset(self.kMenuWidth)
            }, completion: nil)
    }
    
    @objc private func handleCoverTapRecognizer(recognizer: UITapGestureRecognizer) {
        UIView.animateWithDuration(NSTimeInterval(0.3), animations: { () -> Void in
            self.setMenuOffset(0)
            self.coverView.hidden = true
        })
    }
    
    @objc private func handleEdgePanRecognizer(recognizer: UIScreenEdgePanGestureRecognizer) {
        var translation = recognizer.translationInView(self.view)
        var progress = translation.x / kMenuWidth
        progress = min(1.0, max(0.0, progress))
        self.progress = progress
        
        if recognizer.state == UIGestureRecognizerState.Began {
            self.coverView.hidden = false
            self.coverView.alpha = self.coverViewAlpha * progress
        } else if recognizer.state == UIGestureRecognizerState.Changed {
            self.setMenuOffset(kMenuWidth * progress)
            self.coverView.alpha = self.coverViewAlpha * progress
        } else if recognizer.state == UIGestureRecognizerState.Ended || recognizer.state == UIGestureRecognizerState.Cancelled {
            var velocity = recognizer.velocityInView(self.view).x
            if velocity > 20 || progress > 0.5 {
                UIView.animateWithDuration(NSTimeInterval((1 - progress) / 1.5), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.setMenuOffset(self.kMenuWidth)
                    self.coverView.alpha = self.coverViewAlpha
                    println(self.coverView.alpha)
                }, completion: nil)
            } else {
                UIView.animateWithDuration(NSTimeInterval(progress / 3), delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.setMenuOffset(0)
                    self.coverView.hidden = true
                }, completion: { (finished) -> Void in
                })
            }
        }
    }
    
    private func setMenuOffset(offset: CGFloat) {
        self.sideMenu.x = offset - kMenuWidth
        self.sideMenu.setOffsetProgress(offset / kMenuWidth)
    }
}
