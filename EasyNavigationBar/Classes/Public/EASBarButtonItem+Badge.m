//
//  EASBarButtonItem+Badge.m
//  EasyNavigationBar
//
//  Created by iya on 2019/11/21.
//  Copyright © 2019 Wayne. All rights reserved.
//

#if defined __has_include && __has_include (<CYLTabBarController/CYLTabBarController.h>)

#import "EASBarButtonItem+Badge.h"
#import "EASBarButtonItem+Internal.h"

#define kActualView     [self cyl_getActualBadgeSuperView]

@implementation EASBarButtonItem (Badge)

#pragma mark -- public methods

/**
 *  show badge with red dot style and CYLBadgeAnimationTypeNone by default.
 */
- (void)cyl_showBadge {
    [kActualView cyl_showBadge];
}

- (void)cyl_showBadgeValue:(NSString *)value
         animationType:(CYLBadgeAnimationType)animationType {
    [kActualView cyl_showBadgeValue:value animationType:animationType];
}

- (void)cyl_clearBadge {
    [kActualView cyl_clearBadge];
}

- (void)cyl_resumeBadge {
    [kActualView cyl_resumeBadge];
}

- (BOOL)cyl_isPauseBadge {
    return [kActualView cyl_isPauseBadge];
}

- (BOOL)cyl_isShowBadge {
    return [kActualView cyl_isShowBadge];
}

#pragma mark -- private method

/**
 *  Because UIBarButtonItem is kind of NSObject, it is not able to directly attach badge.
    This method is used to find actual view (non-nil) inside UIBarButtonItem instance.
 *
 *  @return view
 */
- (UIView *)cyl_getActualBadgeSuperView {
    return self.view;
}

#pragma mark -- setter/getter
- (UILabel *)cyl_badge {
    return kActualView.cyl_badge;
}

- (void)cyl_setBadge:(UILabel *)label {
    [kActualView cyl_setBadge:label];
}

- (UIFont *)cyl_badgeFont {
    return kActualView.cyl_badgeFont;
}

- (void)cyl_setBadgeFont:(UIFont *)badgeFont {
    [kActualView cyl_setBadgeFont:badgeFont];
}

- (UIColor *)cyl_badgeBackgroundColor {
    return [kActualView cyl_badgeBackgroundColor];
}

- (void)cyl_setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor {
    [kActualView cyl_setBadgeBackgroundColor:badgeBackgroundColor];
}

- (UIColor *)cyl_badgeTextColor {
    return [kActualView cyl_badgeTextColor];
}

- (void)cyl_setBadgeTextColor:(UIColor *)badgeTextColor {
    [kActualView cyl_setBadgeTextColor:badgeTextColor];
}

- (CYLBadgeAnimationType)cyl_badgeAnimationType {
    return [kActualView cyl_badgeAnimationType];
}

- (void)cyl_setBadgeAnimationType:(CYLBadgeAnimationType)animationType {
    [kActualView cyl_setBadgeAnimationType:animationType];
}

- (CGRect)cyl_badgeFrame {
    return [kActualView cyl_badgeFrame];
}

- (void)cyl_setBadgeFrame:(CGRect)badgeFrame {
    [kActualView cyl_setBadgeFrame:badgeFrame];
}

- (CGPoint)cyl_badgeCenterOffset {
    return [kActualView cyl_badgeCenterOffset];
}

- (void)cyl_setBadgeCenterOffset:(CGPoint)badgeCenterOffset {
    [kActualView cyl_setBadgeCenterOffset:badgeCenterOffset];
}

- (NSInteger)cyl_badgeMaximumBadgeNumber {
    return [kActualView cyl_badgeMaximumBadgeNumber];
}

- (void)cyl_setBadgeMaximumBadgeNumber:(NSInteger)badgeMaximumBadgeNumber {
    [kActualView cyl_setBadgeMaximumBadgeNumber:badgeMaximumBadgeNumber];
}

- (CGFloat)cyl_badgeMargin {
    return [kActualView cyl_badgeMargin];
}

- (void)cyl_setBadgeMargin:(CGFloat)badgeMargin {
    [kActualView cyl_setBadgeMargin:badgeMargin];
}

- (CGFloat)cyl_badgeRadius {
    return [kActualView cyl_badgeRadius];
}

- (void)cyl_setBadgeRadius:(CGFloat)badgeRadius {
    [kActualView cyl_setBadgeRadius:badgeRadius];
}

- (CGFloat)cyl_badgeCornerRadius {
    return [kActualView cyl_badgeCornerRadius];
}

- (void)cyl_setBadgeCornerRadius:(CGFloat)cyl_badgeCornerRadius {
    [kActualView cyl_setBadgeCornerRadius:cyl_badgeCornerRadius];
}

@end

#endif
