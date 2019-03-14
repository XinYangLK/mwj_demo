//
//  KLPlaceOrderGoodsHeaderView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/16.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLPlaceOrderGoodsHeaderView.h"

@interface KLPlaceOrderGoodsHeaderView ()

@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UIView  * line;

@end

@implementation KLPlaceOrderGoodsHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =[UIColor whiteColor];
        [self titleLab];
        [self line];
    }
    return self;
}

- (void)setHeaderTitle:(NSString *)headerTitle {
    _headerTitle =headerTitle;
    self.titleLab.text = _headerTitle;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.right.bottom.offset =0;
                                     make.height.offset = 0.5;
                                 }];
    }
    return _line;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(10);
                                          make.height.offset =AdaptedHeight(15);
                                          make.right.offset =AdaptedWidth(-20);
                                          make.bottom.offset =AdaptedHeight(-10);
                                      }];
    }
    return _titleLab;
}

@end
