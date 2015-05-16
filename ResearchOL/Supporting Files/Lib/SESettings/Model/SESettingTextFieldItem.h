//
//  SESettingTextFieldItem.h
//  ResearchOL
//
//  Created by Joshua on 15/5/16.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "SESettingItem.h"

@interface SESettingTextFieldItem : SESettingItem
@property (copy, nonatomic) NSString *placeholder;

+ (instancetype)itemWithPlaceholder:(NSString *)placeholder;
@end
