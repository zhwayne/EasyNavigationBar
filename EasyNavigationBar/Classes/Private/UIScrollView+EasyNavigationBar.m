//
//  UIScrollView+EasyNavigationBar.m
//  EasyNavigationBar
//
//  Created by iya on 2021/3/22.
//  Copyright © 2021 Wayne. All rights reserved.
//

#import "UIScrollView+EasyNavigationBar.h"
#import "EASViewController.h"
#import "UIView+EasyNavigationBar.h"

#import "_EASMethodSwizzle.h"

@implementation UIScrollView (EasyNavigationBar)

+ (void)swizzingAdjustedContentInset {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            [_EASMethodSwizzle swizzleInstanceMethod:UIScrollView.class
                                    originalSelector:@selector(setSafeAreaInsets:)
                                    swizzledSelector:@selector(eas_setSafeAreaInsets:)];
        }
    });
}

- (void)eas_setSafeAreaInsets:(UIEdgeInsets)arg1 {
    EASViewController *viewController = (EASViewController *)self.eas_viewController;
    BOOL canDoSomeMagic = YES;
    if (![viewController isKindOfClass:[EASViewController class]]) {
        canDoSomeMagic = NO;
    } else if (viewController.isNavigationBarHidden) {
        canDoSomeMagic = NO;
    } else {
        for (UIView *view in viewController.view.subviews) {
            @autoreleasepool {
                NSString *clsName = NSStringFromClass(view.class);
                if ([clsName hasPrefix:@"_UI"] ||
                    [clsName isEqualToString:NSStringFromClass(EASNavigationBar.class)]) {
                    continue;
                }
                if (view != self) {
                    canDoSomeMagic = NO;
                    break;
                }
            }
        }
    }
    
    if (canDoSomeMagic) {
        EASNavigationBar *bar = viewController.navigationBar;
        if (@available(iOS 11.0, *)) {
            CGFloat offset = MAX(CGRectGetMaxY(bar.frame) - CGRectGetMinY(self.frame) - self.superview.safeAreaInsets.top, 0);
            switch (self.contentInsetAdjustmentBehavior) {
                case UIScrollViewContentInsetAdjustmentNever:
                    break;
                case UIScrollViewContentInsetAdjustmentAlways:
                    arg1.top += offset;
                    break;
                case UIScrollViewContentInsetAdjustmentAutomatic:
                    if (viewController.automaticallyAdjustsScrollViewInsets && viewController.navigationController != nil) {
                        arg1.top += offset;
                        break;
                    } else {
                        // fallthrough
                    }
                case UIScrollViewContentInsetAdjustmentScrollableAxes:
                    if (self.alwaysBounceVertical || self.contentSize.height >= self.bounds.size.height) {
                        arg1.top += offset;
                    }
                    break;
                    
                default:
                    break;
            }
        } else {
            CGFloat offset = MAX(CGRectGetMaxY(bar.frame) - CGRectGetMinY(self.frame) - 20, 0);
            // Fallback on earlier versions
            if (viewController.automaticallyAdjustsScrollViewInsets) {
                arg1.top += offset;
            }
        }
    }
    
    [self eas_setSafeAreaInsets:arg1];
}

@end
