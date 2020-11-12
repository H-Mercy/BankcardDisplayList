//
//  WalletCollectionViewLayout.m
//  HomeGoods
//
//  Created by rockfintech on 2020/11/12.
//  Copyright © 2020 kedll. All rights reserved.
//
#define appWidth CGRectGetWidth([[UIScreen mainScreen] bounds])
#import "WalletCollectionViewLayout.h"
NSString * const TMSCollectionViewSectionHeader = @"NTCollectionViewSectionHeader";
NSString * const TMSCollectionViewSectionFooter = @"NTCollectionViewSectionFooter";
//cell的高度
static CGFloat const itemH = 150;
// 被遮盖的cell头部留出的距离
static CGFloat const itemInnerInset = 65;


@interface WalletCollectionViewLayout()

@property(nonatomic,strong)NSMutableArray * attrubutesArray;
/** 点击的item */
@property(nonatomic, strong) NSIndexPath *clickIndexPath;
/** 是否展开 */
@property(nonatomic, assign) BOOL isExpand;
@end

@implementation WalletCollectionViewLayout

-(void)prepareLayout {
    [super prepareLayout];
    /**数据初始化*/
    self.attrubutesArray = [[NSMutableArray alloc]init];
    
    NSInteger section = [self.collectionView numberOfSections];
    
    /**head,foot*/
    //head
    for (NSInteger i=0; i<section; i++) {
        NSInteger itemsCount = [self.collectionView numberOfItemsInSection:i];
        
        UICollectionViewLayoutAttributes *headerAttributes = [self layoutAttributesForSupplementaryViewOfKind:TMSCollectionViewSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
        
        if (headerAttributes) {
            [self.attrubutesArray addObject:headerAttributes];
        }
        //foot
        for (NSInteger j = 0; j < itemsCount; j++) {
            
            NSIndexPath * indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            
            UICollectionViewLayoutAttributes * attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attrubutesArray addObject:attributes];
        }
        
        UICollectionViewLayoutAttributes *footerAttributes = [self layoutAttributesForSupplementaryViewOfKind:TMSCollectionViewSectionFooter atIndexPath:[NSIndexPath indexPathForRow:itemsCount - 1 inSection:i]];
        
        if (footerAttributes) {
            [self.attrubutesArray addObject:footerAttributes];
        }
        
        
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    UICollectionViewLayoutAttributes *lastAttributes = self.attrubutesArray.lastObject;
    
    attribute.zIndex = indexPath.item*2;//默认的
    
    //布局
    CGRect frame;
    frame.size = CGSizeMake(appWidth-(self.padding*2), itemH);
    //位移，显示头部，其他部分遮挡
    CGFloat offfsetY = indexPath.item == 0 ? 0 : itemInnerInset;
    /**展开折叠的高度计算*/
    CGFloat expandH = (self.isExpand && self.clickIndexPath && self.clickIndexPath.section == indexPath.section && self.clickIndexPath.item + 1 == indexPath.item) ? -10 : offfsetY;
    
    frame.origin = CGPointMake(self.padding, CGRectGetMaxY(lastAttributes.frame) - expandH);
    attribute.frame = frame;
    
    return attribute;
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    UICollectionViewLayoutAttributes *lastAttributes = self.attrubutesArray.lastObject;
    
    CGRect frame;
    
    /**head*/
    if([elementKind isEqual:TMSCollectionViewSectionHeader]){
        
        CGFloat headerViewH = [self.layout_delegate collectionView:self.collectionView resuableHeaderViewHeightForIndexPath:indexPath];
        
        if (headerViewH <= 0) {
            return nil;
        }
        
        frame.size = CGSizeMake(appWidth, headerViewH);
        
    } else {
        
        CGFloat footerViewH = [self.layout_delegate collectionView:self.collectionView resuableFooterViewHeightForIndexPath:indexPath];
        
        if (footerViewH <= 0) {
            return nil;
        }
        
        frame.size = CGSizeMake(appWidth, footerViewH);
        
    }
    frame.origin = CGPointMake(0, CGRectGetMaxY(lastAttributes.frame));
    
    attributes.frame = frame;
    
    return attributes;
}

- (CGSize)collectionViewContentSize {
    
    UICollectionViewLayoutAttributes *attribute = self.attrubutesArray.lastObject;
    
    CGFloat safeAreaBottom = 0;
    if (@available(iOS 11.0, *)) {
        safeAreaBottom = self.collectionView.safeAreaInsets.bottom;
    }
    
    return CGSizeMake(appWidth, CGRectGetMaxY(attribute.frame) + 5 + safeAreaBottom);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.attrubutesArray;
}

- (void)didClickWithIndexPath:(NSIndexPath *)clickIndexPath isExpand:(BOOL)isExpand {
    
    self.isExpand = isExpand;
    self.clickIndexPath = self.isExpand ? clickIndexPath : nil;
    
    [UIView transitionWithView:self.collectionView duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self invalidateLayout];
    } completion:nil];
    
}
@end
