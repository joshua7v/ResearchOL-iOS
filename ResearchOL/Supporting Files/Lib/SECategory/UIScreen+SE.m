//
//  UIScreen+SE.m
//  DEMOSideMenu
//
//  Created by Joshua on 15/5/14.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "UIScreen+SE.h"

@implementation UIScreen (SE)
+ (CGFloat)height
{
    return [UIScreen mainScreen].bounds.size.height;
}
+ (CGFloat)width
{
    return [UIScreen mainScreen].bounds.size.width;
}
@end
