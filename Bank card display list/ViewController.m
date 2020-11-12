//
//  ViewController.m
//  Bank card display list
//
//  Created by rockfintech on 2020/11/12.
//
#import "Masonry.h"
#import "WalletViewController.h"
#import "WalletCollectionViewCell.h"
#import "WalletCollectionViewLayout.h"
#import "WalletCollCollectionReusableView.h"
#import "ViewController.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, WalletcollectionViewLayoutDelegate>
@property(nonatomic, strong) WalletCollectionViewLayout *wallet_layout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.equalTo(self.view);
        }
    }];
    
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self handleDatas];
  
}
- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        self.wallet_layout = [[WalletCollectionViewLayout alloc] init];
        self.wallet_layout.padding = 15;
        self.wallet_layout.layout_delegate = self;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.wallet_layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //cell
        [_collectionView registerClass:[WalletCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass(WalletCollectionViewCell.class)];
        
//        //header
//        [_collectionView registerClass:[WalletCollCollectionReusableView class] forSupplementaryViewOfKind:TMSCollectionViewSectionHeader withReuseIdentifier:NSStringFromClass(WalletCollCollectionReusableView.class)];
//        //footer
//        [_collectionView registerClass:[WalletCollCollectionReusableView class] forSupplementaryViewOfKind:TMSCollectionViewSectionFooter withReuseIdentifier:NSStringFromClass(WalletCollCollectionReusableView.class)];
        
    }
    return _collectionView;
}

#pragma collectionView

- (CGFloat)collectionView:(UICollectionView *)collectionView resuableHeaderViewHeightForIndexPath:(NSIndexPath *)indexPath {
    /**这里因为项目不需要头尾，就设置为0，如有需要，修改高度即可*/
    return indexPath.section == 0 ? 0.1 : 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView resuableFooterViewHeightForIndexPath:(NSIndexPath *)indexPath {
    
    return 0.1;
}

//数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *sectionArray = self.dataSource[section];
    return sectionArray.count;
}

//头部，尾部View的展示
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//    WalletCollCollectionReusableView *reusableView = nil;
//
//    reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(WalletCollCollectionReusableView.class) forIndexPath:indexPath];
//
//    if (kind == TMSCollectionViewSectionHeader) {
//
//        [reusableView setReusableViewTitle:[NSString stringWithFormat:@"Section Header:%zd-%zd", indexPath.section, indexPath.item]];
//    }
//
//    if (kind == TMSCollectionViewSectionFooter) {
//
//        [reusableView setReusableViewTitle:[NSString stringWithFormat:@"Section Footer:%zd-%zd", indexPath.section, indexPath.item]];
//    }
//
//    return reusableView;
//}

//cell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WalletCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(WalletCollectionViewCell.class) forIndexPath:indexPath];
    
    TMSWalletModel *model = self.dataSource[indexPath.section][indexPath.item];
    cell.titleLabel.text = [NSString stringWithFormat:@"indexPath:%zd--%zd selected:%@", indexPath.section, indexPath.row , model.isSelected ? @"YES" : @"NO"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.dataSource enumerateObjectsUsingBlock:^(NSArray *sectionArray, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [sectionArray enumerateObjectsUsingBlock:^(TMSWalletModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (indexPath.item != idx) {
                model.isSelected = NO;
            } else {
                model.isSelected = !model.isSelected;
                if (indexPath.item != sectionArray.count - 1) {
                    [self.wallet_layout didClickWithIndexPath:indexPath isExpand:model.isSelected];
                } else {
                    [self.wallet_layout didClickWithIndexPath:indexPath isExpand:NO];
                }
            }
        }];
    }];
    
    [collectionView reloadData];
    
}

- (void)handleDatas {
    
    self.dataSource = [NSMutableArray array];
    for (NSInteger i = 0; i < 1; i ++) {
        
        NSMutableArray *tempDataSource = [NSMutableArray array];
        
        NSInteger maxCount = i == 0 ? 6 : 4;
        for (NSInteger j = 0 ; j < maxCount; j++) {
            TMSWalletModel *model = [[TMSWalletModel alloc] init];
            [tempDataSource addObject:model];
        }
        [self.dataSource addObject:tempDataSource.copy];
    }
    
    [self.collectionView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end





