//
//  NSDate+SE.h
//  SEFramework
//
//  Created by Joshua on 15/1/22.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SE)
- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isThisYear;
- (NSDate *)dateWithYMD;
- (NSDateComponents *)deltaWithNow;
@end
