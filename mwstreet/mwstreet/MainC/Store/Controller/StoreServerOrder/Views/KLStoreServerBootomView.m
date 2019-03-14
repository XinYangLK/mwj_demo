//
//  KLStoreServerBootomView.m
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreServerBootomView.h"

@implementation KLStoreServerBootomView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI {
    [self line];
    [self titleLab];
    [self confirmBtn];
}


- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.top.right.offset = 0;
                                     make.height.offset = 0.5f;
                                 }];
    }
    return _line;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(51)
                                        superView:self
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset   = AdaptedWidth(20);
                                          make.right.offset  = AdaptedWidth(-120);
                                          make.top.offset    = AdaptedHeight(18);
                                          make.height.offset = AdaptedHeight(15);
                                      }];
    }
    return _titleLab;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn){
        @weakify(self)
        _confirmBtn = [UIButton zj_buttonWithTitle:@"确定" titleColor:RGBSigle(255)
                                         backColor:MainColor
                                          fontSize:14
                                            isBold:NO
                                      cornerRadius:AdaptedHeight(15)
                                           supView:self
                                       constraints:^(MASConstraintMaker *make) {
                                           make.right.offset =AdaptedWidth(-10);
                                           make.height.offset =AdaptedHeight(30);
                                           make.centerY.mas_equalTo(self.titleLab);
                                           make.width.offset =AdaptedWidth(95);
                                          } touchUp:^(id sender) {
                                              @strongify(self)
                                              self.confirmBlock ? self.confirmBlock(sender) : nil;
                                          }];
    }
    return _confirmBtn;
}

@end
