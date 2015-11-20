//
//  AXPickerCollectionViewCell.m
//  JYV2DevTest
//
//  Created by ai on 9/16/15.
//  Copyright © 2015 ai. All rights reserved.
//

#import "AXPickerCollectionViewCell.h"

@interface AXPickerCollectionViewCell()<UIGestureRecognizerDelegate>
{
    UIPanGestureRecognizer *_panGesture;
    CGPoint _startPoint;
    BOOL _hasBegun;
}
@end

@implementation AXPickerCollectionViewCell
#pragma mark - Initializer
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
    // Set up pan gesture
    _startPoint = CGPointZero;
    _hasBegun = NO;
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    _panGesture.delegate = self;
    // Set the background color
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    // Add to view
    [self.contentView addSubview:self.imageView];
    self.contentView.clipsToBounds = NO;
}

#pragma mark - Override
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *testView = [super hitTest:point withEvent:event];
    _startPoint = point;
    return testView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageView.frame = self.contentView.bounds;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    if (!CGAffineTransformIsIdentity(_imageView.transform)) {
        _imageView.transform = CGAffineTransformIdentity;
    }
    _imageView.image = nil;
}

#pragma mark - Getters
- (UIImageView *)imageView {
    if (_imageView) return _imageView;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.clipsToBounds = YES;
    _imageView.opaque = YES;
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:_panGesture];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    return _imageView;
}

#pragma mark - Actions
- (void)handlePanGesture:(UIPanGestureRecognizer *)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint location = [pan translationInView:_imageView];
            if (location.x == 0 && ABS(location.y) >= 0.5) {
                _hasBegun = YES;
                if (_delegate && [_delegate respondsToSelector:@selector(collectionViewCellDidBeginDraging:)]) {
                    [_delegate collectionViewCellDidBeginDraging:self];
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint location = [pan translationInView:_imageView];
            if (_hasBegun) {
                if (_delegate && [_delegate respondsToSelector:@selector(collectionViewCell:didMoveToPoint:)]) {
                    [_delegate collectionViewCell:self didMoveToPoint:location];
                }
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        {
            if (_hasBegun) {
                _hasBegun = NO;
                if (_delegate && [_delegate respondsToSelector:@selector(collectionViewCellDidStopDraging:)]) {
                    [_delegate collectionViewCellDidStopDraging:self];
                }
            }
        }
            break;
        default:
        {
            _hasBegun = NO;
        }
            break;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == _panGesture) {
        if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
            return NO;
        }
    }
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == _panGesture) {
        if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
            return YES;
        }
    }
    return NO;
}
@end