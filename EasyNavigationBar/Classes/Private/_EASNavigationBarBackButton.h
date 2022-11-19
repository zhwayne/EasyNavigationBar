//
//  _EASNavigationBarBackButton.h
//  EasyNavigationBar
//
//  Created by iya on 2019/3/27.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import "_EASNavigationBarButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface _EASNavigationBarBackButton : _EASNavigationBarButton

@property (nonatomic, nullable, strong) UIImage *indicatorImage;

@property (nonatomic, nullable, copy) NSString *backTitle;

@end

NS_ASSUME_NONNULL_END
