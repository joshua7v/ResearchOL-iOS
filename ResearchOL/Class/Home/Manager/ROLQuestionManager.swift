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
    let questionaresRef = Firebase(url: "https://researchol.firebaseio.com/questionares")
    var questionares: [ROLQuestionare] = []
    
    
//        let questionaresRef = fireBaseRef.childByAppendingPath("questionares")
//        let questionare1 = ["title": "标题", "description": "描述"]
//        let questionare1Ref = questionaresRef.childByAutoId()
//        questionare1Ref.setValue(questionare1)
//    
//        let questionare2 = ["title": "alanisawesome", "description": "The Turing Machine"]
//        let questionare2Ref = questionaresRef.childByAutoId()
//        questionare2Ref.setValue(post2)
   
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
    func getQuestionares(amount: UInt, success: () -> Void) {
        var count: UInt = 1
        var flag: Bool = false
        
        questionaresRef.queryOrderedByKey().queryLimitedToFirst(amount).observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) -> Void in
            var questionare = ROLQuestionare()
            questionare.uuid = snapshot.key as String
            questionare.title = snapshot.value["title"] as! String
            questionare.desc = snapshot.value["description"] as! String
            questionare.fireDate = snapshot.value["fireDate"] as! String
            questionare.endDate = snapshot.value["endDate"] as! String
            questionare.point = snapshot.value["point"] as! Int
            questionare.participant = snapshot.value["participant"] as! Int
            questionare.questionCount = snapshot.value["questionCount"] as! Int
            
            
            self.getQuestions(questionare.questionCount, questionare: questionare, success: {
                
                count = count + 1
                self.questionares.append(questionare)
                
                if count == amount {
                    success()
                }
            })
        })
    }
    
    func getQuestions(amount: Int, questionare: ROLQuestionare, success: () -> Void) {
        var count = 0
        let questionsRef = questionaresRef.childByAppendingPath(questionare.uuid).childByAppendingPath("questions")
        questionsRef.queryOrderedByKey().observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) -> Void in
            count = count + 1
            var question = ROLQuestion()
            question.title = snapshot.value["title"] as! String
            question.type = snapshot.value["type"] as! Int
            if question.type != 3 {
                question.choice = snapshot.value["choice"] as! [String]
            }
            questionare.questions.append(question)
            if count == amount {
                success()
            }
        })
    }
}
