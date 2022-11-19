//
//  EASNavigationBarItem+Internal.h
//  EasyNavigationBar
//
//  Created by iya on 2019/3/28.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import "EASNavigationBarItem.h"

NS_ASSUME_NONNULL_BEGIN
@class _EASNavigationBarContentView;
@interface EASNavigationBarItem ()

/// barItem 关联的内容视图。
@property (nonatomic, weak) _EASNavigationBarContentView *associatedContentView;

/// 是否自动隐藏返回指示器，如果手动调用了 `-setHidesBackIndicator:` 方法，则该值为 NO，默认为 YES。
@property (nonatomic, assign) BOOL autoHidesBackIndicator;

@end

NS_ASSUME_NONNULL_END
