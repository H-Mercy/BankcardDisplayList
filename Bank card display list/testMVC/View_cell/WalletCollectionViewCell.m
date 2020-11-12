//
//  WalletCollectionViewCell.m
//  HomeGoods
//
//  Created by rockfintech on 2020/11/12.
//  Copyright © 2020 mercy. All rights reserved.
//
#import "Masonry.h"
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#import "WalletCollectionViewCell.h"

@implementation WalletCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.contentView.backgroundColor = randomColor;
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@10);
        }];
    }
    return self;
}

- (void)bindModel:(TMSWalletModel *)model {
    
    _model = model;
}

@end

@implementation TMSWalletModel


@end
