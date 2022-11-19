//
//  _EASNavigationBarButton.m
//  EasyNavigationBar
//
//  Created by iya on 2019/3/27.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import "_EASNavigationBarButton.h"

@implementation _EASNavigationBarButton

#if DEBUG
- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}
#endif


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.alpha = 0.3;
    } else {
        [UIView animateWithDuration:0.1 animations:^{ self.alpha = 1; }];
    }
}

@end
