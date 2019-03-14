//
//  KLMyOrderResultsReusableView.m
//  mwstreet
//
//  Created by 科pro on 2019/2/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyOrderResultsReusableView.h"

@implementation KLMyOrderResultsReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MainColor;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    [self statusBtn];
    [self backBtn];
    [self lookBtn];
    [self titleLab];
}


- (UIButton *)statusBtn {
    if (!_statusBtn){
        _statusBtn = [UIButton createBtnTitle:@"支付成功"
                                   titleColor:[UIColor whiteColor]
                                         font:AdaptedSYSFontSize(20)
                                    imageName:@"chenggduihuan"
                               backgrounColor:[UIColor clearColor]
                          SSImagePositionType:SSImagePositionTypeLeft
                                      spacing:0
                                       action:^(UIButton * _Nonnull button) {
                                           
                                       }];
        self.statusBtn.userInteractionEnabled = NO;
        [self addSubview:_statusBtn];
        [_statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset = AdaptedHeight(20);
            make.centerX.offset = 0;
            make.height.offset = AdaptedHeight(20);
            make.width.offset =AdaptedWidth(150);
        }];
    }
    return _statusBtn;
}

- (UIButton *)backBtn {
    if (!_backBtn){
        @weakify(self)
        _backBtn = [UIButton zj_buttonWithTitle:@"返回首页"
                                     titleColor:[UIColor whiteColor]
                                       norImage:nil
                                  selectedImage:nil
                                      backColor:[UIColor clearColor]
                                       fontSize:14
                                         isBold:NO
                                    borderWidth:0.5
                                    borderColor:[UIColor whiteColor]
                                   cornerRadius:AdaptedHeight(15)
                                        supView:self
                                    constraints:^(MASConstraintMaker *make) {
                                        make.left.offset = AdaptedWidth(68);
                                        make.height.offset =AdaptedHeight(30);
                                        make.width.offset = AdaptedWidth(95);
                                        make.bottom.offset = AdaptedHeight(-83);
                                    } touchUp:^(id sender) {
                                        @strongify(self)
                                        self.btnBlock? self.btnBlock(sender) :nil;
                                    }];
        _backBtn.tag = 20;
    }
    return _backBtn;
}

- (UIButton *)lookBtn {
    if (!_lookBtn){
        @weakify(self)
        _lookBtn = [UIButton zj_buttonWithTitle:@"查看订单"
                                     titleColor:[UIColor whiteColor]
                                       norImage:nil
                                  selectedImage:nil
                                      backColor:[UIColor clearColor]
                                       fontSize:14
                                         isBold:NO
                                    borderWidth:0.5
                                    borderColor:[UIColor whiteColor]
                                   cornerRadius:AdaptedHeight(15)
                                        supView:self
                                    constraints:^(MASConstraintMaker *make) {
                                        make.right.offset = AdaptedWidth(-68);
                                        make.width.bottom.height.mas_equalTo(self.backBtn);
                                    } touchUp:^(id sender) {
                                        @strongify(self)
                                        self.btnBlock? self.btnBlock(sender) :nil;
                                    }];
        _lookBtn.tag = 21;
    }
    return _lookBtn;
}


- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:15
                                            lines:1
                                             text:@"猜你喜欢"
                                        textColor:RGBSigle(51)
                                        superView:self
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.bottom.right.offset = 0;
                                          make.height.offset =AdaptedHeight(50);
                                      }];
        _titleLab.backgroundColor =[UIColor whiteColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

@end
