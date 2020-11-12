//
//  WalletCollCollectionReusableView.m
//  HomeGoods
//
//  Created by rockfintech on 2020/11/12.
//  Copyright © 2020 kedll. All rights reserved.
//
#import "Masonry.h"
#import "WalletCollCollectionReusableView.h"
@interface WalletCollCollectionReusableView ()
@property(nonatomic, strong) UILabel *label;
@end
@implementation WalletCollCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

- (void)setReusableViewTitle:(NSString *)title {
    
    self.label.text = title;
}
@end
