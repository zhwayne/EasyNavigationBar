//
//  EASNavigationBarItem.h
//  EasyNavigationBar
//
//  Created by iya on 2019/3/28.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EASBarButtonItem;

NS_ASSUME_NONNULL_BEGIN

@interface EASNavigationBarItem : NSObject

/// 当前导航栏的标题
@property (nonatomic, copy, nullable) NSString *title;

/// 导航栏标题文字的颜色
@property (nonatomic, null_resettable) UIColor *titleColor;

/// 导航栏的标题视图。设置 titleView 后，原本的 title 会被替换！
/// FIXME: titleView 目前还不支持使用 Masonry 设置约束以及设定 frame, 请谨慎使用。
@property (nonatomic, nullable) UIView *titleView;

/// 导航栏左边的按钮
@property (nonatomic, nullable, copy) NSArray<EASBarButtonItem*> *leftBarButtonItems;
@property (nonatomic, nullable) EASBarButtonItem *leftBarButtonItem;

/// 导航栏右边的按钮
@property (nonatomic, nullable, copy) NSArray<EASBarButtonItem*> *rightBarButtonItems;
@property (nonatomic, nullable) EASBarButtonItem *rightBarButtonItem;

/// 是否隐藏导航栏左边的返回按钮，默认不隐藏。
@property (nonatomic) BOOL hidesBackButton;

/// 返回按钮标题
@property (nonatomic, nullable, copy) NSString *backButtonTitle;

@end

NS_ASSUME_NONNULL_END
