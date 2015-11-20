//
//  AXPickerView.h
//  AXSwift2OC
//
//  Created by ai on 9/6/15.
//  Copyright © 2015 ai. All rights reserved.
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
#import <AXImagePickerController/AXImagePickerController.h>
#import "AXPickerContentView.h"

#ifndef kAXDefaultTintColor
#define kAXDefaultTintColor [UIColor colorWithRed:0.059 green:0.059 blue:0.059 alpha:1.000]
#endif
#ifndef kAXDefaultSelectedColor
#define kAXDefaultSelectedColor [UIColor colorWithRed:0.294 green:0.808 blue:0.478 alpha:1.000]
#endif
#ifndef kAXDefaultSeparatorColor
#define kAXDefaultSeparatorColor [UIColor colorWithRed:0.824 green:0.824 blue:0.824 alpha:1.000]
#endif
#ifndef kAXDefaultBackgroundColor
#define kAXDefaultBackgroundColor [UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:0.700]
#endif
#ifndef kAXPickerToolBarHeight
#define kAXPickerToolBarHeight 44.0f
#endif
#ifndef kAXPickerHeight
#define kAXPickerHeight 216.0f
#endif

@class AXPickerView;
/*!
 *  A block when the picker view cancel or hided with no handler
 *
 *  @param pickerView a picker view
 */
typedef void(^AXPickerViewRevoking)(AXPickerView *pickerView);
/*!
 *  A block when the pikcer completed
 *
 *  @param pickerView a picker view
 */
typedef void(^AXPickerViewCompletion)(AXPickerView *pickerView);
/*!
 *  A block to configure the picker view before the picker's showing
 *
 *  @param pickerView the picker view to be configured
 */
typedef void(^AXPickerViewConfiguration)(AXPickerView *pickerView);
/*!
 *  A block when the image picker view controller finished selecting images
 *
 *  @param pickerView a picker view
 *  @param images     selected images
 */
typedef void(^AXImagePickerCompletion)(AXPickerView *pickerView, NSArray *images);
/*!
 *  A block when the picker selected a item at the items
 *
 *  @param selectedTitle the title of the selected item
 *  @param index         the index of the selected item
 *  @param inPickerView  a picker view
 */
typedef void(^AXPickerViewExecuting)(NSString *selectedTitle, NSInteger index, AXPickerView *inPickerView);
/// Style of picker view
typedef NS_ENUM(NSInteger, AXPickerViewStyle){
    /// Normal style using buttons
    AXPickerViewStyleNormal,
    /// Date picker style using date picker
    AXPickerViewStyleDatePicker,
    /// Common picker style using custom data source
    AXPickerViewStyleCommonPicker
};

@protocol AXPickerViewDelegate;
@protocol AXPickerViewDataSource;

NS_CLASS_AVAILABLE_IOS(7_0)
@interface AXPickerView : UIView
/// A view attaching the picker view
@property(weak,   nonatomic) UIView *view;
/// Title of picker view
@property(copy,   nonatomic) NSString *title;
/// Titles of buttons in picker view
@property(copy,   nonatomic) NSArray *items;
/// Title label font of buttons
@property(strong, nonatomic) UIFont *itemFont;
/// Font of title label
@property(strong, nonatomic) UIFont *titleFont;
/// Configurations of buttons
@property(copy,   nonatomic) NSArray *itemConfigs;
/// Title label font of cancel button
@property(strong, nonatomic) UIFont *cancelFont;
/// A custom view below the title label
@property(strong, nonatomic) UIView *customView;
/// Title label font of complete button
@property(strong, nonatomic) UIFont *completeFont;
/// Tint color of button items
@property(strong, nonatomic) UIColor *itemTintColor;
/// Style of picker view
@property(assign, nonatomic) AXPickerViewStyle style;
/// Text color of title label
@property(strong, nonatomic) UIColor *titleTextColor;
/// Background color of separator view
@property(strong, nonatomic) UIColor *separatorColor;
/// Configurations of separator view
@property(copy,   nonatomic) NSArray *separatorConfigs;
/// Title label color of cancel button
@property(strong, nonatomic) UIColor *cancelTextColor;
/// Title label color of complete button
@property(strong, nonatomic) UIColor *completeTextColor;
/// Insets of separator view
@property(assign, nonatomic) UIEdgeInsets separatorInsets;
/// Insets of custom view
@property(assign, nonatomic) UIEdgeInsets customViewInsets;
/// Should scale background view
@property(assign, nonatomic) BOOL scaleBackgroundView;
/// Delegate conforms to AXPikcerViewDelegate
@property(assign, nonatomic) id<AXPickerViewDelegate>delegate;
/// Datasource conforms to AXPickerViewDataSource
@property(assign, nonatomic) id<AXPickerViewDataSource>dataSource;
/// Should remove from superview when hided
@property(assign, nonatomic) BOOL removeFromSuperViewOnHide;
/*!
 *  Initialize picker view with style and items.
 *  @discusstion If style is kind of Normal style, items should not be empty.
 *  @discusstion If style is one of DatePicker or CommonPicker, items will be ignored.
 *
 *  @param style a style of picker view to be initialized
 *  @param items items of a Normal style
 *
 *  @return an instance of AXPickerView
 */
