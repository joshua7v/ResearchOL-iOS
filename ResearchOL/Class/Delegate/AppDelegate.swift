//
//  AppDelegate.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/11.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UITabBarController
        self.window?.makeKeyAndVisible()
        
        
//        FXKeychain.defaultKeychain().removeObjectForKey(ROLUserKeys.kUserTokenKey)
//        FXKeychain.defaultKeychain().removeObjectForKey(ROLUserKeys.kUserIdKey)
//        FXKeychain.defaultKeychain().removeObjectForKey([ROLUserKeys.kUserTokenKey])
//        FXKeychain.defaultKeychain().removeObjectForKey([ROLUserKeys.kUserIdKey])
        println(FXKeychain.defaultKeychain()[ROLUserKeys.kUserTokenKey])
        let token = FXKeychain.defaultKeychain()[ROLUserKeys.kUserTokenKey] as? String
        if token != nil && token! == ROLUserKeys.kUserTokenSecretKey.md5String {
            ROLUserInfoManager.sharedManager.isUserLogin = true
            NSNotificationCenter.defaultCenter().postNotificationName(ROLNotifications.userLoginNotification, object: nil)
        }
        
        AVOSCloud.setApplicationId("rvff27zmaugnw1yhdg32nvz5itth29fa1bjff27iwyp5isiv", clientKey: "z10xoqcsvz9u9wkkfxkcuaobr4jl1kxswpx7aylb91rf1rd0")

        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

