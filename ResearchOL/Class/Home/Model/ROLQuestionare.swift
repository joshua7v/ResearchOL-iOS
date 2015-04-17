//
//  ROLQuestionare.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/16.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLQuestionare: NSObject {
    var uuid: String = ""
    var title: String = ""
    var fireDate: String = "" {
        didSet {
            var fmt = NSDateFormatter()
            fmt.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy";
            fmt.locale = NSLocale(localeIdentifier: "en_US")
            var date: NSDate! = fmt.dateFromString(fireDate)
            if (date.isToday()) {
                if (date.deltaWithNow().hour >= 1) {
                    fireDate = String(format: "%d小时前", date.deltaWithNow().hour)
                } else if (date.deltaWithNow().minute >= 1) {
                    fireDate = String(format: "%d分钟前", date.deltaWithNow().minute)
                } else {
                    fireDate = "刚刚"
                }
            } else if (date.isYesterday()) {
                fmt.dateFormat = "昨天"
                fireDate = fmt.stringFromDate(date)
            } else if (date.isThisYear()) {
                fmt.dateFormat = "MM - dd"
                fireDate = fmt.stringFromDate(date)
            } else {
                fmt.dateFormat = "yyyy - MM"
                fireDate = fmt.stringFromDate(date)
            }
        }
    }
    var endDate: String = ""
    var desc: String = ""
    var questionCount: Int = 0
    var point: Int = 0
    var participants: Int = 0
    
    override init() {
        super.init()
    }
}
