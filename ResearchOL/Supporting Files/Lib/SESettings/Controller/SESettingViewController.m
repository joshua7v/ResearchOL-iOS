//
//  SESettingViewController.m
//  SEFramework
//
//  Created by Joshua on 15/1/22.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#import "SECommon.h"
#import "SESettingViewController.h"
#import "SESettingViewController.h"
#import "SESettingGroup.h"
#import "SESettingCell.h"
#import "SESettingArrowItem.h"
#import "SESettingSwitchItem.h"
#import "SESettingLabelItem.h"
//#import "SESettingCheckItem.h"
//#import "SESettingCheckGroup.h"

@interface SESettingViewController ()
@end

@implementation SESettingViewController

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (SESettingGroup *)addGroup
{
    SESettingGroup *group = [SESettingGroup group];
    [self.groups addObject:group];
    return group;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = SEColor(231, 231, 236);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 30;
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SESettingGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SESettingCell *cell = [SESettingCell cellWithTableView:tableView];
    SESettingGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark - 代理
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    SESettingGroup *group = self.groups[section];
    return group.footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SESettingGroup *group = self.groups[section];
    return group.header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 取出模型
    SESettingGroup *group = self.groups[indexPath.section];
    SESettingItem *item = group.items[indexPath.row];
    
    // 执行操作
    if (item.operation) {
        item.operation();
    }
    
    // 有箭头就跳转
    if ([item isKindOfClass:[SESettingArrowItem class]]) {
        SESettingArrowItem *arrowItem = (SESettingArrowItem *)item;
        if (arrowItem.destVcClass) {
            UIViewController *destVc = [[arrowItem.destVcClass alloc] init];
//            destVc.view.backgroundColor = [UIColor whiteColor];
            
            [self.navigationController pushViewController:destVc animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

@end

