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
    func registerUser(username: String, password: String, email: String, success: () -> Void, failure: (code: Int) -> Void) {
//        firebaseRef.createUser(email, password: password) { (error, result) -> Void in
//            if error != nil {
//                println(error)
//                failure()
//            } else {
//                self.isUserLogin = true
//                success()
//                println("register success")
//            }
//        }
        
        var user = AVUser()
        user.username = username
        user.email = email
        user.password = password
        user.signUpInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                success()
            } else {
                failure(code: error.code)
            }
        }
    }
    
    func authUser(username: String, password: String, success: () -> Void, failure: () -> Void) {
//        firebaseRef.authUser(email, password: password) { (error, result) -> Void in
//            if error != nil {
//                println(error)
//                failure()
//            } else {
//                self.isUserLogin = true
//                success()
//                println("login success")
//            }
//        }
        
        AVUser.logInWithUsernameInBackground(username, password: password) { (user, error) -> Void in
            if user != nil {
                self.isUserLogin = true
                success()
            } else {
                failure()
            }
        }
    }
}
