//
//  AXPickerContentView.h
//  JYV2
//
//  Created by ai on 9/15/15.
//  Copyright © 2015 KEEPStudio. All rights reserved.
//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖保佑             永无BUG
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

#import <UIKit/UIKit.h>
#import "AXPickerCollectionViewCell.h"
#import "AXPickerCollectionViewFlowLayout.h"

@class AXPickerContentView;

@protocol AXPickerContentViewDelegate <NSObject>
@optional
- (void)contentViewDidTouchBackground:(AXPickerContentView *)contentView;
- (void)contentViewDidReachLimitedVelocity:(AXPickerContentView *)contentView;
@end

@protocol AXPickerContentViewDataSource <NSObject>
@required
- (NSInteger)ax_collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (AXPickerCollectionViewCell *)ax_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

extern NSString *const kAXPickerContentViewReuseIdentifier;

@interface AXPickerContentView : UIView
/// Delegate
@property(assign, nonatomic) id<AXPickerContentViewDelegate>delegate;
/// DataSoure
@property(assign, nonatomic) id<AXPickerContentViewDataSource>dataSource;
/// Content insets, default is UIEdgeInsetsZero
@property(assign, nonatomic) UIEdgeInsets contentInsets;
/// Content view
@property(readonly, nonatomic) UIView *contentView;
/*!
 *  Reload data of images
 */
- (void)reloadData;
- (void)selectIndexPath:(NSIndexPath *)indexPath;
@end
