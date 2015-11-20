//
//  AXPhotoCollectionViewCell.m
//  AXSwift2OC
//
//  Created by ai on 9/8/15.
//  Copyright © 2015 ai. All rights reserved.
//

#import "AXPhotoCollectionViewCell.h"

@interface AXPhotoCollectionViewCell()
@end

@implementation AXPhotoCollectionViewCell
#pragma mark - Life cycel
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

- (void)initializer {
    [self.contentView addSubview:self.photoView];
    [self.contentView addSubview:self.selectedLabel];
}
#pragma mark - Override
- (void)prepareForReuse {
    [super prepareForReuse];
    
    _photoView.image = nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _photoView.frame = self.contentView.bounds;
    _selectedLabel.frame = _photoView.bounds;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    _selectedLabel.hidden = !selected;
}

#pragma mark - Getters
- (UILabel *)selectedLabel {
    if (_selectedLabel) return _selectedLabel;
    _selectedLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _selectedLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    _selectedLabel.font = [UIFont systemFontOfSize:12];
    _selectedLabel.textColor = [UIColor colorWithRed:0.294 green:0.808 blue:0.478 alpha:1.000];
    _selectedLabel.textAlignment = NSTextAlignmentCenter;
    _selectedLabel.text = @"已选择";
    [_selectedLabel sizeToFit];
    _selectedLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    _selectedLabel.hidden = YES;
    return _selectedLabel;
}

- (UIImageView *)photoView {
    if (_photoView) return _photoView;
    _photoView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _photoView.backgroundColor = [UIColor clearColor];
    _photoView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _photoView.contentMode = UIViewContentModeScaleAspectFill;
    _photoView.clipsToBounds = YES;
    return _photoView;
}
@end
