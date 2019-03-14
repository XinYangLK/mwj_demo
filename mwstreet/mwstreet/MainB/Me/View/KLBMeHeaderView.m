//
//  KLBMeHeaderView.m
//  mwstreet
//
//  Created by 科pro on 2019/2/26.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBMeHeaderView.h"

@implementation KLBMeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI {
    [self backImg];
    [self accoutImg];
}

- (UIImageView *)backImg {
    if (!_backImg){
        _backImg =[[UIImageView alloc]initWithFrame:self.frame];
        _backImg.image =[UIImage imageNamed:@"bjtututu"];
        _backImg.clipsToBounds = YES;//删除多余图片。（不加这个得话。第一行被遮盖)
        [self addSubview:_backImg];
    }
    return _backImg;
}

- (UIImageView *)accoutImg {
    if (!_accoutImg){
        _accoutImg = [UIImageView zj_imageViewWithImage:@"touxiang"
                                              SuperView:self.backImg
                                            constraints:^(MASConstraintMaker *make) {
                                                make.centerX.offset = 0;
                                                make.bottom.offset =AdaptedHeight(-5);
                                                make.height.width.offset =AdaptedHeight(52);
                                            }];
        [_accoutImg setLayerCornerRadius:AdaptedHeight(26) borderWidth:2 borderColor:[UIColor whiteColor]];
    }
    return _accoutImg;
}

@end
