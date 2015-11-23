//
//  AXPhotoViewController.m
//  AXSwift2OC
//
//  Created by ai on 9/8/15.
//  Copyright © 2015 ai. All rights reserved.
//

#import "AXPhotoViewController.h"
#import "AXPhotoCollectionViewCell.h"

#ifndef kCFCoreFoundationVersionNumber_iOS_8_0
#define kCFCoreFoundationVersionNumber_iOS_8_0 1140.1
#endif
#ifndef kAXPhotoCollectionViewCellReuseIdentifier
#define kAXPhotoCollectionViewCellReuseIdentifier @"__ax_photo_collectionViewCell"
#endif
#ifndef kAXPhotoCollectionViewCellPadding
#define kAXPhotoCollectionViewCellPadding 2.0
#endif
#ifndef kAXPhotoCollectionViewSize
#define kAXPhotoCollectionViewSize (CGSizeMake((self.view.bounds.size.width - kAXPhotoCollectionViewCellPadding * 4) / 3, (self.view.bounds.size.width - kAXPhotoCollectionViewCellPadding * 2) / 3))
#endif
@interface AXPhotoViewController()
{
    UICollectionView *_photoView;
}
@end

@implementation AXPhotoViewController
#pragma mark - Life cycle
- (instancetype)initWithAssetsGroup:(ALAssetsGroup *)group {
    if (self = [super init]) {
        _assetsGroup = group;
    }
    return self;
}

- (instancetype)initWithPhotoCollection:(PHAssetCollection *)collection {
    if (self = [super init]) {
        _photoCollection = collection;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.photoView];
    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.includeHiddenAssets = NO;
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:_photoCollection
                                                              options:options];
        _photos = result;
        [_photoView reloadData];
    } else {
        if (_assetsGroup) {
            NSMutableArray *assets = [NSMutableArray array];
            [_assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    [assets insertObject:result atIndex:0];
                }
                if (*stop == YES) {
                    _assets = [assets copy];
                    [_photoView reloadData];
                }
            }];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_photoView reloadData];
    AXImagePickerController *imagePickerController = self.imagePickerController;
    NSArray *selectedAsset = imagePickerController.selectedImageInfo[self.title];
    for (id asset in selectedAsset) {
        NSInteger row = (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) ? [_photos indexOfObject:asset] : [_assets indexOfObject:asset];
        [_photoView selectItemAtIndexPath:[NSIndexPath indexPathForItem:row
                                                              inSection:0]
                                 animated:NO
                           scrollPosition:UICollectionViewScrollPositionNone];
    }
}
#pragma mark - Getters
- (UICollectionView *)photoView {
    if (_photoView) return _photoView;
    _photoView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                    collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    _photoView.backgroundColor = [UIColor clearColor];
    _photoView.delegate = self;
    _photoView.dataSource = self;
    [_photoView registerClass:[AXPhotoCollectionViewCell class] forCellWithReuseIdentifier:kAXPhotoCollectionViewCellReuseIdentifier];
    AXImagePickerController *imagePickerController = self.imagePickerController;
    _photoView.allowsMultipleSelection = imagePickerController.allowsMultipleSelection;
    _photoView.showsHorizontalScrollIndicator = NO;
    return _photoView;
}
#pragma mark - Private helper
- (void)markSelectedItemWithCollentionView:(UICollectionView *)collectionView {
    AXImagePickerController *imagePickerController = self.imagePickerController;
    NSArray *selectedIndexPaths = [collectionView indexPathsForSelectedItems];
    if (selectedIndexPaths.count > 0) {
        NSMutableArray *selectedItems = [NSMutableArray array];
        for (NSIndexPath *indexPath in selectedIndexPaths) {
            if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
                id object = [_photos objectAtIndex:indexPath.item];
                if (imagePickerController.allowsMultipleSelection) {
                    if (object) {
                        [selectedItems addObject:object];
                    }
                } else {
                    selectedItems = [@[object] mutableCopy];
                }
            } else {
                id object = _assets[indexPath.item];
                if (imagePickerController.allowsMultipleSelection) {
                    if (object) {
                        [selectedItems addObject:object];
                    }
                } else {
                    selectedItems = [@[object] mutableCopy];
                }
            }
        }
        if (imagePickerController.allowsMultipleSelection) {
            NSMutableDictionary *selectedImageInfo = [imagePickerController.selectedImageInfo mutableCopy];
            if (!selectedImageInfo) {
                selectedImageInfo = [NSMutableDictionary dictionary];
            }
            [selectedImageInfo setObject:selectedItems forKey:self.title];
            imagePickerController.selectedImageInfo = selectedImageInfo;
        } else {
            NSMutableDictionary *selectedImageInfo = [imagePickerController.selectedImageInfo mutableCopy];
            if (!selectedImageInfo) {
                selectedImageInfo = [NSMutableDictionary dictionary];
            }
            [selectedImageInfo setObject:selectedItems forKey:self.title];
            NSArray *keys = [selectedImageInfo allKeys];
            for (NSString *title in keys) {
                if (![title isEqualToString:self.title]) {
                    [selectedImageInfo removeObjectForKey:title];
                }
            }
            imagePickerController.selectedImageInfo = selectedImageInfo;
        }
    } else {
        NSMutableDictionary *selectedImageInfo = [imagePickerController.selectedImageInfo mutableCopy];
        [selectedImageInfo removeObjectForKey:self.title];
        imagePickerController.selectedImageInfo = selectedImageInfo;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return kAXPhotoCollectionViewSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kAXPhotoCollectionViewCellPadding, kAXPhotoCollectionViewCellPadding, kAXPhotoCollectionViewCellPadding, kAXPhotoCollectionViewCellPadding);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kAXPhotoCollectionViewCellPadding;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kAXPhotoCollectionViewCellPadding;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
        return _photos ? [_photos count] : 0;
    } else {
        return _assets ? _assets.count : 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AXPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAXPhotoCollectionViewCellReuseIdentifier
                                                                                forIndexPath:indexPath];
    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
        PHAsset *asset = [_photos objectAtIndex:indexPath.item];
        [[PHImageManager defaultManager] requestImageForAsset:asset
                                                   targetSize:CGSizeMake(kAXPhotoCollectionViewSize.width * 2, kAXPhotoCollectionViewSize.height * 2)
                                                  contentMode:PHImageContentModeAspectFill
                                                      options:nil
                                                resultHandler:^(UIImage *result, NSDictionary *info) {
                                                    cell.photoView.image = result;
                                                }];
    } else {
        ALAsset *asset = _assets[indexPath.item];
        cell.photoView.image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
    }
//    cell.selectedLabel.textColor = self.selectionTintColor;
    cell.tintColor = self.selectionTintColor;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AXImagePickerController *imagePickerController = self.imagePickerController;
    NSDictionary *selectedImageInfo = imagePickerController.selectedImageInfo;
    NSArray *values = [selectedImageInfo allValues];
    NSInteger countOfSelectedPhotos = 0;
    for (NSArray *value in values) {
        countOfSelectedPhotos += value.count;
    }
    if (countOfSelectedPhotos >= imagePickerController.maxAllowedSelectionCount) {
        return NO;
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self markSelectedItemWithCollentionView:collectionView];
    [self updateSelectionInfo];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    AXImagePickerController *imagePickerController = self.imagePickerController;
    if (imagePickerController.allowsMultipleSelection) {
        [self markSelectedItemWithCollentionView:collectionView];
        [self updateSelectionInfo];
    }
}
@end