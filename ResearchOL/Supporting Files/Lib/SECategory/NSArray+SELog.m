//
//  NSArray+SELog.m
//  SEFramework
//
//  Created by Joshua on 15/1/23.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "NSArray+SELog.h"

@implementation NSArray (SELog)
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithFormat:@"%d (\n", (int)self.count];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@", obj];
        
        if (idx < self.count - 1) {
            [strM appendString:@",\n"];
        }
    }];
    [strM appendString:@"\n)"];
    
    return strM;
}

@end
