//
//  SESideMenuSection.m
//  DEMOSideMenu
//
//  Created by Joshua on 15/5/14.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "SESideMenuSection.h"
#import "SESideMenuSectionCell.h"
#import "SECategory.h"
#import "ResearchOL-Swift.h"
#import <SDWebImage/UIImageView+WebCache.h>

static CGFloat const kAvatarHeight = 70.0f;
@interface SESideMenuSection () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIButton    *avatarButton;
@property (nonatomic, strong) UIImageView *divideImageView;
@property (nonatomic, strong) UILabel     *usernameLabel;
@property (nonatomic, strong) UILabel *pointsLabel;

//@property (nonatomic, strong) SCActionSheet      *actionSheet;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray     *sectionImageNameArray;
@property (nonatomic, strong) NSArray     *sectionTitleArray;

@end

@implementation SESideMenuSection

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[ROLNotifications userLoginNotification] object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AvatarDidChoseNotification" object:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.sectionImageNameArray = @[@"SESideMenu.bundle/section_questionare", @"SESideMenu.bundle/section_setting", @"SESideMenu.bundle/section_feedback", @"SESideMenu.bundle/section_about"];
        //        self.sectionTitleArray = @[@"Latest", @"Categories", @"Nodes", @"Favorite", @"Notification", @"Profile"];
        self.sectionTitleArray = @[@"问卷", @"设置", @"反馈", @"关于"];
        
        [self configureTableView];
        [self configureProfileView];
//        [self configureSearchView];
//        [self configureNotifications];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveThemeChangeNotification) name:kThemeDidChangeNotification object:nil];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveUpdateCheckInBadgeNotification) name:kUpdateCheckInBadgeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserDidLoginNotification) name:[ROLNotifications userLoginNotification] object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAvatarDidChoseNotification:) name:@"AvatarDidChoseNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserPointsDidAddNotification:) name:[ROLNotifications userPointsDidAddNotification] object:nil];
    }
    return self;
}

- (void)handleAvatarDidChoseNotification:(NSNotification *)noti {
    self.avatarImageView.image = (UIImage *)noti.object;
}

- (void)handleUserPointsDidAddNotification:(NSNotification *)noti {
    self.pointsLabel.text = [NSString stringWithFormat:@"%ld", (long)[ROLUserInfoManager sharedManager].getPointsForCurrentUser];
}

- (void)handleUserDidLoginNotification {
    self.usernameLabel.text = [AVUser currentUser].username;
    self.pointsLabel.text = [NSString stringWithFormat:@"积分: %ld", (long)[[ROLUserInfoManager sharedManager]getPointsForCurrentUser]];
    [[ROLUserInfoManager sharedManager] getThumbnailAvatarForCurrentUser:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.avatarImageView.image = image;
        });
    } failure:^(NSError *error) {
        
    }];
    
//    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatar.url] placeholderImage:[UIImage imageNamed:@"SESideMenu.bundle/avatar_default"]];
}

- (void)configureTableView {
    
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    //    self.tableView.contentInsetTop = (kScreenHeight - 44 * self.sectionTitleArray.count) / 2;
    self.tableView.contentInsetTop = 120;
    [self addSubview:self.tableView];
    
}


- (void)configureProfileView {
    if (!self.avatarImageView) {
        self.avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SESideMenu.bundle/avatar_default"]];
//        self.avatarImageView = [[UIImageView alloc] init];
        self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.avatarImageView.clipsToBounds = YES;
        self.avatarImageView.layer.cornerRadius = 5; //kAvatarHeight / 2.0;
        self.avatarImageView.layer.borderColor = [UIColor colorFromHexString:@"8a8a8a"].CGColor;
        self.avatarImageView.layer.borderWidth = 1.0f;
        [self addSubview:self.avatarImageView];
        
        self.avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.avatarButton];
        
        self.divideImageView = [[UIImageView alloc] init];
        self.divideImageView.backgroundColor = [UIColor colorFromHexString:@"dbdbdb"];
        self.divideImageView.contentMode = UIViewContentModeScaleAspectFill;
        //    self.divideImageView.image = [UIImage imageNamed:@"section_divide"];
        self.divideImageView.clipsToBounds = YES;
        [self addSubview:self.divideImageView];
        // Handles
        [self.avatarButton addTarget:self action:@selector(avatarBtnDidClicked:) forControlEvents:UIControlEventTouchDown];
        
    }
//    self.avatarImageView.alpha = kSetting.imageViewAlphaForCurrentTheme;
    
    if ([ROLUserInfoManager sharedManager].isUserLogin) {
        [[ROLUserInfoManager sharedManager] getThumbnailAvatarForCurrentUser:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.avatarImageView.image = image;
            });
        } failure:^(NSError *error) {
            
        }];
