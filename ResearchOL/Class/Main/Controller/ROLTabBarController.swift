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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configueGestrues()
        self.configueViews()
//        self.setBlurredScreenShoot()
    }
    
    private func configueViews() {
        self.coverView.backgroundColor = UIColor(hexString: "000000", alpha: 0.5)
        self.coverView.hidden          = true
        self.view.addSubview(self.coverView)

        self.sideMenu.frame            = CGRect(x: -kMenuWidth, y: 0, width: kMenuWidth, height: UIScreen.height())
        self.view.addSubview(self.sideMenu)
    }
    
    private func configueGestrues() {
        var edgePanRecognizer      = UIScreenEdgePanGestureRecognizer(target: self, action: "handleEdgePanRecognizer:")
        edgePanRecognizer.edges    = UIRectEdge.Left
        edgePanRecognizer.delegate = self
        self.view.addGestureRecognizer(edgePanRecognizer)

        var coverTapRecognizer      = UITapGestureRecognizer(target: self, action: "handleCoverTapRecognizer:")
        coverTapRecognizer.delegate = self
        self.coverView.addGestureRecognizer(coverTapRecognizer)
    }
    
    private func setBlurredScreenShoot() {
        var screenShot = self.view.screenshot()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            var blurColor = UIColor(white: 0.970, alpha: 0.5)
            screenShot = screenShot.applyBlurWithRadius(12.0, tintColor: blurColor, saturationDeltaFactor: 1, maskImage: nil)
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.sideMenu.blurredImage = screenShot
            })
        })
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
        
        if recognizer.state == UIGestureRecognizerState.Began {
            self.coverView.hidden = false
            self.coverView.alpha = 0.5 * progress
        } else if recognizer.state == UIGestureRecognizerState.Changed {
            self.setMenuOffset(kMenuWidth * progress)
            self.coverView.alpha = 0.5 * progress
        } else if recognizer.state == UIGestureRecognizerState.Ended || recognizer.state == UIGestureRecognizerState.Cancelled {
            var velocity = recognizer.velocityInView(self.view).x
            if velocity > 20 || progress > 0.5 {
                UIView.animateWithDuration(NSTimeInterval((1 - progress) / 1.5), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.setMenuOffset(self.kMenuWidth)
                }, completion: nil)
            } else {
                UIView.animateWithDuration(NSTimeInterval(progress / 3), delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.setMenuOffset(0)
                    self.coverView.alpha = 0.5
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
