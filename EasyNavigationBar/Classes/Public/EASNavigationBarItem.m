//
//  EASNavigationBarItem.m
//  EasyNavigationBar
//
//  Created by iya on 2019/3/28.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import "EASNavigationBarItem.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "EASNavigationBarItem+Internal.h"
#import "_EASNavigationBarContentView.h"
#import "EASBarButtonItem.h"
#import "_EASNavigationBarItemButton.h"
#import "EASBarButtonItem+Internal.h"

@interface EASNavigationBarItem ()

@end

@implementation EASNavigationBarItem
@dynamic titleView;
@dynamic backButtonTitle;


#if DEBUG
- (void)dealloc
{
    
}
#endif

- (instancetype)init
{
    self = [super init];
    if (self) {
        _autoHidesBackIndicator = YES;
        _titleColor = [UIColor colorWithRed:0.28 green:0.28 blue:0.29 alpha:1.00];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    if ([_title isEqualToString:title])
        return;
    
    _title = [title copy];
    UIView *view = self.associatedContentView.titleView;
    if (view == nil) {
        // 如果 contentView 中未配置 titleView 则生成一个默认的 Label 作为 titleView.
        UILabel *label = [[UILabel alloc] init];
        label.text = title;
        label.textColor = self.titleColor;
        label.font = [UIFont boldSystemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        self.associatedContentView.titleView = label;
    } else if ([view isKindOfClass:[UILabel class]]) {
        ((UILabel *)(view)).text = title;
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    if (_titleColor == titleColor)
        return;
    
    _titleColor = titleColor;
    if (_titleColor == nil) {
        _titleColor = [UIColor blackColor];
    }
    UIView *view = self.associatedContentView.titleView;
    if ([view isKindOfClass:[UILabel class]]) {
        ((UILabel *)(view)).textColor = titleColor;
    }
}

- (void)setTitleView:(UIView *)titleView
{
    if ([self.titleView isEqual:titleView])
        return;
    
    [self.associatedContentView.titleView removeFromSuperview];
    self.associatedContentView.titleView = titleView;
}

- (UIView *)titleView {
    return self.associatedContentView.titleView;
}

- (void)setHidesBackButton:(BOOL)hidesBackIndicator
{
    _autoHidesBackIndicator = NO;
    _hidesBackButton = hidesBackIndicator;
    [self.associatedContentView setHidesBackButton:_hidesBackButton];
}

- (void)setBackButtonTitle:(NSString *)backButtonTitle {
    [self.associatedContentView.backButton setBackTitle:backButtonTitle];
}

- (NSString *)backButtonTitle {
    return self.associatedContentView.backButton.backTitle;
}

- (void)setLeftBarButtonItem:(EASBarButtonItem *)leftBarButtonItem {
    [self setLeftBarButtonItems:@[leftBarButtonItem]];
}

- (void)setLeftBarButtonItems:(NSArray<EASBarButtonItem *> *)leftBarButtonItems
{
    if (!_leftBarButtonItems && !leftBarButtonItems)
        return;
    if ([_leftBarButtonItems isEqualToArray:leftBarButtonItems])
        return;
    if (leftBarButtonItems == nil) {
        [self.associatedContentView resetLeftViews:nil];
        return;
    }
    
    _leftBarButtonItems = [[NSOrderedSet orderedSetWithArray:leftBarButtonItems] array];
    _leftBarButtonItem = _leftBarButtonItems.firstObject;
    
    NSMutableArray *leftViews = [NSMutableArray arrayWithCapacity:_leftBarButtonItems.count];
    [_leftBarButtonItems enumerateObjectsUsingBlock:^(EASBarButtonItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = item.customView ?: item.button;
        if (!view) {
            _EASNavigationBarItemButton *button = [[_EASNavigationBarItemButton alloc] init];
            [button setEnabled:item.isEnabled];
            [button setTitle:item.title];
            [button setImage:item.image];
            [button setTintColor:item.tintColor];
            [button addTarget:self action:@selector(_handleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            objc_setAssociatedObject(button, "_bar_item", item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            item.button = button;
            view = button;
        }
        [leftViews addObject:view];
    }];
    
    [self.associatedContentView resetLeftViews:leftViews];
}

- (void)setRightBarButtonItem:(EASBarButtonItem *)rightBarButtonItem {
    [self setRightBarButtonItems:@[rightBarButtonItem]];
}

- (void)setRightBarButtonItems:(NSArray<EASBarButtonItem *> *)rightBarButtonItems
{
    if (!_rightBarButtonItems && !rightBarButtonItems)
        return;
    if ([_rightBarButtonItems isEqualToArray:rightBarButtonItems])
        return;
    if (rightBarButtonItems == nil) {
        [self.associatedContentView resetRightViews:nil];
        return;
    }
    
    _rightBarButtonItems = [[NSOrderedSet orderedSetWithArray:rightBarButtonItems] array];
    _rightBarButtonItem = _rightBarButtonItems.lastObject;
    
    NSMutableArray *rightViews = [NSMutableArray arrayWithCapacity:_leftBarButtonItems.count];
    [_rightBarButtonItems enumerateObjectsUsingBlock:^(EASBarButtonItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = item.customView ?: item.button;
        if (!view) {
            _EASNavigationBarItemButton *button = [[_EASNavigationBarItemButton alloc] init];
            [button setEnabled:item.isEnabled];
            [button setTitle:item.title];
            [button setImage:item.image];
            [button setTintColor:item.tintColor];
            [button addTarget:self action:@selector(_handleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            objc_setAssociatedObject(button, "_bar_item", item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            item.button = button;
            view = button;
        }
        [rightViews addObject:view];
    }];
    
    [self.associatedContentView resetRightViews:rightViews];
}

- (void)_handleButtonClick:(UIButton *)sender {
    EASBarButtonItem *item = objc_getAssociatedObject(sender, "_bar_item");
    if (!item) { return; }
    
    if (item.target && item.action) {
        [item.target performSelector:item.action onThread:[NSThread mainThread] withObject:sender waitUntilDone:NO];
    }
}

@end


