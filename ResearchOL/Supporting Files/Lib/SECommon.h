//
//  SECommon.h
//  BadmintonDating
//
//  Created by Joshua on 15/3/13.
//  Copyright (c) 2015年 DiamondStudio. All rights reserved.
//

#ifndef BadmintonDating_SECommon_h
#define BadmintonDating_SECommon_h


#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
//#import "UIImage+SE.h"NSString+Seraph.h
#import "SECategory.h"

// 判断是否为iOS7
#define isiOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
// 判断是否为iOS8
#define isiOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

// 获得RGB颜色
#define SEColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define SERandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

// 自定义Log
#ifdef DEBUG
#define SELog(...) NSLog(@"func: %s \n line: %d - msg: %@ \n\n", __func__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define SELog(...)
#endif

#endif


#endif
