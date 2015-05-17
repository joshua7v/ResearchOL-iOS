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
    var currentUser: AVUser {
        get {
            return AVUser.currentUser()
        }
    }
    
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
        
//        NSData *imageData = UIImagePNGRepresentation(image);
//        AVFile *imageFile = [AVFile fileWithName:@"image.png" data:imageData];
//        [imageFile save];
//        
//        AVObject *userPhoto = [AVObject objectWithClassName:@"UserPhoto"];
//        [userPhoto setObject:@"My trip to Hawaii!" forKey:@"imageName"];
//        [userPhoto setObject:imageFile             forKey:@"imageFile"];
//        [userPhoto save];
        
        var user = AVUser()
        user.username = username
        user.email = email
        user.password = password
        
        var avatarData = UIImageJPEGRepresentation(UIImage(named: "SESideMenu.bundle/avatar_default"), 0.5)
        var avatarFile: AnyObject! = AVFile.fileWithName("\(ROLUserKeys.kUserAvatarKey).jpeg", data: avatarData)
        avatarFile.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                var query = AVQuery(className: ROLUserKeys.kUserWatchListKey)
                var watchList = query.getFirstObject()
                if watchList == nil {
                    var watch = AVObject(className: ROLUserKeys.kUserWatchListKey)
                    watchList = watch
                }
                
                user.setObject(0, forKey: ROLUserKeys.kUserPointsKey)
                user.setObject(0, forKey: ROLUserKeys.kUserAnsweredQuestionaresNumberKey)
                user.setObject(avatarFile, forKey: ROLUserKeys.kUserAvatarKey)
                
                watchList.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                    user.setObject(watchList, forKey: ROLUserKeys.kUserWatchListKey)
                    user.saveInBackground()
                })
            }
        }
        
        user.signUpInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                success()
            } else {
                failure(code: error.code)
            }
        }
    }
    
    func resignUser() {
        self.isUserLogin = false
        NSNotificationCenter.defaultCenter().postNotificationName(ROLNotifications.userLogoutNotification, object: nil, userInfo: nil)
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
    
    func saveAvatarForCurrentUser(imageData: NSData) {
        var user = AVUser.currentUser()
        var file: AnyObject! = AVFile.fileWithName("\(ROLUserKeys.kUserAvatarKey).jpeg", data: imageData)
        user.setObject(file, forKey: ROLUserKeys.kUserAvatarKey)
        user.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                NSNotificationCenter.defaultCenter().postNotificationName("avatarDidChangedNotification", object: UIImage(data: imageData), userInfo: nil)
            }
        }
    }
    
    func getThumbnailAvatarForCurrentUser(success: (image: UIImage) -> Void, failure: (error: NSError) -> Void) {
        var user = AVUser.currentUser()
        var file = user.objectForKey(ROLUserKeys.kUserAvatarKey) as! AVFile
        file.getThumbnail(true, width: 180, height: 180) { (image, error) -> Void in
            if (image != nil) {
                success(image: image)
            } else {
                failure(error: error)
            }
        }
    }
    
    func getPointsForCurrentUser() -> Int {
        return self.currentUser.objectForKey(ROLUserKeys.kUserPointsKey) as! Int
    }
    
    func getAnsweredQuestionaresNumberForCurrentUser() -> Int {
        return self.currentUser.objectForKey(ROLUserKeys.kUserAnsweredQuestionaresNumberKey) as! Int
    }
    
    func watchQuestionareForCurrentUser(questionareId: String,success: () -> Void, failure: () -> Void) {
        var watch: AVObject = self.currentUser.objectForKey(ROLUserKeys.kUserWatchListKey) as! AVObject
//        watch.addUniqueObject([], forKey: self.currentUser.objectId)
        watch.addUniqueObject(questionareId, forKey: self.currentUser.objectId)
        watch.saveInBackgroundWithBlock { (finished, error) -> Void in
            if finished {
                success()
            } else {
                failure()
            }
        }
    }
    
    func unWatchQuestionareForCurrentUser(questionareId: String,success: () -> Void, failure: () -> Void) {
        var watch: AVObject = self.currentUser.objectForKey(ROLUserKeys.kUserWatchListKey) as! AVObject
        watch.removeObject(questionareId, forKey: self.currentUser.objectId)
        watch.saveInBackgroundWithBlock { (finished, error) -> Void in
            if finished {
                success()
            } else {
                failure()
            }
        }
    }
}
