//
//  EASNavigationBar.h
//  EasyNavigationBar
//
//  Created by 张尉 on 2022/11/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <EASNavigationBarItem.h>
#import <EASBarButtonItem.h>

NS_ASSUME_NONNULL_BEGIN

/// EASViewController 维护的导航栏视图
@interface EASNavigationBar : UIView

/// 表示当前导航栏的配置项
@property (nonatomic, readonly) EASNavigationBarItem *barItem;

/// 导航栏的附着视图，设置 attachedView 后，导航栏视图中原有的子视图会被替换
@property (nonatomic, nullable) UIView *attachedView;

@property (nonatomic, nullable) UIColor *barTintColor;

/// 当前导航栏是否是半透明的。当设置为 true，导航栏会有磨砂玻璃效果。
@property (nonatomic, getter=isTranslucent) BOOL translucent;

/// 允许导航栏被覆盖。实现效果不理想，暂不开放接口。
@property (nonatomic, getter=isAllowCovered) BOOL allowCovered NS_UNAVAILABLE;

/// 显示 shadow，当不需要显示导航栏下方的分割线时，将其置空即可。
@property (nonatomic, nullable) UIImage *shadowImage;

@end

NS_ASSUME_NONNULL_END
