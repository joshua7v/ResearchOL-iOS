//
//  SESettingCell.m
//  SEFramework
//
//  Created by Joshua on 15/1/22.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

#define SEDividerInset 10

#import "SESettingCell.h"
#import "SESettingItem.h"
#import "SESettingArrowItem.h"
#import "SESettingSwitchItem.h"
#import "SESettingLabelItem.h"
#import "SESettingLabelArrowItem.h"
#import "SESettingTextFieldItem.h"
#import "SEBadgeButton.h"
#import "SECommon.h"
#import "SESettingCheckboxItem.h"
//#import <M13Checkbox/M13Checkbox.h>

@interface SESettingCell()
/**
 *  箭头
 */
@property (strong, nonatomic) UIImageView *arrowView;
/**
 *  开关
 */
@property (strong, nonatomic) UISwitch *switchView;
/**
 *  文字
 */
@property (strong, nonatomic) UILabel *labelView;

@property (nonatomic, strong) UIView *labelAndArrow;
//@property (nonatomic, strong) UITextField *textField;
//@property (nonatomic, strong) M13Checkbox *checkbox;
/**
 *  提醒数字
 */
@property (strong, nonatomic) SEBadgeButton *badgeButton;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIImageView *bgView;
@property (nonatomic, weak) UIImageView *selectedBgView;
@end

@implementation SESettingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SESetting";
    SESettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SESettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.tableView = tableView;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // 标题
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        
        // 创建背景
        UIImageView *bgView = [[UIImageView alloc] init];
        self.backgroundView = bgView;
        self.bgView = bgView;
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
//    if (iOS7) {
//        frame.origin.x = 5;
//        frame.size.width -= 10;
//    }
//    frame.size.height = 44;
    [super setFrame:frame];
}

- (void)setItem:(SESettingItem *)item
{
    _item = item;
    
    // 1.设置数据
    [self setupData];
    
    // 2.设置右边的控件
    [self setupRightView];
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    self.backgroundColor = [UIColor whiteColor];
    
    // 设置背景的图片
    //    int totalRows = [self.tableView numberOfRowsInSection:indexPath.section];
    //    NSString *bgName = nil;
    //    NSString *selectedBgName = nil;
    //    if (totalRows == 1) { // 这组就1行
    //        bgName = @"common_setting_bg";
    //        selectedBgName = @"common_setting_bg";
    //    } else if (indexPath.row == 0) { // 首行
    //        bgName = @"common_setting_bg";
    //        selectedBgName = @"common_setting_bg";
    //    } else if (indexPath.row == totalRows - 1) { // 尾行
    //        bgName = @"common_setting_bg";
    //        selectedBgName = @"common_setting_bg";
    //    } else { // 中行
    //        bgName = @"common_setting_bg";
    //        selectedBgName = @"common_setting_bg";
    //    }
    //    self.bgView.image = [UIImage resizedImageWithName:bgName];
    //    self.selectedBgView.image = [UIImage resizedImageWithName:selectedBgName];
}

/**
 *  设置数据
 */
- (void)setupData
{
    // 1.图标
    if (self.item.icon) {
        self.imageView.image = [UIImage imageNamed:self.item.icon];
    }
    
    // 2.标题
    self.textLabel.text = self.item.title;
}

/**
 *  设置右边的控件
 */
- (void)setupRightView
{
    if (self.item.badgeValue) {
        self.badgeButton.badgeValue = self.item.badgeValue;
        self.accessoryView = self.badgeButton;
    } else if ([self.item isKindOfClass:[SESettingSwitchItem class]]) { // 右边是开关
        self.accessoryView = self.switchView;
    } else if ([self.item isKindOfClass:[SESettingArrowItem class]]) { // 右边是箭头
        self.accessoryView = self.arrowView;
    } else if ([self.item isKindOfClass:[SESettingLabelItem class]]) { // 右边是文字
        SESettingLabelItem *item = (SESettingLabelItem *)self.item;
        self.labelView.text = item.text;
        self.accessoryView = self.labelView;
    } else if ([self.item isKindOfClass:[SESettingLabelArrowItem class]]) { // 文字加箭头
        SESettingLabelArrowItem *item = (SESettingLabelArrowItem *)self.item;
        UILabel *label = self.labelAndArrow.subviews.lastObject;
        label.text = item.text;
        self.accessoryView = self.labelAndArrow;
    } else if ([self.item isKindOfClass:[SESettingTextFieldItem class]]) { // 输入框
        SESettingTextFieldItem *item = (SESettingTextFieldItem *)self.item;
        item.textField.placeholder = item.placeholder;
        item.textField.textColor = [UIColor black50PercentColor];
        item.textField.keyboardType = UIKeyboardTypeNumberPad;
        item.textField.frame = CGRectMake(20, 0, self.width, 44);
        item.textField.returnKeyType = UIReturnKeyDone;
        
        [item.textField becomeFirstResponder];
        [self addSubview:item.textField];
    } else if ([self.item isKindOfClass:[SESettingCheckboxItem class]]) {
        SESettingCheckboxItem *item = (SESettingCheckboxItem *)self.item;
        self.accessoryView = item.checkbox;
    } else { // 右边没有东西
        self.accessoryView = nil;
    }
}

#pragma mark - lazy load
- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}

- (UILabel *)labelView
{
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];
        _labelView.frame = CGRectMake(0, 0, 100, 30);
        _labelView.textAlignment = NSTextAlignmentRight;
        _labelView.font = [UIFont systemFontOfSize:13];
        _labelView.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return _labelView;
}

- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imageAssets.bundle/push_arrow"]];
    }
    return _arrowView;
}

- (SEBadgeButton *)badgeButton
{
    if (_badgeButton == nil) {
        _badgeButton = [[SEBadgeButton alloc] init];
    }
    return _badgeButton;
}

- (UIView *)labelAndArrow
{
    if (_labelAndArrow == nil) {
        _labelAndArrow = [[UIView alloc] init];
        _labelAndArrow.frame = CGRectMake(0, 0, 150, 30);
        
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imageAssets.bundle/push_arrow"]];
        arrow.maxX = _labelAndArrow.width;
        arrow.centerY = _labelAndArrow.centerY;
        [_labelAndArrow addSubview:arrow];
        
        UILabel *label = [[UILabel alloc] init];
        label.y = _labelAndArrow.y + _labelAndArrow.height / 2 - _labelAndArrow.height / 2;
        label.width = 100;
        label.x = _labelAndArrow.width - arrow.width - label.width - 10;
        label.height = _labelAndArrow.height;
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [_labelAndArrow addSubview:label];
        
    }
    return _labelAndArrow;
}

//- (UITextField *)textField
//{
//    if (_textField == nil) {
//        _textField = [[UITextField alloc] init];
//        _textField.textColor = [UIColor black50PercentColor];
//        _textField.keyboardType = UIKeyboardTypeNumberPad;
//        _textField.frame = CGRectMake(20, 0, self.width, 44);
//        _textField.returnKeyType = UIReturnKeyDone;
//    }
//    return _textField;
//}

//- (M13Checkbox *)checkbox
//{
//    if (_checkbox == nil) {
//        _checkbox = [[M13Checkbox alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
//        _checkbox.radius = 15;
//        _checkbox.strokeColor = [UIColor blackColor];
//        _checkbox.checkColor = [UIColor blackColor];
//    }
//    return _checkbox;
//}

@end
