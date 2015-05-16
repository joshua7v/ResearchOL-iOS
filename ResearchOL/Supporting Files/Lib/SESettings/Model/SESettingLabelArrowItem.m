//
//  SELabelArrowItem.m
//  ResearchOL
//
//  Created by Joshua on 15/5/16.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "SESettingLabelArrowItem.h"

@implementation SESettingLabelArrowItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title text:(NSString *)text destVcClass:(Class)destVcClass
{
    SESettingLabelArrowItem *item = [self itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    item.text = text;
    return item;
}

@end
