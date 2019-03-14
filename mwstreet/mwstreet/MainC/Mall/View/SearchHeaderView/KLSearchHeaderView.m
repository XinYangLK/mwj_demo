//
//  KLSearchHeaderView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/21.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLSearchHeaderView.h"

@implementation KLSearchHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self configerUI];
    }
    return self;
}


- (void)configerUI {
    [self titleLab];
    [self addSubview:self.delectBtn];
    [self.delectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset =AdaptedWidth(-10);
        make.centerY.height.mas_equalTo(self.titleLab);
        make.width.offset =AdaptedWidth(100);
    }];
}


- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(51)
                                        superView:self
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(10);
                                          make.height.offset =AdaptedHeight(15);
                                          make.centerY.offset =0;
                                          make.width.offset =(MainWidth-AdaptedWidth(30))/2;
                                      }];
    }
    return _titleLab;
}

- (UIButton *)delectBtn {
    if (!_delectBtn){
        klWeakSelf;
        _delectBtn = [UIButton createBtnTitle:@"清除最近搜素" titleColor:TextColor font:AdaptedSYSFontSize(12) imageName:@"degghgh" backgrounColor:[UIColor clearColor] SSImagePositionType:SSImagePositionTypeLeft spacing:4 action:^(UIButton * _Nonnull button) {
            weakSelf.delectAllBlock(button);
        }];
    }
    return _delectBtn;
}

@end
