//
//  ROLQuestionManager.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/16.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLQuestionManager: NSObject {
    
    let firebaseRef = Firebase(url: "https://researchol.firebaseio.com")
    var questionares: [ROLQuestionare] = []
    
    
    //    let questionaresRef = fireBaseRef.childByAppendingPath("questionares")
    //    let questionare1 = ["title": "标题", "description": "描述"]
    //    let questionare1Ref = questionaresRef.childByAutoId()
    //    questionare1Ref.setValue(questionare1)
    //
    //    let questionare2 = ["title": "alanisawesome", "description": "The Turing Machine"]
    //    let questionare2Ref = questionaresRef.childByAutoId()
    //    questionare2Ref.setValue(post2)
   
    class var sharedManager: ROLQuestionManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: ROLQuestionManager? = nil
        }
        dispatch_once(&Static.onceToken, { () -> Void in
            Static.instance = ROLQuestionManager()
        })
        return Static.instance!
    }
    
    // MARK: - private
    
    // MARK: - public
    func getQuestionares(success: () -> Void) {
        let questionaresRef = firebaseRef.childByAppendingPath("questionares")
        let amount: UInt = 3
        var count: UInt = 0
        questionaresRef.queryLimitedToFirst(amount).observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) -> Void in
            count = count + 1
            var questionare = ROLQuestionare()
            questionare.title = snapshot.value["title"] as! String
            questionare.desc = snapshot.value["description"] as! String
            questionare.fireDate = snapshot.value["fireDate"] as! String
            questionare.endDate = snapshot.value["endDate"] as! String
            questionare.point = snapshot.value["point"] as! Int
            questionare.participants = snapshot.value["participants"] as! Int
            questionare.questionCount = snapshot.value["questionCount"] as! Int
            self.questionares.append(questionare)
            
            if count == amount {
                success()
            }
        })
    }
}