//
//  UIView+EasyNavigationBar.h
//  EasyNavigationBar
//
//  Created by iya on 2021/3/22.
//  Copyright © 2021 Wayne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (EasyNavigationBar)

@property (nonatomic, copy, nullable) NSString *eas_identifier;

@property (nonatomic, readonly, nullable) UIViewController *eas_viewController;

- (nullable __kindof UIView *)eas_viewWithTag:(NSUInteger)tag recursive:(BOOL)recursive;

- (nullable __kindof UIView *)eas_viewWithIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
