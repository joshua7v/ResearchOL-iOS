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
        
        var avatarData = UIImagePNGRepresentation(UIImage(named: "SESideMenu.bundle/avatar_default"))
        var avatarFile: AnyObject! = AVFile.fileWithName("\(ROLUserKeys.kUserAvatarKey).png", data: avatarData)
        avatarFile.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                user.setObject(avatarFile, forKey: ROLUserKeys.kUserAvatarKey)
                user.saveInBackground()
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
}
