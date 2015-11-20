//
//  AXPickerCollectionViewCell.h
//  JYV2DevTest
//
//  Created by ai on 9/16/15.
//  Copyright © 2015 ai. All rights reserved.
//
/**
 *
 * ━━━━━━神兽出没━━━━━━
 * 　　　┏┓　　　┏┓
 * 　　┏┛┻━━━┛┻┓
 * 　　┃　　　　　　　┃
 * 　　┃　　　━　　　┃
 * 　　┃　┳┛　┗┳　┃
 * 　　┃　　　　　　　┃
 * 　　┃　　　┻　　　┃
 * 　　┃　　　　　　　┃
 * 　　┗━┓　　　┏━┛Code is far away from bug with the animal protecting
 * 　　　　┃　　　┃    神兽保佑,代码无bug
 * 　　　　┃　　　┃
 * 　　　　┃　　　┗━━━┓
 * 　　　　┃　　　　　　　┣┓
 * 　　　　┃　　　　　　　┏┛
 * 　　　　┗┓┓┏━┳┓┏┛
 * 　　　　　┃┫┫　┃┫┫
 * 　　　　　┗┻┛　┗┻┛
 *
 * ━━━━━━感觉萌萌哒━━━━━━
 */

#import <UIKit/UIKit.h>

@class AXPickerCollectionViewCell;

@protocol AXPickerCollectionViewCellDelegate <NSObject>
- (void)collectionViewCellDidBeginDraging:(AXPickerCollectionViewCell *)cell;
- (void)collectionViewCell:(AXPickerCollectionViewCell *)cell didMoveToPoint:(CGPoint)location;
- (void)collectionViewCellDidStopDraging:(AXPickerCollectionViewCell *)cell;
@end

@interface AXPickerCollectionViewCell : UICollectionViewCell
/// Delegate
@property(assign, nonatomic) id<AXPickerCollectionViewCellDelegate>delegate;
/// Image view
@property(strong, nonatomic) UIImageView *imageView;
/// Index path
@property(strong, nonatomic) NSIndexPath *indexPath;
@end
