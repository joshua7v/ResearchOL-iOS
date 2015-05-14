//
//  SESideMenuSectionCell.m
//  DEMOSideMenu
//
//  Created by Joshua on 15/5/14.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "SESideMenuSectionCell.h"
#import "SECategory.h"
static CGFloat const kCellHeight = 60;
static CGFloat const kFontSize   = 16;
@interface SESideMenuSectionCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *titleLabel;

@property (nonatomic, strong) UIImage     *normalImage;
@property (nonatomic, strong) UIImage     *highlightedImage;
@property (nonatomic, strong) UILabel     *badgeLabel;

@property (nonatomic, assign) BOOL cellHighlighted;

@end

@implementation SESideMenuSectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        [self configureViews];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected) {
        
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.cellHighlighted = selected;
        } completion:nil];
        
    } else {
        
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.cellHighlighted = selected;
        } completion:nil];
        
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (self.isSelected) {
        return;
    }
    
    if (highlighted) {
        
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.cellHighlighted = highlighted;
        } completion:nil];
        
    } else {
        
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.cellHighlighted = highlighted;
        } completion:nil];
        
    }
    
}

- (void)setCellHighlighted:(BOOL)cellHighlighted {
    _cellHighlighted = cellHighlighted;
    
    if (cellHighlighted) {
        
//        if (kSetting.theme == V2ThemeNight) {
//            self.titleLabel.textColor = kFontColorBlackMid;
//            self.backgroundColor = kMenuCellHighlightedColor;
//            self.iconImageView.image = self.normalImage;
//        } else {
            self.titleLabel.textColor = [UIColor colorWithHexString:@"777777" alpha:1.0];
            self.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
            self.iconImageView.image = self.highlightedImage;
//        }
        
    } else {
        
//        if (kSetting.theme == V2ThemeNight) {
//            self.titleLabel.textColor = kFontColorBlackMid;
//            self.backgroundColor = [UIColor clearColor];
//            self.iconImageView.image = self.normalImage;
//        } else {
            self.titleLabel.textColor = [UIColor colorWithHexString:@"777777" alpha:1.0];
            self.backgroundColor = [UIColor clearColor];
            self.iconImageView.image = self.normalImage;
//        }
        
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.frame = (CGRect){30, 21, 18, 18};
    self.titleLabel.frame    = (CGRect){85, 0, 110, self.height};
    
}

- (void)configureViews {
    
    self.iconImageView              = [[UIImageView alloc] init];
    self.iconImageView.contentMode  = UIViewContentModeScaleAspectFill;
    [self addSubview:self.iconImageView];
    
    self.titleLabel                 = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor       = [UIColor colorWithHexString:@"777777" alpha:1.0];
    self.titleLabel.textAlignment   = NSTextAlignmentLeft;
    //    self.titleLabel.font            = [UIFont fontWithName:@"STHeitiSC-Light" size:kFontSize];
    self.titleLabel.font            = [UIFont systemFontOfSize:kFontSize];
    [self addSubview:self.titleLabel];
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = self.title;
    
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    NSString *highlightedImageName = [self.imageName stringByAppendingString:@"_highlighted"];
    
    self.highlightedImage= [[UIImage imageNamed:self.imageName] imageWithTintColor:[UIColor colorWithHexString:@"3fb7fc"]];
    self.normalImage  = [[UIImage imageNamed:highlightedImageName] imageWithTintColor:[UIColor colorWithHexString:@"777777" alpha:1.0]];
    
    self.normalImage = self.normalImage.imageForCurrentTheme;
    self.iconImageView.alpha = 1.0;
    
}


- (void)setBadge:(NSString *)badge {
    _badge = badge;
    
    static const CGFloat kBadgeWidth = 6;
    
    if (!self.badgeLabel && badge) {
        self.badgeLabel = [[UILabel alloc] init];
        self.badgeLabel.backgroundColor = [UIColor redColor];
        self.badgeLabel.textColor = [UIColor whiteColor];
        self.badgeLabel.hidden = YES;
        self.badgeLabel.font = [UIFont systemFontOfSize:5];
        self.badgeLabel.layer.cornerRadius = kBadgeWidth/2.0;
        self.badgeLabel.clipsToBounds = YES;
        [self addSubview:self.badgeLabel];
    }
    
    if (badge) {
        self.badgeLabel.hidden = NO;
    } else {
        self.badgeLabel.hidden = YES;
    }
    
    self.badgeLabel.frame = (CGRect){80, 10, kBadgeWidth, kBadgeWidth};
    self.badgeLabel.text = badge;
    
}

#pragma mark - Class Methods

+ (CGFloat)getCellHeight {
    
    return kCellHeight;
    
}

@end
