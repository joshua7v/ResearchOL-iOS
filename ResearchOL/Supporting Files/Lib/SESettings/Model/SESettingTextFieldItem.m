//
//  SESettingTextFieldItem.m
//  ResearchOL
//
//  Created by Joshua on 15/5/16.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "SESettingTextFieldItem.h"

@implementation SESettingTextFieldItem

+ (instancetype)itemWithPlaceholder:(NSString *)placeholder
{
    SESettingTextFieldItem *item = [self itemWithIcon:nil title:nil];
    item.placeholder = placeholder;
    return item;
}
@end
