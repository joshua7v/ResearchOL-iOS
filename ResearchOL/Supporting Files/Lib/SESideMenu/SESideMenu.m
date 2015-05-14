//
//  SESideMenu.m
//  DEMOSideMenu
//
//  Created by Joshua on 15/5/13.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "SESideMenu.h"
#import "SESideMenuSection.h"
#import "SECategory.h"
#import "SESideMenuCommon.h"

@interface SESideMenu ()

@property (nonatomic, strong) UIView      *backgroundContainView;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIImageView *leftShadowImageView;
@property (nonatomic, strong) UIView      *leftShdowImageMaskView;
@property (nonatomic, strong) SESideMenuSection *sectionView;
@end

@implementation SESideMenu

+ (SESideMenu *)sideMenuWithSize:(CGSize)size
{
    return [[self alloc] initWithSize:size];
}

- (instancetype)initWithSize:(CGSize)size
{
    return [self initWithFrame:CGRectMake(-size.width, 0, size.width, size.height)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = NO;
        self.backgroundColor = [UIColor redColor];
        [self configureViews];
        [self configureShadowViews];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveThemeChangeNotification) name:kThemeDidChangeNotification object:nil];
        
    }
    return self;
}

- (void)configureViews {
    
    self.backgroundContainView               = [[UIView alloc] init];
    self.backgroundContainView.clipsToBounds = YES;
    [self addSubview:self.backgroundContainView];

    self.backgroundImageView                 = [[UIImageView alloc] init];
    [self.backgroundContainView addSubview:self.backgroundImageView];

    self.sectionView                         = [[SESideMenuSection alloc] init];
    [self addSubview:self.sectionView];
    
    // Handles
//    @weakify(self);
    __weak typeof(self) weakSelf = self;
    [self.sectionView setDidSelectedIndexBlock:^(NSInteger index) {
//        @strongify(self);
        
        if (weakSelf.didSelectedIndexBlock) {
            weakSelf.didSelectedIndexBlock(index);
        }
        
    }];
    
}

- (void)configureShadowViews {
    
    self.leftShdowImageMaskView               = [[UIView alloc] init];
    self.leftShdowImageMaskView.clipsToBounds = YES;
    [self addSubview:self.leftShdowImageMaskView];
    
    UIImage *shadowImage               = [UIImage imageNamed:@"SESideMenu.bundle/Navi_Shadow"];
    shadowImage = shadowImage.imageForCurrentTheme;
    
    self.leftShadowImageView           = [[UIImageView alloc] initWithImage:shadowImage];
    self.leftShadowImageView.transform = CGAffineTransformMakeRotation(M_PI);
    self.leftShadowImageView.alpha     = 0.0;
    [self.leftShdowImageMaskView addSubview:self.leftShadowImageView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
    
    self.backgroundContainView.frame  = (CGRect){0, 0, self.width, [UIScreen height]};
    self.backgroundImageView.frame    = (CGRect){[UIScreen width], 0, [UIScreen width], [UIScreen height]};
    
    self.leftShdowImageMaskView.frame = (CGRect){self.width, 0, 10, [UIScreen height]};
    self.leftShadowImageView.frame    = (CGRect){-5, 0, 10, [UIScreen height]};
    
    self.sectionView.frame  = (CGRect){0, 0, self.width, [UIScreen height]};
    
}

- (void)setOffsetProgress:(CGFloat)progress {
    
    progress = MIN(MAX(progress, 0.0), 1.0);
    
    self.backgroundImageView.x     = self.width - [UIScreen width]/2 * progress;
    
    self.leftShadowImageView.alpha = progress;
    self.leftShadowImageView.x     = -5 + progress * 5;
    
}

- (void)setBlurredImage:(UIImage *)blurredImage {
    _blurredImage = blurredImage;
    
    self.backgroundImageView.image = self.blurredImage;
    
}

//- (void)didReceiveThemeChangeNotification {
//    
//    [self setNeedsLayout];
//    
//    UIImage *shadowImage           = [UIImage imageNamed:@"Navi_Shadow"];
//    shadowImage                    = shadowImage.imageForCurrentTheme;
//    
//    self.leftShadowImageView.image = shadowImage;
//    self.backgroundImageView.image = nil;
//    
//}
@end
