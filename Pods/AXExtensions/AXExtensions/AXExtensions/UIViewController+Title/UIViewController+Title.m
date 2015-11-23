//
//  UIViewController+Title.m
//  AXSwift2OC
//
//  Created by ai on 9/6/15.
//  Copyright © 2015 ai. All rights reserved.
//

#import "UIViewController+Title.h"
#import <objc/runtime.h>

@implementation UIViewController (Title)
#pragma mark - Getters
- (AXTitleView *)titleView {
    UIView *view = objc_getAssociatedObject(self, _cmd);
    if (view && [view isKindOfClass:[AXTitleView class]]) {
        return (AXTitleView *)view;
    }
    AXTitleView *titleView = [[AXTitleView alloc] init];
    objc_setAssociatedObject(self, _cmd, titleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return titleView;
}
#pragma mark - Public
- (void)setTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font {
    [self setTitle:title];
    if (color) {
        self.titleView.titleLabel.textColor = color;
        self.titleView.activityIndicator.color = color;
    }
    if (font) self.titleView.titleLabel.font = font;
    self.titleView.titleLabel.text = [self title];
    [self.titleView sizeToFit];
    self.navigationItem.titleView = self.titleView;
}
@end

@implementation AXTitleView
#pragma mark - Life cycle
- (instancetype)init {
    if (self = [super init]) {
        [self initializer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializer];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initializer];
    }
    return self;
}

- (void)initializer {
    self.backgroundColor   = [UIColor clearColor];
    [self addSubview:self.activityIndicator];
    [self addSubview:self.titleLabel];
}

#pragma mark - Override
- (CGSize)sizeThatFits:(CGSize)size {
    CGSize susize = [super sizeThatFits:size];
    [_titleLabel sizeToFit];
    susize.width = CGRectGetWidth(_titleLabel.frame) + (CGRectGetHeight(_titleLabel.frame) + 10)*2;
    susize.height = CGRectGetHeight(_titleLabel.frame);
    return susize;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self sizeToFit];
    CGRect rect_label            = _titleLabel.frame;
    rect_label.origin.x          = CGRectGetMaxX(self.activityIndicator.frame) + 10;
    self.titleLabel.frame        = rect_label;
    CGRect rect_activity         = _activityIndicator.frame;
    rect_activity.origin.y       = (CGRectGetHeight(rect_label) - CGRectGetHeight(rect_activity)) / 2;
    rect_activity.origin.x       = _titleLabel.frame.origin.x - (rect_activity.size.width + 10);
    self.activityIndicator.frame = rect_activity;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) [self layoutSubviews];
}

#pragma mark - Getters
- (UIActivityIndicatorView *)activityIndicator {
    if (_activityIndicator) return _activityIndicator;
    _activityIndicator                  = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.color            = [UIColor colorWithRed:0.100f green:0.100f blue:0.100f alpha:0.800f];
    _activityIndicator.hidesWhenStopped = YES;
    return _activityIndicator;
}
- (UILabel *)titleLabel {
    if (_titleLabel) return _titleLabel;
    _titleLabel                 = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font            = [UIFont boldSystemFontOfSize:20.f];
    _titleLabel.textColor       = [UIColor colorWithRed:0.100f green:0.100f blue:0.100f alpha:0.800f];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment   = NSTextAlignmentCenter;
    _titleLabel.numberOfLines   = 1;
    _titleLabel.lineBreakMode   = NSLineBreakByTruncatingTail;
    return _titleLabel;
}
@end
