//
//  AXImagePickerCell.m
//  AXPickerView
//
//  Created by xing Ai on 9/6/15.
//  Copyright (c) 2015 xing Ai. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
