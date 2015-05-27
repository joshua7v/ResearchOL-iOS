//
//  SESettingCheckboxItem.h
//  ResearchOL
//
//  Created by Joshua on 15/5/22.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "SESettingItem.h"
@class M13Checkbox;
@interface SESettingCheckboxItem : SESettingItem
@property (assign, nonatomic, getter=isChecked) BOOL checked;
@property (nonatomic, strong) M13Checkbox *checkbox;

+ (instancetype)itemWithTitle:(NSString *)title CheckState:(BOOL)checkState;
@end
