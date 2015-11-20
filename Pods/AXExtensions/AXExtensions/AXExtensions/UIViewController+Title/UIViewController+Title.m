//
//  UIViewController+Title.m
//  AXSwift2OC
//
//  Created by ai on 9/6/15.
//  Copyright © 2015 ai. All rights reserved.
//

#import "UIViewController+Title.h"

@implementation UIViewController (Title)
- (void)setTitle:(NSString *)title titleColor:(UIColor *)color titleFont:(UIFont *)font {
    [self setTitle:title];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [titleLabel setTextColor:color ? color : [UIColor blackColor]];
    [titleLabel setFont:font ? font : [UIFont boldSystemFontOfSize:19]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setText:[self title]];
    if ([self navigationController]) {
        [[[self navigationController] navigationItem] setTitleView:titleLabel];
    }
}
@end
