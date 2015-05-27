//
//  SESettingTextFieldItem.m
//  ResearchOL
//
//  Created by Joshua on 15/5/16.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "SESettingTextFieldItem.h"
#import <UIKit/UIKit.h>

@implementation SESettingTextFieldItem

+ (instancetype)itemWithPlaceholder:(NSString *)placeholder
{
    SESettingTextFieldItem *item = [self itemWithIcon:nil title:nil];
    item.textField = [[UITextField alloc] init];
    item.placeholder = placeholder;
    return item;
}
@end
