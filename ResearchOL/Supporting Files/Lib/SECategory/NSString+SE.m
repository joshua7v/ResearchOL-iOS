//
//  NSString+SE.m
//  SEFramework
//
//  Created by Joshua on 15/1/22.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "NSString+SE.h"

@implementation NSString (SE)
+ (NSString *)moneyFormatStringWithString:(NSString *)srcString
{
    int money = [srcString intValue];
    int wan = money / 10000;
    int belowWan = money - wan * 10000;
    if (wan) {
        if (belowWan) {
            return [NSString stringWithFormat:@"%d万%d", wan, belowWan];
        } else {
            return [NSString stringWithFormat:@"%d万", wan];
        }
    } else {
        return [NSString stringWithFormat:@"%d", belowWan];
    }
    
}

#pragma mark 清空字符串中的空白字符
- (NSString *)trimString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark 是否空字符串
- (BOOL)isEmptyString
{
    return (self == nil || self.length == 0);
}

#pragma mark 返回沙盒中的文件路径
- (NSString *)documentsPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingString:self];
}

#pragma mark 写入系统偏好
- (void)saveToNSDefaultsWithKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
