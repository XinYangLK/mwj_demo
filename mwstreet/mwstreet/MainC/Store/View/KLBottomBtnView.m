//
//  KLBottomBtnView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/4.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBottomBtnView.h"

@implementation KLBottomBtnView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bottomBtn];
        self.backgroundColor = SpacColor;
        
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.offset =0;
            make.bottom.offset =(kDevice_Is_iPhoneX) ? -34 : 0;
        }];
        
    }
    return self;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn){
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setBackgroundImage:[UIImage imageWithColor:MainColor] forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font =kFont_14;
    }
    return _bottomBtn;
}






@end
