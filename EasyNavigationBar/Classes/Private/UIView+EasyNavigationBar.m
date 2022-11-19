//
//  UIView+EasyNavigationBar.m
//  EasyNavigationBar
//
//  Created by iya on 2021/3/22.
//  Copyright © 2021 Wayne. All rights reserved.
//

#import "UIView+EasyNavigationBar.h"
#import <objc/runtime.h>

@implementation UIView (EasyNavigationBar)

- (void)setEas_identifier:(NSString *)eas_identifier {
    objc_setAssociatedObject(self, @selector(eas_identifier), eas_identifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)eas_identifier {
    return objc_getAssociatedObject(self, _cmd);
}

- (UIViewController *)eas_viewController {
    
    for (UIView *next = self.superview; next; next = next.superview) {
        UIResponder *responder = next.nextResponder;
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    
    return nil;
}

- (__kindof UIView *)eas_viewWithTag:(NSUInteger)tag recursive:(BOOL)recursive {
    if (recursive) {
        return [self viewWithTag:tag];
    }
    
    UIView *targetView = nil;
    for (UIView *view in self.subviews) {
        if (view.tag == tag) {
            targetView = view;
            break;
        } else {
            targetView = [view eas_viewWithTag:tag recursive:YES];
            if (targetView) {
                break;
            }
        }
    }
    
    return targetView;
}

- (UIView *)eas_viewWithIdentifier:(NSString *)identifier {
    UIView *targetView = nil;
    for (UIView *view in self.subviews) {
        if ([view.eas_identifier isEqualToString:identifier]) {
            targetView = view;
            break;
        } else {
            targetView = [view eas_viewWithIdentifier:identifier];
            if (targetView) {
                break;
            }
        }
    }
    
    return targetView;
}

@end
