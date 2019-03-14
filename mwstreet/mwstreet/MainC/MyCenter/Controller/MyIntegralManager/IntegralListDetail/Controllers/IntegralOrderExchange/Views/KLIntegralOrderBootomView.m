//
//  KLIntegralOrderBootomView.m
//  mwstreet
//
//  Created by 科pro on 2019/2/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLIntegralOrderBootomView.h"

@interface KLIntegralOrderBootomView ()
@property (nonatomic, strong) UIView *line;

@end

@implementation KLIntegralOrderBootomView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self line];
        [self titleLab];
        [self confirmBtn];
    }
    return self;
}
- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:BackgroundColor supView:self
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.right.top.offset = 0;
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
                                          make.left.offset   = AdaptedWidth(15);
                                          make.right.offset  = AdaptedWidth(-115);
                                          make.top.offset    = AdaptedHeight(16);
                                          make.height.offset = AdaptedHeight(15);
                                      }];
    }
    return _titleLab;
}


- (UIButton *)confirmBtn {
    if (!_confirmBtn){
        @weakify(self)
        _confirmBtn = [UIButton zj_buttonWithTitle:@"提交"
                                        titleColor:[UIColor whiteColor]
                                         backColor:MainColor
                                          fontSize:14
                                            isBold:NO
                                      cornerRadius:0
                                           supView:self
                                       constraints:^(MASConstraintMaker *make) {
                                           make.top.right.offset = 0;
                                           make.bottom.offset = (kDevice_Is_iPhoneX) ? -TabbarSafeBottomMargin:0;
                                           make.width.offset = AdaptedWidth(100);
                                       } touchUp:^(id sender) {
                                         @strongify(self)
                                           self.confirmBlock ? self.confirmBlock(sender) : nil;
                                       }];
    }
    return _confirmBtn;
}

@end
