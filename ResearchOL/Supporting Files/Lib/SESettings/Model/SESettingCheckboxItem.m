//
//  SESettingCheckboxItem.m
//  ResearchOL
//
//  Created by Joshua on 15/5/22.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "SESettingCheckboxItem.h"
#import <M13Checkbox/M13Checkbox.h>

@implementation SESettingCheckboxItem
+ (instancetype)itemWithTitle:(NSString *)title CheckState:(BOOL)checkState
{
    SESettingCheckboxItem *item = [self itemWithIcon:nil title:title];
    item.checked = checkState;
    M13Checkbox *checkbox = [[M13Checkbox alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    checkbox.radius = 15;
    checkbox.checkColor = [UIColor blackColor];
    checkbox.strokeColor = [UIColor blackColor];
    item.checkbox = checkbox;
    return item;
}
@end
