//
//  SESideMenuSection.h
//  DEMOSideMenu
//
//  Created by Joshua on 15/5/14.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SESideMenuSection : UIView

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) void (^didSelectedIndexBlock)(NSInteger index);
@property (nonatomic, copy) void (^avatarBtnDidClickedBlock)();

- (void)setDidSelectedIndexBlock:(void (^)(NSInteger index))didSelectedIndexBlock;

@end
