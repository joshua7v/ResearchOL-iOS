//
//  UIButton+SE.h
//  SEFramework
//
//  Created by Joshua on 15/1/22.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SE)

/**
 *  同时设置普通状态与高亮状态图片
 *
 *  @param image 普通状态图片
 *  @param image 高亮状态图片
 */
- (void)setBackgroundImage:(NSString *)image HighlightedBackgroundImage:(NSString *)selectedImage;

/**
 *  同时设置普通状态与高亮状态图片
 *
 *  @param image 普通状态图片
 *  @param image 高亮状态图片
 */
- (void)setResizedBackgroundImage:(NSString *)image HighlightedBackgroundImage:(NSString *)selectedImage;

@end
