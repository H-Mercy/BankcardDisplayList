//
//  WalletCollectionViewCell.h
//  HomeGoods
//
//  Created by rockfintech on 2020/11/12.
//  Copyright © 2020 kedll. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface TMSWalletModel : NSObject
@property(nonatomic, assign) BOOL isSelected;
@end
@interface WalletCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong,readonly) TMSWalletModel *model;
- (void)bindModel:(TMSWalletModel *)model;
@end

NS_ASSUME_NONNULL_END
