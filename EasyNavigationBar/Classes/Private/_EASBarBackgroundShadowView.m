//
//  _EASBarBackgroundShadowView.m
//  EasyNavigationBar
//
//  Created by iya on 2022/11/19.
//

#import "_EASBarBackgroundShadowView.h"

@implementation _EASBarBackgroundShadowView

+ (UIImage *)defaultShadowImage {
    static UIImage *image = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat scale = [UIScreen mainScreen].scale;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGRect rect = CGRectMake(0, 0, width, 1 / scale);
        UIGraphicsBeginImageContextWithOptions(rect.size, false, scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (@available(iOS 13.0, *)) {
            UIColor *color = [UIColor separatorColor];
            CGContextSetFillColorWithColor(context, [color CGColor]);
        } else {
            UIColor *color = [UIColor colorWithWhite:0.237 alpha:0.29];
            CGContextSetFillColorWithColor(context, [color CGColor]);
        }
        CGContextFillRect(context, rect);
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });
    return image;
}

@end
