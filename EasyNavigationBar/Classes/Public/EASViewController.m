//
//  EASViewController.m
//  EasyNavigationBar
//
//  Created by iya on 2019/3/27.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import "EASViewController.h"
#import "EASNavigationBarItem+Internal.h"
#import "_EASNavigationBarContentView.h"
#import "UIScrollView+EasyNavigationBar.h"
#import "NSArray+EASBlock.h"
#import <objc/runtime.h>
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>

@interface EASViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, readwrite) EASNavigationBar *navigationBar;
@property (nonatomic, readwrite) BOOL isNavigationBarHidden;

@end

@implementation EASViewController
@dynamic navigationBar;

#if DEBUG
- (void)dealloc
{
    [UINavigationBar appearance];
    NSLog(@"-[%@ dealloc]", [self class]);
}
#endif

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (EASNavigationBar *)navigationBar {
    EASNavigationBar *bar = objc_getAssociatedObject(self, _cmd);
    if (bar == nil) {
        bar = [[EASNavigationBar alloc] initWithFrame:CGRectZero];
        objc_setAssociatedObject(self, _cmd, bar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return bar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navigationBar];
    if (self.navigationBar.barItem.title == nil) {
        self.navigationBar.barItem.title = self.title ?: self.navigationItem.title;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationBar.barItem.autoHidesBackIndicator) {
        UINavigationController *navc = self.navigationController;
        UIViewController *parent = self.parentViewController;
        BOOL hidden = !navc || navc.viewControllers.count <= 1 || navc != parent;
        [self.navigationBar.barItem.associatedContentView setHidesBackButton:hidden];
    }
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.navigationBar.barItem.title = title;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self _updatetNavigationBarFrame];
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    [self _updatetNavigationBarFrame];
}

- (void)_updatetNavigationBarFrame {
    //    if (!self.navigationBar.isAllowCovered) {
    [self.view bringSubviewToFront:self.navigationBar];
    //    }
    
    /* 这里对 EasyAlert 弹框兼容，目前的做法是弹框需要在导航栏上层。后续可以考虑开放接口供开发者配置。 */
    NSArray *alertBgViews = [self.view.subviews select:^BOOL(__kindof UIView * _Nonnull obj) {
        NSString *clsString = NSStringFromClass(obj.class);
        return [clsString containsString:@"Alert"] && [clsString hasSuffix:@"BackgroundView"];
    }];
    [alertBgViews forEach:^(id  _Nonnull obj) {
        [self.view bringSubviewToFront:obj];
    }];
    
    if (!CGRectEqualToRect(self.view.frame, CGRectZero) && self.isNavigationBarHidden == NO) {
        const CGFloat width = CGRectGetWidth(super.view.frame);
        const CGFloat height = 44;
        const CGFloat x = 0;
        CGFloat y = 20;
        if (@available(iOS 11.0, *)) { y = self.view.safeAreaInsets.top; }
        self.navigationBar.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        self.navigationBar.frame = CGRectMake(x, y, width, height);
    }
}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    if (self.isNavigationBarHidden == hidden)
        return;
    
    self.isNavigationBarHidden = hidden;
    
    [self.view layoutIfNeeded];
    
    if (hidden) {
        CGFloat offset = CGRectGetMaxY(self.navigationBar.frame);
        void (^animations)(void) = ^{
            CGRect frame = self.navigationBar.frame;
            frame.origin.y -= offset;
            self.navigationBar.frame = frame;
            [self.view layoutIfNeeded];
        };
        void (^completion)(void) = ^{
            self.navigationBar.hidden = self.isNavigationBarHidden;
            [self.navigationBar removeFromSuperview];
        };
        if (animated) {
            UISpringTimingParameters *parameters = [[UISpringTimingParameters alloc] init];
            UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc] initWithDuration:1.0 timingParameters:parameters];
            [animator addAnimations:animations];
            [animator addCompletion:^(UIViewAnimatingPosition finalPosition) {
                completion();
            }];
            [animator startAnimation];
        } else {
            [UIView performWithoutAnimation:animations];
            completion();
        }
    } else {
        CGFloat y = 20;
        [self.view addSubview:self.navigationBar];
        if (@available(iOS 11.0, *)) { y = super.view.safeAreaInsets.top; }
        self.navigationBar.hidden = self.isNavigationBarHidden;
        
        void (^animations)(void) = ^{
            CGRect frame = self.navigationBar.frame;
            frame.origin.y = y;
            self.navigationBar.frame = frame;
            [self.view layoutIfNeeded];
        };
        
        if (animated) {
            UISpringTimingParameters *parameters = [[UISpringTimingParameters alloc] init];
            UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc] initWithDuration:1.0 timingParameters:parameters];
            [animator addAnimations:animations];
            [animator startAnimation];
        } else {
            [UIView performWithoutAnimation:animations];
        }
    }
}

- (void)viewWillBack:(BOOL)animated {
    if (self.navigationController && self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:animated];
        return;
    }
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:animated completion:nil];
        return;
    }
}

@end
