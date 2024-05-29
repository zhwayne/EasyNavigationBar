//
//  _EASNavigationBarButton.m
//  EasyNavigationBar
//
//  Created by iya on 2019/3/27.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import "_EASNavigationBarButton.h"

@interface _EASNavigationBarButton ()

@property (nonatomic) CGFloat originalAlpha;

@end

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
        _originalAlpha = 1;
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)setAlpha:(CGFloat)alpha {
    _originalAlpha = alpha;
    [super setAlpha:[self _realAlpha]];
}

- (CGFloat)alpha {
    return _originalAlpha;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        [super setAlpha:[self _realAlpha]];
    } else {
        [UIView animateWithDuration:0.1 animations:^{ [super setAlpha:[self _realAlpha]]; }];
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    [super setAlpha:[self _realAlpha]];
}

- (CGFloat)_highlightAlpha {
    return 0.3;
}

- (CGFloat)_disabledAlpha {
    return 0.3;
}

- (CGFloat)_realAlpha {
    if (self.isEnabled && !self.isHighlighted) {
        return _originalAlpha;
    }
    if (self.isEnabled && self.isHighlighted) {
        return _originalAlpha * [self _highlightAlpha];
    }
    if (!self.isEnabled && !self.isHighlighted) {
        return _originalAlpha * [self _disabledAlpha];
    }
    if (!self.isHighlighted && self.isHighlighted) {
        return _originalAlpha * [self _disabledAlpha] * [self _highlightAlpha];
    }
    return _originalAlpha;
}

@end
