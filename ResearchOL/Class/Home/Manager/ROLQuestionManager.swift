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
    var answers: [Int: ROLAnswer] = Dictionary()
    var answerDict: [String: [Int: ROLAnswer]] = Dictionary()
    
    
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
    func getWatchListQuestionaresForCurrentUser(success: (questionares: [ROLQuestionare]) -> Void, failure: () -> Void) {
        if (ROLUserInfoManager.sharedManager.currentUser != nil) {
            var list = ROLUserInfoManager.sharedManager.getWatchListForCurrentUser()
            var array: [ROLQuestionare] = []
            var count = 0
            for i in list {
                questionaresRef.queryOrderedByKey().queryEqualToValue(i).observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) -> Void in
                    var questionare = ROLQuestionare()
                    questionare.uuid = snapshot.key as String
                    questionare.title = snapshot.value["title"] as! String
                    questionare.desc = snapshot.value["description"] as! String
                    questionare.fireDate = snapshot.value["fireDate"] as! String
                    questionare.endDate = snapshot.value["endDate"] as! String
                    questionare.point = snapshot.value["point"] as! Int
                    questionare.participant = snapshot.value["participant"] as! Int
                    questionare.questionCount = snapshot.value["questionCount"] as! Int
                    
                    array.append(questionare)
                    count = count + 1
                    
                    if count == list.count {
                        success(questionares: array)
                    }
                })
            }
            if count == 0 {
                failure()
            }
        }
    }
    
    func getAnsweredQuestionaresForCurrentUser(success: (questionares: [ROLQuestionare]) -> Void, failure: () -> Void) {
        if (ROLUserInfoManager.sharedManager.currentUser != nil) {
            var list = ROLUserInfoManager.sharedManager.getAnsweredQuestionaresForCurrentUser()
            var array: [ROLQuestionare] = []
            var count = 0
            for i in list {
                questionaresRef.queryOrderedByKey().queryEqualToValue(i).observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) -> Void in
                    var questionare = ROLQuestionare()
                    questionare.uuid = snapshot.key as String
                    questionare.title = snapshot.value["title"] as! String
                    questionare.desc = snapshot.value["description"] as! String
                    questionare.fireDate = snapshot.value["fireDate"] as! String
                    questionare.endDate = snapshot.value["endDate"] as! String
                    questionare.point = snapshot.value["point"] as! Int
                    questionare.participant = snapshot.value["participant"] as! Int
                    questionare.questionCount = snapshot.value["questionCount"] as! Int
                    
                    array.append(questionare)
                    count = count + 1
                    
                    if count == list.count {
                        success(questionares: array)
                    }
                })
            }
            
            if count == 0 {
                failure()
            }
        }
    }
    
    func getQuestionares(amount: UInt, success: () -> Void) {
        var count: UInt = 0
        var flag: Bool = false
        self.questionares = []
        
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
            
            self.questionares.append(questionare)
            count = count + 1
            if count == amount {
                success()
            }
            
            
//            self.getQuestions(questionare.questionCount, questionare: questionare, success: {
//                
//                count = count + 1
//                self.questionares.append(questionare)
//                
//                if count == amount {
//                    success()
//                }
//            })
        })
    }
    
    func getMoreQuestionaresWithID(questionID: String, amount: UInt, success: () -> Void, failure: () -> Void) {
        var count: UInt = 0
        var flag: Bool = false
        questionaresRef.queryOrderedByKey().queryStartingAtValue(questionID).observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) -> Void in
            var questionare = ROLQuestionare()
            questionare.uuid = snapshot.key as String
            questionare.title = snapshot.value["title"] as! String
            questionare.desc = snapshot.value["description"] as! String
            questionare.fireDate = snapshot.value["fireDate"] as! String
            questionare.endDate = snapshot.value["endDate"] as! String
            questionare.point = snapshot.value["point"] as! Int
            questionare.participant = snapshot.value["participant"] as! Int
            questionare.questionCount = snapshot.value["questionCount"] as! Int
            
            if questionare.uuid != questionID {
                self.questionares.append(questionare)
            }
            
            count = count + 1
            if count == amount {
                success()
            }
            
            if questionare.uuid == questionID && count == 1 {
                failure()
            }
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
    
    func sortedAnswer() -> NSArray {
        var array = NSMutableArray()
        var index = 0
        while (self.answers.count > 0) {
            for i in self.answers {
                if i.0 == index {
                    array.addObject(i.1)
                    self.answers.removeValueForKey(i.0)
                }
            }
            index = index + 1
        }
        return array.copy() as! NSArray
    }
    
    func setAnswerSheetToServer(user: AVUser, questionareID: String, success: () -> Void) {
        let answersRef = questionaresRef.childByAppendingPath(questionareID).childByAppendingPath("answers")
        let answerRef = answersRef.childByAutoId()
        var dictionary: NSMutableDictionary = NSMutableDictionary()
        var array: NSMutableArray = NSMutableArray()
        var answers: NSArray = self.sortedAnswer()
        for (var x = 0; x < answers.count; x++) {
            var temp: ROLAnswer = answers[x] as! ROLAnswer
            var ans: NSMutableDictionary = NSMutableDictionary()
            if temp.type == 1 {
                ans = ["type": temp.type, "choice": temp.choice]
            } else if temp.type == 2 {
                ans = ["type": temp.type, "choices": temp.choices]
            } else if temp.type == 3 {
                ans = ["type": temp.type, "text": temp.text]
            }
            array.addObject(ans)
        }
        dictionary.setValue(array, forKey: "answer")
        if user.username == "anonymous" {
            dictionary.setValue(user.username, forKey: "author")
        } else {
            dictionary.setValue(user.objectId, forKey: "author")
        }
        answerRef.setValue(dictionary, withCompletionBlock: { (error:NSError?, ref:Firebase!) -> Void in
            success()
            self.questionaresRef.queryOrderedByKey().queryStartingAtValue(questionareID).observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) -> Void in
                var questionare = ROLQuestionare()
                questionare.point = snapshot.value["point"] as! Int
                if questionareID == snapshot.key as String {
                    ROLUserInfoManager.sharedManager.addPointsForCurrentUser(questionare.point, success: { () -> Void in
                        
                        }, failure: { () -> Void in
                            
                    })
                }
            })
        })
    }
    
    func setAnswer(answer: ROLAnswer, index: Int) {
        self.answers[index] = answer
        for i in self.answers {
//            println("type:" + "\(i.1.type)")
//            println("index: " + "\(i.0)" + " " + "choice: " + "\(i.1.choice)\n") // for single choice
//            println("index: " + "\(i.0)" + " " + "choices: " + "\(i.1.choices)\n")
        }
    }
    
    func getAnswerWithIndex(index: Int) -> ROLAnswer? {
        if self.answers[index] == nil {
            return nil
        } else {
            return self.answers[index]!
        }
    }
    
    func resetAnswers() {
        self.answers.removeAll(keepCapacity: true)
    }
    
    func saveAswerToMemoryWithQuestionareID(questionareID: String) {
        self.answerDict[questionareID] = self.answers
        println(self.answerDict)
    }
    
    func isQuestionareAnswered(questionID: String) -> Bool {
        for i in ROLUserInfoManager.sharedManager.getAnsweredQuestionaresForCurrentUser() {
            if i as! String == questionID {
                return true
            }
        }
        return false
    }
}
