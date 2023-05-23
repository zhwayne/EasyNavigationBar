//
//  _EASNavigationBarContentView.m
//  EasyNavigationBar
//
//  Created by iya on 2019/3/27.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import "_EASNavigationBarContentView.h"
#import "Masonry.h"
#import "EASViewController.h"
#import "UIView+EasyNavigationBar.h"

@interface _EASNavigationBarContentView ()

@property (nonatomic) UIStackView *leftStackView;
@property (nonatomic) UIStackView *rightStackView;

@end

@implementation _EASNavigationBarContentView
@dynamic hidesBackButton;

#if DEBUG
- (void)dealloc
{
    
}
#endif


- (UIStackView *)leftStackView
{
    if (!_leftStackView) {
        _leftStackView = [[UIStackView alloc] init];
        _leftStackView.axis = UILayoutConstraintAxisHorizontal;
        _leftStackView.spacing = 8;
        _leftStackView.alignment = UIStackViewAlignmentCenter;
        _leftStackView.distribution = UIStackViewDistributionEqualSpacing;
    }
    
    return _leftStackView;
}

- (UIStackView *)rightStackView
{
    if (!_rightStackView) {
        _rightStackView = [[UIStackView alloc] init];
        _rightStackView.axis = UILayoutConstraintAxisHorizontal;
        _rightStackView.spacing = 8;
        _rightStackView.alignment = UIStackViewAlignmentCenter;
        _rightStackView.distribution = UIStackViewDistributionEqualSpacing;
    }
    
    return _rightStackView;
}

- (_EASNavigationBarBackButton *)backButton {
    if (!_backButton) {
        _backButton = [[_EASNavigationBarBackButton alloc] init];
        [_backButton addTarget:self action:@selector(backButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)resetLeftViews:(NSArray<UIView *> *)leftViews {
    UIStackView *stackView = self.leftStackView;
    if (leftViews.count == 0) {
        stackView.hidden = YES;
        [stackView removeFromSuperview];
        [stackView.arrangedSubviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        return;
    }
    
    [stackView.arrangedSubviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    stackView.hidden = NO;
    [self addSubview:stackView];
    [leftViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [stackView insertArrangedSubview:obj atIndex:idx];
    }];
    [self _rebuildLayoutConstraints];
}

- (void)resetRightViews:(NSArray<UIView *> *)rightViews {
    UIStackView *stackView = self.rightStackView;
    if (rightViews.count == 0) {
        stackView.hidden = YES;
        [stackView removeFromSuperview];
        [stackView.arrangedSubviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        return;
    }
    
    [stackView.arrangedSubviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    stackView.hidden = NO;
    [self addSubview:stackView];
    [rightViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [stackView insertArrangedSubview:obj atIndex:idx];
    }];
    [self _rebuildLayoutConstraints];
}

- (void)setHidesBackButton:(BOOL)hidesBackButton
{
    if (hidesBackButton) {
        self.backButton.hidden = YES;
        [self.backButton removeFromSuperview];
    } else {
        self.backButton.hidden = NO;
        [self addSubview:self.backButton];
    }
    [self _rebuildLayoutConstraints];
}

- (BOOL)isHiddenBackButton {
    return _backButton.isHidden;
}

- (void)setTitleView:(UIView *)titleView
{
    if (_titleView == titleView)
        return;
    
    [_titleView removeFromSuperview];
    _titleView = titleView;
    _titleView.translatesAutoresizingMaskIntoConstraints = NO;
    if (_titleView) [self addSubview:_titleView];
    [self _rebuildLayoutConstraints];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self _rebuildLayoutConstraints];
}

- (void)_rebuildLayoutConstraints
{
    // back button layout
    if (self.backButton.superview) {
        [self.backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.offset(0);
            make.right.mas_lessThanOrEqualTo(-8);
            // 如果没有 leftviews 则扩大按钮区域
            if (!self.leftStackView.superview) {
                make.width.mas_greaterThanOrEqualTo(52);
            } else {
                make.width.mas_greaterThanOrEqualTo(29);
            }
        }];
    }
    
    // left views layout
    if (self.leftStackView.superview) {
        [self.leftStackView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.offset(0);
            make.right.mas_lessThanOrEqualTo(-8);
            if (self.backButton.superview) {
                make.left.equalTo(self.backButton.mas_right);
            } else {
                make.left.offset(12);
            }
        }];
    }
    
    // title view layout
    if (self.titleView.superview) {
        [self.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self).priorityMedium();
            make.right.mas_lessThanOrEqualTo(-8);
            UIView *leftView = self.leftStackView.superview ? self.leftStackView : (self.backButton.superview ? self.backButton : nil);
            if (leftView) {
                make.left.greaterThanOrEqualTo(leftView.mas_right).offset(8);
            } else {
                make.left.mas_greaterThanOrEqualTo(8);
            }
        }];
    }
    
    // right views layout
    if (self.rightStackView.superview) {
        [self.rightStackView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.offset(0);
            make.right.offset(-12);
            UIView *leftView = self.titleView.superview ? self.titleView : (self.leftStackView.superview ? self.leftStackView : (self.backButton.superview ? self.backButton : nil));
            if (leftView) {
                make.left.greaterThanOrEqualTo(leftView.mas_right).offset(8);
            } else {
                make.left.mas_greaterThanOrEqualTo(8);
            }
        }];
    }
}

- (void)backButtonOnClick:(_EASNavigationBarBackButton *)sender {
    UIViewController *viewController = [self eas_viewController];
#if DEBUG
    NSCAssert([viewController isKindOfClass:[EASViewController class]], @"⚠️导航栏未找到类型为 EASViewController 的控制器！建议使用 EASViewController.");
#endif
    if ([viewController isKindOfClass:[EASViewController class]]) {
        [(EASViewController*)viewController viewWillBack:YES];
        return;
    }
    if (viewController.navigationController && viewController.navigationController.viewControllers.count > 1) {
        [viewController.navigationController popViewControllerAnimated:YES];
        return;
    }
    if (viewController.presentingViewController) {
        [viewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
}

@end
