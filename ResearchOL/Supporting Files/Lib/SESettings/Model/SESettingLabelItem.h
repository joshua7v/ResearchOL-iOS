//
//  SESettingLabelItem.h
//  SEFramework
//
//  Created by Joshua on 15/1/22.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SESettingItem.h"

@interface SESettingLabelItem : SESettingItem
@property (copy, nonatomic) NSString *text;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title text:(NSString *)text;
+ (instancetype)itemWithTitle:(NSString *)title text:(NSString *)text;
@end
