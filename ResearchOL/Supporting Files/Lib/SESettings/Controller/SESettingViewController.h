//
//  SESettingViewController.h
//  SEFramework
//
//  Created by Joshua on 15/1/22.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SESettingGroup;

@interface SESettingViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *groups;

- (SESettingGroup *)addGroup;
@end