- (instancetype)initWithStyle:(AXPickerViewStyle)style items:(NSArray *)items;
/*!
 *  Show picker view in the view that seted before with animation and blocks
 *  @discusstion If animated is YES, picker view will show with a default animation. Otherwise, picker view show without animation
 *  @discusstion When style of picker view is one of DatePicker and CommonPicker, completion will be executed if there has one when picker view has a completion action.
 *  @discusstion Revoking block will be executed when picker view has a revoking action such as canceling or touching background.
 *  @discusstion When style of picker view is Normal and picker view has a action of selecting item, executing block will be executed.
 *
 *  @param animated   A boolean value deciding how to show in a view.
 *  @param completion A completion call back block when competed.
 *  @param revoking   A revoking call back block when revoked.
 *  @param executing  Execute a block when selected item.
 */
- (void)showAnimated:(BOOL)animated completion:(AXPickerViewCompletion)completion revoking:(AXPickerViewRevoking)revoking executing:(AXPickerViewExecuting)executing;
/*!
 *  Hide picker view from superview, remove from super view if removeFromSuperViewOnHide is YES.
 *
 *  @param animated   A boolean value deciding how to hide.
 *  @param completion A completion block when finished hiding.
 */
- (void)hideAnimated:(BOOL)animated completion:(void(^)())completion;
@end

@interface AXPickerView(DatePicker)
/// Selected date of date picker view
@property(readonly, nonatomic) NSDate *selectedDate;
@end

@interface AXPickerView(CommonPicker)
/// Number of components
@property(readonly, nonatomic) NSInteger numberOfComponents;
/*!
 *  Get the selected row in a component.
 *
 *  @param component A component
 *
 *  @return A row number
 */
- (NSInteger)selectedRowInComponent:(NSInteger)component;
/*!
 *  Reload the custom data and refresh the common picker view
 */
- (void)reloadData;
@end

@interface AXPickerView(Convenience)
/// Tips content label
@property(readonly, nonatomic) UILabel *tipsLabel;
/*!
 *  Initialize a picker view and show in a target view with some params.
 *
 *  @param view          A target view.
 *  @param animated      A boolean value to decide animate or not.
 *  @param style         Style of picker view.
 *  @param items         Items when style is Normal style.
 *  @param title         Title of picker view.
 *  @param tips          Custom tips.
 *  @param configuration Configuration before picker view showing.
 *  @param completion    Completion call back block when completed.
 *  @param revoking      Revoking call bcak block when revoked.
 *  @param executing     Executing call back block when selected button items.
 *
 *  @return A configured picker view
 */
+ (instancetype)showInView:(UIView *)view animated:(BOOL)animated style:(AXPickerViewStyle)style items:(NSArray *)items title:(NSString *)title tips:(NSString *)tips configuration:(AXPickerViewConfiguration)configuration completion:(AXPickerViewCompletion)completion revoking:(AXPickerViewRevoking)revoking executing:(AXPickerViewExecuting)executing;
/*!
 *  Initialize a picker view and show in a target view with some params.
 *
 *  @param view          A target view.
 *  @param animated      A boolean value to decide animate or not.
 *  @param style         Style of picker view.
 *  @param items         Items when style is Normal style.
 *  @param title         Title of picker view.
 *  @param customView    Custom view.
 *  @param configuration Configuration before picker view showing.
 *  @param completion    Completion call back block when completed.
 *  @param revoking      Revoking call bcak block when revoked.
 *  @param executing     Executing call back block when selected button items.
 *
 *  @return A configured picker view
 */
+ (instancetype)showInView:(UIView *)view animated:(BOOL)animated style:(AXPickerViewStyle)style items:(NSArray *)items title:(NSString *)title customView:(UIView *)customView configuration:(AXPickerViewConfiguration)configuration completion:(AXPickerViewCompletion)completion revoking:(AXPickerViewRevoking)revoking executing:(AXPickerViewExecuting)executing;
@end

