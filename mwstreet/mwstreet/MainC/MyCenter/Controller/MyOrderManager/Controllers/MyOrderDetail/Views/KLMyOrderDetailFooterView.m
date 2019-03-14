//
//  KLMyOrderDetailFooterView.m
//  mwstreet
//
//  Created by 科pro on 2019/2/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyOrderDetailFooterView.h"

@implementation KLMyOrderDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self rightBtn];
        [self centerBtn];
        [self leftBtn];
    }
    return self;
}

- (UIButton *)rightBtn {
    if (!_rightBtn){
        @weakify(self)
        _rightBtn = [UIButton zj_buttonWithTitle:nil
                                     titleColor:RGBSigle(51)
                                       norImage:nil
                                  selectedImage:nil
                                      backColor:[UIColor clearColor]
                                       fontSize:14
                                         isBold:NO
                                    borderWidth:0.5
                                    borderColor:LineColor
                                   cornerRadius:5
                                        supView:self
                                    constraints:^(MASConstraintMaker *make) {
                                        make.right.offset   = AdaptedWidth(-15);
                                        make.height.offset  = AdaptedHeight(36);
                                        make.width.offset   = AdaptedWidth(84);
                                        make.centerY.offset = 0 ;
                                    } touchUp:^(id sender) {
                                        @strongify(self)
                                        self.bootomBlock ? self.bootomBlock(sender) : nil;
                                    }];
        _rightBtn.tag = 10;
    }
    return _rightBtn;
    
}

- (UIButton *)centerBtn {
    if (!_centerBtn){
        @weakify(self)
        _centerBtn = [UIButton zj_buttonWithTitle:nil
                                     titleColor:RGBSigle(51)
                                       norImage:nil
                                  selectedImage:nil
                                      backColor:[UIColor clearColor]
                                       fontSize:14
                                         isBold:NO
                                    borderWidth:0.5
                                    borderColor:LineColor
                                   cornerRadius:5
                                        supView:self
                                    constraints:^(MASConstraintMaker *make) {
                                        make.right.mas_equalTo(self.rightBtn.mas_left).offset   = AdaptedWidth(-15);
                                        make.width.centerY.height.mas_equalTo(self.rightBtn);
                                    } touchUp:^(id sender) {
                                        @strongify(self)
                                        self.bootomBlock ? self.bootomBlock(sender) : nil;
                                    }];
         _centerBtn.tag = 11;
    }
    return _centerBtn;
    
}



- (UIButton *)leftBtn {
    if (!_leftBtn){
        @weakify(self)
        _leftBtn = [UIButton zj_buttonWithTitle:nil
                                     titleColor:RGBSigle(51)
                                       norImage:nil
                                  selectedImage:nil
                                      backColor:[UIColor clearColor]
                                       fontSize:14
                                         isBold:NO
                                    borderWidth:0.5
                                    borderColor:LineColor
                                   cornerRadius:5
                                        supView:self
                                    constraints:^(MASConstraintMaker *make) {
                                        make.right.mas_equalTo(self.centerBtn.mas_left).offset   = AdaptedWidth(-15);
                                        make.width.centerY.height.mas_equalTo(self.rightBtn);
                                    } touchUp:^(id sender) {
                                        @strongify(self)
                                        self.bootomBlock ? self.bootomBlock(sender) : nil;
                                    }];
        _leftBtn.tag = 12;
    }
    return _leftBtn;
}



@end
