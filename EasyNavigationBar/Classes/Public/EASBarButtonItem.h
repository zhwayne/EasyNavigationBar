//
//  EASBarButtonItem.h
//  EasyNavigationBar
//
//  Created by iya on 2019/3/28.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import "EASBarItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface EASBarButtonItem : EASBarItem

/// 当以 `-initWithCustomView:` 初始化时设置。
@property (nonatomic, nullable, readonly) UIView *customView;

@property (nonatomic, nullable, weak) id target;

@property (nonatomic, nullable) SEL action;

- (instancetype)initWithTitle:(NSString *)title action:(void (^)(EASBarButtonItem *item))action;

- (instancetype)initWithTitle:(NSString *)title target:(nullable id)target action:(nullable SEL)action;

- (instancetype)initWithImage:(UIImage *)image action:(void (^)(EASBarButtonItem *item))action;

- (instancetype)initWithImage:(UIImage *)image target:(nullable id)target action:(nullable SEL)action;

- (instancetype)initWithCustomView:(UIView *)customView;

@end

NS_ASSUME_NONNULL_END
