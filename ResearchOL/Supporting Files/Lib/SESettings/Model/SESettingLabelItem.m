//
//  SESettingLabelItem.m
//  SEFramework
//
//  Created by Joshua on 15/1/22.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "SESettingLabelItem.h"

@implementation SESettingLabelItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title text:(NSString *)text
{
    SESettingLabelItem *item = [self itemWithIcon:icon title:title];
    item.text = text;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title text:(NSString *)text
{
    return [self itemWithIcon:nil title:title text:(NSString *)text];
}

@end
