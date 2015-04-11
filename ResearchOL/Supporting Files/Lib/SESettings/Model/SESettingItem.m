//
//  SESettingItem.m
//  SEFramework
//
//  Created by Joshua on 15/1/22.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "SESettingItem.h"

@implementation SESettingItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    SESettingItem *item = [self item];
    item.icon = icon;
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}

+ (instancetype)item
{
    return [[self alloc] init];
}
@end