@interface AXPickerView(ImagePicker) <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AXImagePickerControllerDelegate, PHPhotoLibraryChangeObserver>
/// Fetch result object of photo asset.
@property(strong, nonatomic) PHFetchResult *photoAssetsResult;
/// ALAsset library.
@property(strong, nonatomic) ALAssetsLibrary *photoLibrary;
/// Array of ALAsset.
@property(readonly, nonatomic) NSMutableArray *photoAssets;
/// Allow multiple selection or not.
@property(assign, nonatomic) BOOL allowsMultipleSelection;
/// Contains camera or not.
@property(assign, nonatomic) BOOL containsCamera;
/// Max allowed image selection count. Defaults 9.
@property(assign, nonatomic) NSUInteger maxAllowedSelectionCount;
/// Selection tint color. Default green.
@property(strong, nonatomic) UIColor *selectionTintColor;
/// Image picker view controller
@property(readonly, nonatomic) AXImagePickerController *imagePickerController;
/*!
 *  Initialize a picker with a image picker view as custom view and show in a target view.
 *
 *  @param view                    A target view.
 *  @param animated                Animated or not.
 *  @param allowsMultipleSelection Allow multiple slection or not. Default is NO.
 *  @param containsCamera          Contains camera or not. Default is YES.
 *  @param configuration           Configuration before picker view showing.
 *  @param completion              Completion call back block when completed.
 *  @param revoking                Revoking call bcak block when revoked.
 *  @param imagePickerCompletion   Executing call back block when selected button items.
 *
 *  @return A configured picker view
 */
+ (instancetype)showImagePickerInView:(UIView *)view animated:(BOOL)animated allowsMultipleSelection:(BOOL)allowsMultipleSelection containsCamera:(BOOL)containsCamera configuration:(AXPickerViewConfiguration)configuration completion:(AXPickerViewCompletion)completion revoking:(AXPickerViewRevoking)revoking imagePickercompletion:(AXImagePickerCompletion)imagePickerCompletion;
@end

@protocol AXPickerViewPreviewImageDatasource;

@interface AXPickerView(ImagePreview)
/// Preview image view datasource
@property(assign, nonatomic) id<AXPickerViewPreviewImageDatasource>previewDataSource;
- (void)selectIndexPath:(NSIndexPath *)indexPath;
@end

@protocol AXPickerViewDelegate <UIPickerViewDelegate>
@optional
/*!
 *  Picker view will show
 *
 *  @param pickerView a picker view
 */
- (void)pickerViewWillShow:(AXPickerView *)pickerView;
/*!
 *  Picker view did show
 *
 *  @param pickerView a picker view
 */
- (void)pickerViewDidShow:(AXPickerView *)pickerView;
/*!
 *  Picker view will hide
 *
 *  @param pickerView a picker view
 */
- (void)pickerViewWillHide:(AXPickerView *)pickerView;
/*!
 *  Picker view did hide
 *
 *  @param pickerView a picker view
 */
- (void)pickerViewDidHide:(AXPickerView *)pickerView;
/*!
 *  Picker view did cancel
 *
 *  @param pickerView a picker view
 */
- (void)pickerViewDidCancel:(AXPickerView *)pickerView;
/*!
 *  Picker view did confirm
 *
 *  @param pickerView a picker view
 */
- (void)pickerViewDidConfirm:(AXPickerView *)pickerView;
/*!
 *  Called when a picker view did selected item at index of items.
 *
 *  @param pickerView a picker view
 *  @param item       selected item
 *  @param index      a index of items
 */
- (void)pickerView:(AXPickerView *)pickerView didSelectedItem:(NSString *)item atIndex:(NSInteger)index;
@end

@protocol AXPickerViewDataSource <UIPickerViewDataSource>

@end

@protocol AXPickerContentViewDataSource;

@protocol AXPickerViewPreviewImageDatasource <AXPickerContentViewDataSource>

@end

#pragma mark - Configurations
@interface AXPickerViewItemConfiguration : NSObject
/// Index of item.
@property(readonly, nonatomic) NSInteger index;
/// Tint color of item.
@property(readonly, nonatomic) UIColor *tintColor;
/// Text font of item.
@property(readonly, nonatomic) UIFont *textFont;
/*!
 *  Get instance of configuration with color, font and index.
 *
 *  @param tintColor A tint color of item.
 *  @param textFont  Text font of item.
 *  @param index     Index in the items.
 *
 *  @return configuration
 */
+ (instancetype)configurationWithTintColor:(UIColor *)tintColor font:(UIFont *)textFont atIndex:(NSInteger)index;
@end

@interface AXPickerViewSeparatorConfiguration: NSObject
/// Index of item.
@property(readonly, nonatomic) NSInteger index;
/// Height of separator.
@property(readonly, nonatomic) CGFloat height;
/// Insets of separator view.
@property(readonly, nonatomic) UIEdgeInsets insets;
/// Background color of separator view.
@property(readonly, nonatomic) UIColor *color;
/*!
 *  Get instance of configuration with height, insets, color and index.
 *
 *  @param height Height of separator.
 *  @param insets Insets of separator view.
 *  @param color  Color of separator view.
 *  @param index  Index of separaot view.
 *
 *  @return configuration
 */
+ (instancetype)configurationWithHeight:(CGFloat)height insets:(UIEdgeInsets)insets color:(UIColor *)color atIndex:(NSInteger)index;
@end