//        [self.avatarImageView setImageWithURL:[NSURL URLWithString:[V2DataManager manager].user.member.memberAvatarLarge] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
//        self.avatarImageView.layer.borderColor = [UIColor colorWithHexString:@"8a8a8a"] alpha:0.1].CGColor;
        UILabel *username = [[UILabel alloc] init];
        username.text = [AVUser currentUser].username;
        username.font = [UIFont systemFontOfSize:15];
        username.tintColor = [UIColor blackColor];
        self.usernameLabel = username;
        [self addSubview:username];
        
        self.pointsLabel = [[UILabel alloc] init];
        self.pointsLabel.font = [UIFont systemFontOfSize:12];
        self.pointsLabel.tintColor = [UIColor black75PercentColor];
        self.pointsLabel.text = [NSString stringWithFormat:@"积分: %ld", (long)[[ROLUserInfoManager sharedManager]getPointsForCurrentUser]];
        [self addSubview:self.pointsLabel];
    } else {
        UILabel *username = [[UILabel alloc] init];
        username.text = @"游客";
        username.font = [UIFont systemFontOfSize:15];
        username.tintColor = [UIColor blackColor];
        self.usernameLabel = username;
        [self addSubview:username];
        
        self.pointsLabel = [[UILabel alloc] init];
        self.pointsLabel.font = [UIFont systemFontOfSize:12];
        self.pointsLabel.tintColor = [UIColor black75PercentColor];
        self.pointsLabel.text = @"登录以获取积分";
        [self addSubview:self.pointsLabel];
    }
    
//    [self.avatarButton bk_addEventHandler:^(id sender) {
//        
//        if (![V2DataManager manager].user.isLogin) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:kShowLoginVCNotification object:nil];
//        } else {
//            
//            self.actionSheet = [[SCActionSheet alloc] sc_initWithTitles:@[@"是否注销？"] customViews:nil buttonTitles:@"注销", nil];
//            
//            [self.actionSheet sc_configureButtonWithBlock:^(SCActionSheetButton *button) {
//                button.type = SCActionSheetButtonTypeRed;
//            } forIndex:0];
//            
//            [self.actionSheet sc_setButtonHandler:^{
//                
//                [[V2DataManager manager] UserLogout];
//                
//            } forIndex:0];
//            
//            [self.actionSheet sc_show:YES];
//            
//            //            UIAlertView *alertView = [[UIAlertView alloc] bk_initWithTitle:@"是否注销？" message:nil];
//            //            [alertView bk_addButtonWithTitle:@"注销" handler:^{
//            //                [[V2DataManager manager] UserLogout];
//            //            }];
//            //            [alertView bk_setCancelButtonWithTitle:@"取消" handler:^{
//            //                ;
//            //            }];
//            //            [alertView show];
//            
//        }
//        
//    } forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)avatarBtnDidClicked:(UIButton *)avatarBtn {
    if (self.avatarBtnDidClickedBlock) {
        self.avatarBtnDidClickedBlock();
    }
}

- (void)layoutSubviews {
    
    //    CGFloat spaceHeight = (self.tableView.contentInsetTop - kAvatarHeight) / 3.0;
    self.avatarImageView.frame = (CGRect){30, 30, kAvatarHeight, kAvatarHeight};
    self.avatarButton.frame = self.avatarImageView.frame;
    //    self.divideImageView.frame = (CGRect){80, kAvatarHeight + 50, 80, 0.5};
    self.divideImageView.frame = (CGRect){-self.width, kAvatarHeight + 50, self.width * 2, 0.5};
    self.tableView.frame = (CGRect){0, 0, self.width, self.height};
    
    self.usernameLabel.frame = CGRectMake(self.avatarImageView.maxX + 10, self.avatarImageView.minY, 100, 20);
    
    self.pointsLabel.frame = CGRectMake(self.avatarImageView.maxX + 10, self.avatarImageView.maxY - 20, 100, 20);
    
//    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[V2SettingManager manager].selectedSectionIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    
    if (selectedIndex < self.sectionTitleArray.count) {
        _selectedIndex = selectedIndex;
        
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = - scrollView.contentOffsetY;
    
    //    CGFloat spaceHeight = (self.tableView.contentInsetTop - kAvatarHeight) / 3.0;
    
    self.avatarImageView.y = 30 - (scrollView.contentInsetTop - offsetY) / 1.7;
    self.avatarButton.frame = self.avatarImageView.frame;
    
    self.usernameLabel.y = 30 - (scrollView.contentInsetTop - offsetY) / 1.7;
    self.pointsLabel.y = 30 - (scrollView.contentInsetTop - offsetY) / 1.7 + self.avatarImageView.height - self.pointsLabel.height;

    
    self.divideImageView.y = self.avatarImageView.y + kAvatarHeight + (offsetY - (self.avatarImageView.y + kAvatarHeight)) / 2.0 + fabs(offsetY - self.tableView.contentInsetTop)/self.tableView.contentInsetTop * 8.0 + 10;
    
    
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sectionTitleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightCellForIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    SESideMenuSectionCell *cell = (SESideMenuSectionCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[SESideMenuSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return [self configureWithCell:cell IndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.didSelectedIndexBlock) {
        self.didSelectedIndexBlock(indexPath.row);
    }
    
}

#pragma mark - Configure TableCell

- (CGFloat)heightCellForIndexPath:(NSIndexPath *)indexPath {
    
    return [SESideMenuSectionCell getCellHeight];
    
}

- (SESideMenuSectionCell *)configureWithCell:(SESideMenuSectionCell *)cell IndexPath:(NSIndexPath *)indexPath {
    
    cell.imageName = self.sectionImageNameArray[indexPath.row];
    cell.title     = self.sectionTitleArray[indexPath.row];
    
    cell.badge = nil;
    
    //    if (indexPath.row == 5) {
    //        if ([V2CheckInManager manager].isExpired && kSetting.checkInNotiticationOn) {
    //            cell.badge = @"";
    //        }
    //    }
    
    return cell;
    
}

@end
