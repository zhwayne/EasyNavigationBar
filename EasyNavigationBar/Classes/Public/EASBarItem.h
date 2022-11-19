//
//  EASBarItem.h
//  EasyNavigationBar
//
//  Created by iya on 2021/4/26.
//  Copyright © 2021 Wayne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EASBarItem : NSObject

- (instancetype)init NS_DESIGNATED_INITIALIZER;

@property (nonatomic, getter=isEnabled) BOOL    enabled;    // default is YES

@property (nullable, nonatomic ,copy) NSString  *title;     // default is nil

@property (nullable, nonatomic, strong) UIImage *image;     // default is nil

@property (nonatomic, assign) NSInteger         tag;        // default is 0

@end

NS_ASSUME_NONNULL_END
