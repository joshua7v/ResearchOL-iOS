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
    var currentUser: AVUser? {
        get {
            if AVUser.currentUser() == nil {
                var userId = FXKeychain.defaultKeychain()[ROLUserKeys.kUserIdKey] as? String
                if userId == nil { return nil }
                var query = AVQuery(className: "user")
                var user = query.getObjectWithId(FXKeychain.defaultKeychain()[ROLUserKeys.kUserIdKey] as! String) as? AVUser
                println(user)
                return user
            }
            
            if FXKeychain.defaultKeychain()[ROLUserKeys.kUserIdKey] as? String != AVUser.currentUser().objectId {
                var userId = FXKeychain.defaultKeychain()[ROLUserKeys.kUserIdKey] as? String
                if userId == nil { return nil }
                var query = AVQuery(className: "user")
                var user = query.getObjectWithId(FXKeychain.defaultKeychain()[ROLUserKeys.kUserIdKey] as! String) as? AVUser
                println(user)
                return user
            }
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
                
                var queryAnsweredQuestionares = AVQuery(className: ROLUserKeys.kUserAnsweredQuestionaresKey)
                var answeredQuestionares = queryAnsweredQuestionares.getFirstObject()
                if answeredQuestionares == nil {
                    var ans = AVObject(className: ROLUserKeys.kUserAnsweredQuestionaresKey)
                    answeredQuestionares = ans
                }
                
                user.setObject(0, forKey: ROLUserKeys.kUserPointsKey)
                user.setObject(0, forKey: ROLUserKeys.kUserAnsweredQuestionaresNumberKey)
                user.setObject(avatarFile, forKey: ROLUserKeys.kUserAvatarKey)
                
                watchList.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                    answeredQuestionares.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                        user.setObject(watchList, forKey: ROLUserKeys.kUserWatchListKey)
                        user.setObject(answeredQuestionares, forKey: ROLUserKeys.kUserAnsweredQuestionaresKey)
                        user.saveInBackground()
                        //                    self.authUser(user.username, password: user.password, success: { () -> Void in
                        //
                        //                    }, failure: { () -> Void in
                        //                        
                        //                    })
                    })
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
        FXKeychain.defaultKeychain().removeObjectForKey(ROLUserKeys.kUserTokenKey)
        FXKeychain.defaultKeychain().removeObjectForKey(ROLUserKeys.kUserIdKey)
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
                FXKeychain.defaultKeychain().setObject(ROLUserKeys.kUserTokenSecretKey.md5String, forKey: ROLUserKeys.kUserTokenKey)
                FXKeychain.defaultKeychain().setObject(user.objectId, forKey: ROLUserKeys.kUserIdKey)
                NSNotificationCenter.defaultCenter().postNotificationName(ROLNotifications.userLoginNotification, object: nil)
                success()
            } else {
                failure()
            }
        }
    }
    
    func saveAvatarForCurrentUser(imageData: NSData) {
        if self.currentUser == nil {
            return
        }
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
        if self.currentUser == nil {
            success(image: UIImage(named: "SESideMenu.bundle/avatar_default")!)
            return
        }
        var user = self.currentUser
        var file = user!.objectForKey(ROLUserKeys.kUserAvatarKey) as! AVFile
        file.getThumbnail(true, width: 180, height: 180) { (image, error) -> Void in
            if (image != nil) {
                success(image: image)
            } else {
                failure(error: error)
            }
        }
    }
    
    func getPointsForCurrentUser() -> Int {
        if self.currentUser == nil {
            return 0
        }
        return self.currentUser!.objectForKey(ROLUserKeys.kUserPointsKey) as! Int
    }
    
    func getAnsweredQuestionaresNumberForCurrentUser() -> Int {
        if self.currentUser == nil {
            return 0
        }
        return self.currentUser!.objectForKey(ROLUserKeys.kUserAnsweredQuestionaresNumberKey) as! Int
    }
    
    func watchQuestionareForCurrentUser(questionareId: String,success: () -> Void, failure: () -> Void) {
        if self.currentUser == nil { return }
        var watch: AVObject = self.currentUser!.objectForKey(ROLUserKeys.kUserWatchListKey) as! AVObject
//        watch.addUniqueObject([], forKey: self.currentUser.objectId)
        watch.addUniqueObject(questionareId, forKey: self.currentUser!.objectId)
        watch.saveInBackgroundWithBlock { (finished, error) -> Void in
            if finished {
                success()
            } else {
                failure()
            }
        }
    }
    
    func unWatchQuestionareForCurrentUser(questionareId: String,success: () -> Void, failure: () -> Void) {
        if self.currentUser == nil { return }
        var watch: AVObject = self.currentUser!.objectForKey(ROLUserKeys.kUserWatchListKey) as! AVObject
        watch.removeObject(questionareId, forKey: self.currentUser!.objectId)
        watch.saveInBackgroundWithBlock { (finished, error) -> Void in
            if finished {
                success()
            } else {
                failure()
            }
        }
    }
    
    func getWatchListForCurrentUser() -> [String] {
        if !self.isUserLogin { return [] }
        if self.currentUser == nil { return [] }
        var query = AVQuery(className: ROLUserKeys.kUserWatchListKey)
        var watchList = query.getFirstObject()
        var watchArray: AnyObject! = watchList.objectForKey(self.currentUser!.objectId)
        if watchArray == nil { return [] }
        return watchArray as! [String]
    }
    
    func saveAttributeForCurrentUser(title: String, value: String, success: (finished: Bool) -> Void, failure: (error: NSError) -> Void) {
        if !self.isUserLogin { return }
        if self.currentUser == nil { return }
        var user = self.currentUser!
        user.setObject(value, forKey: getAttributeNameWithTitle(title))
        println("value \(value), key \(getAttributeNameWithTitle(title))")
        user.saveInBackgroundWithBlock { (finished, error) -> Void in
            if finished {
                success(finished: finished)
            } else {
                failure(error: error)
            }
        }
    }
    
    func getAttributeForCurrentUser(attribute: String) -> String {
        if !self.isUserLogin { return "" }
        if self.currentUser == nil { return "" }
        var user = self.currentUser!
        var value: AnyObject! = user.objectForKey(attribute)
        if value == nil { return "" }
        return value as! String
    }
    
    func getAttributeNameWithTitle(title: String) -> String {
        let map = ["月收入": "monthlyIncome",
                    "性别": "gender",
                    "手机号": "mobilePhoneNumber",
                    "年龄": "age",
                    "爱好": "hobby",
                    "地区": "location",
                    "就业状态": "jobState",
                    "教育程度": "educationState",
                    "婚姻状况": "marriageState"]
        return map[title]!
    }
    
    func addPointsForCurrentUser(points: Int, success: () -> Void, failure: () -> Void) {
        if !self.isUserLogin { return }
        if self.currentUser == nil { return }
        var user = self.currentUser!
        var point = user.objectForKey(ROLUserKeys.kUserPointsKey) as! Int
        point = point + points
        user.setObject(point, forKey: ROLUserKeys.kUserPointsKey)
        user.saveInBackgroundWithBlock { (finished, error) -> Void in
            if finished {
                success()
                NSNotificationCenter.defaultCenter().postNotificationName(ROLNotifications.userPointsDidAddNotification, object: nil)
            } else {
                failure()
            }
        }
    }
    
    private func addAnsweredQuestionaresNumberCurrentUser(addNumber: Int, success: () -> Void, failure: () -> Void) {
        if !self.isUserLogin { return }
        if self.currentUser == nil { return }
        var user = self.currentUser!
        var answeredQuestionaresNumber = user.objectForKey(ROLUserKeys.kUserAnsweredQuestionaresNumberKey) as! Int
        answeredQuestionaresNumber = answeredQuestionaresNumber + addNumber
        user.setObject(answeredQuestionaresNumber, forKey: ROLUserKeys.kUserAnsweredQuestionaresNumberKey)
        user.saveInBackgroundWithBlock { (finished, error) -> Void in
            if finished {
                success()
                NSNotificationCenter.defaultCenter().postNotificationName(ROLNotifications.userAnsweredQuestionaresDidAddNotification, object: nil)
            } else {
                failure()
            }
        }
    }
    
    func setAnsweredQuestionareForCurrentUser(questionareId: String,success: () -> Void, failure: () -> Void) {
        if self.currentUser == nil { return }
        var answeredQuestionares: AVObject = self.currentUser!.objectForKey(ROLUserKeys.kUserAnsweredQuestionaresKey) as! AVObject
        answeredQuestionares.addUniqueObject(questionareId, forKey: self.currentUser!.objectId)
        answeredQuestionares.saveInBackgroundWithBlock { (finished, error) -> Void in
            if finished {
                self.addAnsweredQuestionaresNumberCurrentUser(1, success: { () -> Void in
                    success()
                }, failure: { () -> Void in
                    failure()
                })
            } else {
                failure()
            }
        }
    }
    
    func getAnsweredQuestionaresForCurrentUser() -> NSArray {
        if self.currentUser == nil { return [] }
        var answeredQuestionares: AVObject = self.currentUser!.objectForKey(ROLUserKeys.kUserAnsweredQuestionaresKey) as! AVObject
        var array = answeredQuestionares.objectForKey(self.currentUser!.objectId) as? NSArray
        if array != nil {
            return array!
        }
        return []
    }
}
