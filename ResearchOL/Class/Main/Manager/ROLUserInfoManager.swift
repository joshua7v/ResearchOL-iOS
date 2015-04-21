//
//  ROLUserInfoManager.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/20.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLUserInfoManager: NSObject {
    
    let firebaseRef = Firebase(url: "https://researchol.firebaseio.com")
    var isUserLogin: Bool = false
    
    class var sharedManager: ROLUserInfoManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: ROLUserInfoManager? = nil
        }
        dispatch_once(&Static.onceToken, { () -> Void in
            Static.instance = ROLUserInfoManager()
        })
        return Static.instance!
    }
    
    // MARK: - public    
    func registerUser(email: String, password: String, success: () -> Void, failure: () -> Void) {
        firebaseRef.createUser(email, password: password) { (error, result) -> Void in
            if error != nil {
                println(error)
                failure()
            } else {
                self.isUserLogin = true
                success()
                println("register success")
            }
        }
    }
    
    func authUser(email: String, password: String, success: () -> Void, failure: () -> Void) {
        firebaseRef.authUser(email, password: password) { (error, result) -> Void in
            if error != nil {
                println(error)
                failure()
            } else {
                self.isUserLogin = true
                success()
                println("login success")
            }
        }
    }
}
