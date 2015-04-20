//
//  ROLStringTool.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/20.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLStringTool: NSObject {
    
    class func getRectWithStr(string: String, width: CGFloat, attributes: Dictionary<NSObject, AnyObject>) -> CGRect {
        var str: NSString = string
        var size = CGSize(width: width, height: CGFloat.max)
        return str.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesFontLeading, attributes: attributes, context: nil)
    }
}
