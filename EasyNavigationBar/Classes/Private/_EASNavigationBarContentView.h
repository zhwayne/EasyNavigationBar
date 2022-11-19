//
//  _EASNavigationBarContentView.h
//  EasyNavigationBar
//
//  Created by iya on 2019/3/27.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "_EASNavigationBarBackButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface _EASNavigationBarContentView : UIView

@property (nonatomic, getter=isHiddenBackButton) BOOL hidesBackButton;

@property (nonatomic) _EASNavigationBarBackButton *backButton;
@property (nonatomic) UIView *titleView;

- (void)resetLeftViews:(nullable NSArray<UIView*>*)leftViews;
- (void)resetRightViews:(nullable NSArray<UIView*>*)rightViews;

@end

NS_ASSUME_NONNULL_END
