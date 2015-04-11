//
//  UIImage+SE.m
//  SEFramework
//
//  Created by Joshua on 15/1/22.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "UIImage+SE.h"

@implementation UIImage (SE)

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name top:0.5 left:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name top:(float)top left:(float)left
{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}
@end
