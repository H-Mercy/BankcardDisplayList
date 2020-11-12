//
//  WalletCollectionViewLayout.h
//  HomeGoods
//
//  Created by rockfintech on 2020/11/12.
//  Copyright © 2020 mercy. All rights reserved.
//
/*=================
钱包--collectionViewLayout
====================*/
#import <UIKit/UIKit.h>
//定义全局变量的头，尾
UIKIT_EXTERN NSString * _Nonnull const TMSCollectionViewSectionHeader;
UIKIT_EXTERN NSString * _Nonnull const TMSCollectionViewSectionFooter;

NS_ASSUME_NONNULL_BEGIN

@protocol WalletcollectionViewLayoutDelegate <NSObject>

@required
/** section header */
- (CGFloat)collectionView:(UICollectionView *)collectionView resuableHeaderViewHeightForIndexPath:(NSIndexPath *)indexPath;
/** section footer */
- (CGFloat)collectionView:(UICollectionView *)collectionView resuableFooterViewHeightForIndexPath:(NSIndexPath *)indexPath;

@end

@interface WalletCollectionViewLayout : UICollectionViewLayout

@property(nonatomic,weak)id<WalletcollectionViewLayoutDelegate>layout_delegate;
/**左右边距*/
@property(nonatomic, assign) CGFloat padding;
/** 点击item */
- (void)didClickWithIndexPath:(NSIndexPath *)clickIndexPath isExpand:(BOOL)isExpand;
@end

NS_ASSUME_NONNULL_END
