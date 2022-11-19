//
//  _EASBarBackground.h
//  EasyNavigationBar
//
//  Created by iya on 2019/3/27.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import <UIKit/UIKit.h>

@class _EASBarBackgroundShadowView;

NS_ASSUME_NONNULL_BEGIN

@interface _EASBarBackground : UIView

@property (nonatomic, nullable) UIVisualEffectView *effectView;     // for translucent bar
@property (nonatomic, nullable) UIImageView *colorAndImageView;     // for opaque bar

@property (nonatomic, nullable) _EASBarBackgroundShadowView *shadowView;

@end

NS_ASSUME_NONNULL_END
