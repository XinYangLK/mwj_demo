//
//  KLBrandCollectionViewCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/21.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBrandCollectionViewCell.h"

@implementation KLBrandCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self configerUI];
    }
    return self;
}

- (void)configerUI {
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.brandImg];
    [self.contentView addSubview:self.brandLab];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset = 0;
        make.height.offset =AdaptedHeight(42);
    }];
   
    [self.brandImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.top.offset =AdaptedHeight(7);
        make.height.offset =AdaptedHeight(28);
    }];
    [self.brandLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset =AdaptedHeight(15);
        make.top.mas_equalTo(self.brandImg.mas_bottom).offset =AdaptedHeight(13);
        make.left.offset =AdaptedWidth(5);
        make.right.offset =AdaptedWidth(-5);
    }];
}

- (UIView *)backView {
    if (!_backView){
        _backView = [[UIView alloc]init];
        [_backView setLayerCornerRadius:4 borderWidth:0.5 borderColor:LineColor];
    }
    return _backView;
}

-(UIImageView *)brandImg {
    if (!_brandImg){
        _brandImg = [[UIImageView alloc]init];
        _brandImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _brandImg;
}

- (UILabel *)brandLab {
    if (!_brandLab){
        _brandLab = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_14];
        _brandLab.textAlignment = NSTextAlignmentCenter;
    }
    return _brandLab;
}

@end
