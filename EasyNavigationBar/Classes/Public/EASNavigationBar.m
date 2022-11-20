//
//  EasyNavigationBar.m
//  EasyNavigationBar
//
//  Created by iya on 2018/12/18.
//  Copyright © 2018 Wayne. All rights reserved.
//

#import "EASNavigationBar.h"
#import "_EASBarBackground.h"
#import "_EASBarBackgroundShadowView.h"
#import "_EASNavigationBarContentView.h"
#import "EASNavigationBarItem+Internal.h"
#import "Masonry.h"

@interface EASNavigationBar ()

@property (nonatomic) _EASBarBackground *backgroundView;
@property (nonatomic) _EASNavigationBarContentView *contentView;
@property (nonatomic) MASConstraint *backgroundHeightConstraint;

@end

@implementation EASNavigationBar
@dynamic translucent;
@dynamic shadowImage;

+ (void)initialize
{
    if (self == [EASNavigationBar class]) {
        [EASNavigationBar appearance].tintColor = [UIColor colorWithRed:0.28 green:0.28 blue:0.29 alpha:1.00];
        [EASNavigationBar appearance].barTintColor = [UIColor whiteColor];
        [EASNavigationBar appearance].translucent = YES;
    }
}

#if DEBUG
- (void)dealloc
{
    
}
#endif

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        _backgroundView = [[_EASBarBackground alloc] init];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentView = [[_EASNavigationBarContentView alloc] init];
        
        [self addSubview:_backgroundView];
        [self addSubview:_contentView];
        
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            _backgroundHeightConstraint = make.height.mas_equalTo(44);
        }];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.offset(0);
            if (@available(iOS 11.0, *)) {
                make.left.equalTo(self.mas_safeAreaLayoutGuideLeft);
                make.right.equalTo(self.mas_safeAreaLayoutGuideRight);
            } else {
                make.left.right.offset(0);
            }
        }];
        
        _barItem = [[EASNavigationBarItem alloc] init];
        _barItem.associatedContentView = _contentView;

        
//        [self setShadowImage:_EASBarBackgroundShadowView.defaultShadowImage];
//        [self setTranslucent:NO];
//        self.barTintColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setAttachedView:(UIView *)attachedView {
    if (attachedView == nil) {
        [_attachedView removeFromSuperview];
        _contentView.hidden = NO;
    } else {
        _contentView.hidden = YES;
        if (attachedView != _attachedView) {
            [_attachedView removeFromSuperview];
            _attachedView = attachedView;
            _attachedView.frame = self.bounds;
            _attachedView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self addSubview:_attachedView];
        }
    }
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    _barTintColor = barTintColor;
    _backgroundView.backgroundColor = barTintColor;
}

- (void)setTranslucent:(BOOL)translucent {
    if (translucent) {
        UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _backgroundView.effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    } else {
        _backgroundView.colorAndImageView = [[UIImageView alloc] init];
    }
    _backgroundView.backgroundColor = _barTintColor;
}

- (BOOL)isTranslucent {
    return _backgroundView.effectView ? YES : NO;
}

- (void)setShadowImage:(UIImage *)shadowImage {
    if (shadowImage) {
        if (!_backgroundView.shadowView) {
            _backgroundView.shadowView = [[_EASBarBackgroundShadowView alloc] init];
        }
        _backgroundView.shadowView.image = shadowImage;
    } else {
        _backgroundView.shadowView = nil;
    }
}

- (UIImage *)shadowImage {
    return _backgroundView.shadowView.image;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_backgroundHeightConstraint setOffset:CGRectGetMaxY(self.frame)];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIScreen.mainScreen.bounds.size.width, 44);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}

@end
