//
//  _EASNavigationBarBackButton.m
//  EasyNavigationBar
//
//  Created by iya on 2019/3/27.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import "_EASNavigationBarBackButton.h"
#import "Masonry.h"

@interface _EASNavigationBarBackButton ()

@property (nonatomic) UIImageView *indicatorImageView;
@property (nonatomic) UILabel *backTitleLabel;
@property (nonatomic) MASConstraint *titleImageOffset;

@end

@implementation _EASNavigationBarBackButton
@dynamic backTitle;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _indicatorImage = [self _defaultIndicatorImage];
        
        _backTitleLabel = [[UILabel alloc] init];
        
        _indicatorImageView = [[UIImageView alloc] initWithImage:[_indicatorImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        [_indicatorImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        _indicatorImageView.userInteractionEnabled = NO;
        _indicatorImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _indicatorImageView.contentMode = UIViewContentModeScaleAspectFit;
        _indicatorImageView.clipsToBounds = YES;
        _indicatorImageView.tintColor = self.tintColor;
        [_indicatorImageView sizeToFit];
        [self addSubview:_indicatorImageView];
        [self addSubview:_backTitleLabel];
        
        [_indicatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(14);
            make.size.mas_equalTo(CGSizeMake(13, 21));
            make.centerY.equalTo(self);
            make.right.mas_lessThanOrEqualTo(-8);
        }];
        [_backTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_indicatorImageView);
            make.right.mas_lessThanOrEqualTo(-8);
            _titleImageOffset = make.left.equalTo(_indicatorImageView.mas_right);
        }];
    }
    return self;
}

- (UIImage *)_defaultIndicatorImage {
    static dispatch_once_t onceToken;
    static UIImage *image = nil;
    dispatch_once(&onceToken, ^{
        // Draw back indictor image here.
        // 后期可以考虑开放接口供开发者使用。
        NSInteger scale = [UIScreen mainScreen].scale;
        NSArray<NSString*> *imageContents = @[
                                              @"iVBORw0KGgoAAAANSUhEUgAAABgAAAAqCAQAAAADzFPVAAAAwUlEQVR42s3VoQ7CMBSF4fMKqElExUTNTA1qum4OhZuc4wHwBNc32LthZibmKopgCa2697AQVv39SdP0toBuHfDACKfUOOKJhIQIo+Fm5QkJA8cTWonXBb/LfGK45XiDOeM3jl8l7li+ZFw8+dMW3ku8LfhF5vF7fpa4z3hkeSfxjuN1tvMILw9IyAKvGcDAnM37PUhsUl4HVeK4K7HzZGaTZmvS7yexf0iGnyUTm5SfimUT1bR8kgWV9qeuEDDCAC/uc/8arU7YtgAAAABJRU5ErkJggg==",
                                              @"iVBORw0KGgoAAAANSUhEUgAAACMAAAA+CAQAAAALmGqXAAAA4klEQVR42u3YrQ3DMBAF4IczSwboAkFBYUZmZoFewDgwrKyorDAbdILSoG5QqczABSmoZEtVnBdd+vOOf/De6YD8lBhwwwi7wEAFj/Acl4vUL0iAZyABIQdpIsQzkAAzF1EJpJ2L6IiQQkwCMSJIuxnEJhAtgjgG0jGQPoEoEWS/DuLnI4cE0oggx80gJwYyJJBaBLEMpGAgQBkxVU6VFssX5JTAgRQL6llQtybUfgfkWJBdE7J/6O15RIMcC+pEIfNbUC8K6Y+ANAca83o2LkgwoGv+c0EtPx6m7HDGHRdo4AHSaj/wMAPZmgAAAABJRU5ErkJggg=="
                                              ];
        NSString *content = imageContents[MIN(MAX(0, scale - 2), imageContents.count - 1)];
        NSData *data = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
        image = [UIImage imageWithData:data scale:scale];
//        image = [UIImage imageNamed:@"navi_bar_back_black"];
    });
    return image;
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    _indicatorImageView.tintColor = self.tintColor;
    _backTitleLabel.textColor = self.tintColor;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(20, 44);
}

- (void)setBackTitle:(NSString *)backTitle {
    _backTitleLabel.text = backTitle;
    [_titleImageOffset setOffset:backTitle ? 8 : 0];
}

- (NSString *)backTitle {
    return _backTitleLabel.text;
}

@end
