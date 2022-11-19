//
//  EASBarButtonItem+Badge.h
//  EasyNavigationBar
//
//  Created by iya on 2019/11/21.
//  Copyright © 2019 Wayne. All rights reserved.
//

#if defined __has_include && __has_include (<CYLTabBarController/CYLTabBarController.h>)

#import <CYLTabBarController/CYLTabBarController.h>
#import "EASBarButtonItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface EASBarButtonItem (Badge) <CYLBadgeProtocol>

- (BOOL)cyl_isShowBadge;

/**
 *  show badge with red dot style and CYLBadgeAnimationTypeNone by default.
 */
- (void)cyl_showBadge;

/**
 *  cyl_showBadge
 *
 *  @param value String value, default is `nil`. if value equal @"" means red dot style.
 *  @param animationType animationType
 */
- (void)cyl_showBadgeValue:(NSString *)value
         animationType:(CYLBadgeAnimationType)animationType;


/**
 *  clear badge(hide badge)
 */
- (void)cyl_clearBadge;

/**
 *  make bage(if existing) not hiden
 */
- (void)cyl_resumeBadge;

- (BOOL)cyl_isPauseBadge;

@end

NS_ASSUME_NONNULL_END

#endif
