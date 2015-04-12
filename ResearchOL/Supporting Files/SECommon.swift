//
//  SECommon.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/12.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import Foundation

func isIOS7() -> Bool {
    return (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 7.0
}
func isIOS8() -> Bool {
    return (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0
}
func SEColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}
