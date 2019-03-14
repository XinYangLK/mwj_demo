//
//  KLPlaceOrderGoodsFooterView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/16.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLPlaceOrderGoodsFooterView.h"
@interface KLPlaceOrderGoodsFooterView ()

@property (nonatomic, strong) UIImageView *lineImg;

@end

@implementation KLPlaceOrderGoodsFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self lineImg];
    }
    return self;
}

- (UIImageView *)lineImg {
    if (!_lineImg){
        _lineImg = [UIImageView zj_imageViewWithImage:@"egs"
                                            SuperView:self.contentView
                                          constraints:^(MASConstraintMaker *make) {
                                              make.left.right.top.offset =0;
                                              make.height.offset =AdaptedHeight(5);
                                          }];
    }
    return _lineImg;
}

@end
