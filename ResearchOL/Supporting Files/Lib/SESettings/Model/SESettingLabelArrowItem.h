//
//  SELabelArrowItem.h
//  ResearchOL
//
//  Created by Joshua on 15/5/16.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "SESettingItem.h"

@interface SESettingLabelArrowItem : SESettingItem

@property (assign, nonatomic) Class destVcClass;
@property (copy, nonatomic) NSString *text;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title text:(NSString *)text destVcClass:(Class)destVcClass;

@end
