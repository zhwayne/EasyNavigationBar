//
//  EASBarButtonItem.m
//  EasyNavigationBar
//
//  Created by iya on 2019/3/28.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import "EASBarButtonItem.h"
#import "EASBarButtonItem+Internal.h"
#import "_EASNavigationBarItemButton.h"

@implementation EASBarButtonItem
@synthesize title;
@synthesize image;

- (instancetype)initWithTitle:(NSString *)title action:(nonnull void (^)(EASBarButtonItem * _Nonnull))action {
    self = [super init];
    if (self) {
        self.title = title;
        self.target = self;
        self.action = @selector(_handleAction:);
        self.actionBlock = [action copy];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    self = [super init];
    if (self) {
        self.title = title;
        self.target = target;
        self.action = action;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image action:(nonnull void (^)(EASBarButtonItem * _Nonnull))action
{
    self = [super init];
    if (self) {
        self.image = image;
        self.target = self;
        self.action = @selector(_handleAction:);
        self.actionBlock = [action copy];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    self = [super init];
    if (self) {
        self.image = image;
        self.target = target;
        self.action = action;
    }
    return self;
}

- (instancetype)initWithCustomView:(UIView *)customView
{
    self = [super init];
    if (self) {
        _customView = customView;
    }
    return self;
}

- (UIView *)view {
    // 目标视图类型的优先级为：customView > button.image > button.title
    if (_customView) {
        return _customView;
    }
    if (_button) {
        Class cls = nil;
        if (_button.image) {
            cls = [UIImageView class];
        } else if (_button.title) {
            cls = [UILabel class];
        }
        if (cls) {
            for (UIView *view in _button.subviews) {
                if ([view isKindOfClass:cls]) {
                    return view;
                }
            }
        }
    }
    return nil;
}

- (void)_handleAction:(id)sender {
    if (_actionBlock) self.actionBlock(self);
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (_customView) {
        _customView.userInteractionEnabled = enabled;
    }
    if (_button) {
        [_button setEnabled:enabled];
    }
}

@end
