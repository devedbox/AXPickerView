//
//  AXImagePickerCell.m
//  AXSwift2OC
//
//  Created by ai on 9/6/15.
//  Copyright © 2015 ai. All rights reserved.
//

#import "AXImagePickerCell.h"

@implementation AXImagePickerCell
#pragma mark - Life cycle
- (instancetype)init {
    if (self = [super initWithFrame:CGRectZero]) {
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

- (void)initializer {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.label];
}

#pragma mark - Getters
- (UILabel *)label {
    if (_label) return _label;
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    _label.font = [UIFont systemFontOfSize:12];
    _label.textColor = [UIColor colorWithRed:0.294 green:0.808 blue:0.478 alpha:1.000];
    _label.text = @"已选择";
    [_label sizeToFit];
    _label.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _label.hidden = YES;
    return _label;
}

- (UIImageView *)imageView {
    if (_imageView) return _imageView;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView.clipsToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    return _imageView;
}
#pragma mark - Override
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    _label.hidden = !selected;
    if (selected) {
        _imageView.alpha = 0.1;
    } else {
        _imageView.alpha = 1.0;
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    _imageView.image = nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageView.frame = self.contentView.bounds;
    CGRect rect = _label.frame;
    rect.origin.x = (_imageView.bounds.size.width - rect.size.width) / 2;
    rect.origin.y = (_imageView.bounds.size.height - rect.size.height) / 2;
    _label.frame = rect;
}
@end
