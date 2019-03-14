//
//  KLTableFooterView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLTableFooterView.h"

@implementation KLTableFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self addSubview:self.line];
        [self addSubview:self.footerBtn];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.offset =0;
            make.height.offset = 0.5;
        }];
        
        [self.footerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = MainWidth - AdaptedWidth(90);
            make.height.offset = AdaptedHeight(34);
            make.centerX.offset = 0;
            make.top.offset =AdaptedHeight(35);
        }];
    }
    return self;
}

-(UIView *)line {
    if (!_line){
        _line = [[UIView alloc]init];
        _line.backgroundColor = LineColor;
        _line.hidden =YES;
    }
    return _line;
}

- (UIButton *)footerBtn {
    if (!_footerBtn){
        _footerBtn = [[UIButton alloc]init];
        [_footerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_footerBtn setBackgroundImage:[UIImage imageWithColor:MainColor] forState:UIControlStateNormal];
        _footerBtn.titleLabel.font = kFont_15;
        [_footerBtn setLayerCornerRadius:AdaptedHeight(16.5)];
    }
    return _footerBtn;
}


@end
