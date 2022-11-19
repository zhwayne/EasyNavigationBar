//
//  _EASNavigationBarItemButton.h
//  EasyNavigationBar
//
//  Created by iya on 2019/3/27.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import "_EASNavigationBarButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface _EASNavigationBarItemButton : _EASNavigationBarButton

@property (nonatomic, copy, nullable) NSString *title;

@property (nonatomic, strong, nullable) UIImage *image;

@end

NS_ASSUME_NONNULL_END
