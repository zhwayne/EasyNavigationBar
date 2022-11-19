//
//  _EasyNavigationBarItemButton.m
//  EasyNavigationBar
//
//  Created by iya on 2019/3/27.
//  Copyright © 2019 Wayne. All rights reserved.
//

#import "_EASNavigationBarItemButton.h"
#import "Masonry.h"

@interface _EASNavigationBarItemButton ()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *titleLabel;

@end


@implementation _EASNavigationBarItemButton
@dynamic image;
@dynamic title;

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = NO;
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (void)setImage:(UIImage *)image {
    if (self.imageView.image == image)
        return;
    
    self.imageView.tintColor = self.tintColor;
    self.imageView.image = image;
    self.imageView.hidden = image == nil;
}

- (UIImage *)image {
    return self.imageView.image;
}

- (void)setTitle:(NSString *)title {
    if ([self.titleLabel.text isEqualToString:title])
        return;
    
    self.titleLabel.text = title.copy;
    self.titleLabel.textColor = self.tintColor;
    self.titleLabel.tintColor = self.tintColor;
    self.titleLabel.hidden = title == nil;
}

- (NSString *)title {
    return self.titleLabel.text;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        self.imageView.hidden = YES;
        self.titleLabel.hidden = YES;
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.left.top.mas_greaterThanOrEqualTo(0);
            make.bottom.right.mas_lessThanOrEqualTo(0);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.left.top.mas_greaterThanOrEqualTo(0);
            make.bottom.right.mas_lessThanOrEqualTo(0);
        }];
    }
    return self;
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    _titleLabel.textColor = self.tintColor;
    _titleLabel.tintColor = self.tintColor;
    _imageView.tintColor = self.tintColor;
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.height = 44;
    size.width = MAX(size.width, 28);
    return size;
}

@end
