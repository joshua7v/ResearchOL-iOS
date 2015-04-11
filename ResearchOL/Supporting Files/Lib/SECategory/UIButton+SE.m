//
//  UIButton+SE.m
//  SEFramework
//
//  Created by Joshua on 15/1/22.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "UIButton+SE.h"
#import "UIImage+SE.h"

@implementation UIButton (SE)

- (void)setBackgroundImage:(NSString *)image HighlightedBackgroundImage:(NSString *)selectedImage
{
    [self setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateHighlighted];
}

- (void)setResizedBackgroundImage:(NSString *)image HighlightedBackgroundImage:(NSString *)selectedImage
{
    [self setBackgroundImage:[UIImage resizedImageWithName:image] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage resizedImageWithName:selectedImage] forState:UIControlStateHighlighted];
}

@end
