//
//  _EASBarBackground.m
//  EasyNavigationBar
//
//  Created by iya on 2019/3/27.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import "_EASBarBackground.h"
#import "_EASBarBackgroundShadowView.h"
@import Masonry;

@implementation _EASBarBackground

#if DEBUG
- (void)dealloc
{
    
}
#endif

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setEffectView:(UIVisualEffectView *)effectView {
    if (_effectView == effectView) {
        return;
    }
    
    [_colorAndImageView removeFromSuperview];
    [_effectView removeFromSuperview];
    _colorAndImageView = nil;
    _effectView = effectView;
    
    if (_effectView) {
        _effectView.userInteractionEnabled = NO;
        _effectView.frame = self.bounds;
        _effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_effectView];
    }
}

- (void)setColorAndImageView:(UIImageView *)colorAndImageView {
    if (_colorAndImageView == colorAndImageView) {
        return;
    }
    
    [_effectView removeFromSuperview];
    [_colorAndImageView removeFromSuperview];
    _effectView = nil;
    _colorAndImageView = colorAndImageView;
    
    if (_colorAndImageView) {
        _colorAndImageView = colorAndImageView;
        _colorAndImageView.backgroundColor = [UIColor whiteColor];
        _colorAndImageView.userInteractionEnabled = NO;
        _colorAndImageView.frame = self.bounds;
        _colorAndImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_colorAndImageView];
    }
}

- (void)setShadowView:(_EASBarBackgroundShadowView *)shadowView {
    if (_shadowView == shadowView) {
        return;
    }
    [_shadowView removeFromSuperview];
    _shadowView = shadowView;
    
    if (_shadowView) {
        _shadowView.userInteractionEnabled = NO;
        _shadowView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, _shadowView.frame.size.height);
        _shadowView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:_shadowView];
        [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.equalTo(self.mas_bottom).offset(0);
        }];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    if (_effectView) {
        _effectView.contentView.backgroundColor = backgroundColor;
        _effectView.contentView.alpha = 0.85;
    } else {
        _colorAndImageView.backgroundColor = backgroundColor;
    }
}

- (UIColor *)backgroundColor {
    if (_effectView) {
        return _effectView.contentView.backgroundColor;
    } else {
        return _colorAndImageView.backgroundColor;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_shadowView) {
        [self bringSubviewToFront:_shadowView];
    }
}

@end
