//
//  EASBarButtonItem+Internal.h
//  EasyNavigationBar
//
//  Created by iya on 2019/3/28.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import "EASBarButtonItem.h"
#import "_EASNavigationBarItemButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface EASBarButtonItem ()

/// EASBarButtonItem 的用户响应事件回调
@property (nonatomic, copy) void (^actionBlock)(EASBarButtonItem *item);

/// button EASBarButtonItem 绑定的视图
/// @note: 只有当 item 添加到导航栏中，view 才会有值
@property (nonatomic, weak, nullable) _EASNavigationBarItemButton *button;

/// 显示的内容视图
@property (nonatomic, readonly) UIView *view;

@end

NS_ASSUME_NONNULL_END
