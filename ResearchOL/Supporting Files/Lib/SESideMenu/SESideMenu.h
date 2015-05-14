//
//  SESideMenu.h
//  DEMOSideMenu
//
//  Created by Joshua on 15/5/13.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SESideMenu : UIView
@property (nonatomic, copy) void (^didSelectedIndexBlock)(NSInteger index);
@property (nonatomic, copy) void (^avatarBtnDidClickedBlock)();
@property (nonatomic, strong) UIImage *blurredImage;

+ (SESideMenu *)sideMenuWithSize:(CGSize)size;
- (instancetype)initWithSize:(CGSize)size;
- (void)setOffsetProgress:(CGFloat)progress;
@end
