//
//  EASViewController.h
//  EasyNavigationBar
//
//  Created by iya on 2019/3/27.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EASNavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface EASViewController : UIViewController

/// 当前 view controller 的导航栏视图。
@property (nonatomic, readonly) EASNavigationBar *navigationBar;

@property (nonatomic, readonly) BOOL isNavigationBarHidden;

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;

- (void)viewWillBack:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
