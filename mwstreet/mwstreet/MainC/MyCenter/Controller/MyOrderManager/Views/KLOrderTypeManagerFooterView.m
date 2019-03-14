//
//  KLOrderTypeManagerFooterView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/15.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLOrderTypeManagerFooterView.h"

@interface KLOrderTypeManagerFooterView ()


@property (nonatomic, strong) UIView   * lineView;

@end


@implementation KLOrderTypeManagerFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = RGBSigle(255);
        [self configerUI];
    }
    return self;
}


- (void)setLeftText:(NSString *)leftText {
    
    _leftText = leftText;
    [self.leftBtn setTitle:_leftText forState:UIControlStateNormal];
    
}
- (void)setRightText:(NSString *)rightText {
    
    _rightText = rightText;
    [self.rightBtn setTitle:_rightText forState:UIControlStateNormal];

}


#pragma mark - lazy -- UI
- (void)configerUI {
    [self rightBtn];
    [self leftBtn];
    [self desLab];
    [self line];
    [self lineView];
}


- (UIButton *)rightBtn {
    if (!_rightBtn){
        _rightBtn = [UIButton zj_buttonWithTitle:self.rightText
                                    titleColor:RedColor
                                      norImage:nil
                                 selectedImage:nil
                                     backColor:[UIColor clearColor]
                                      fontSize:12
                                        isBold:NO
                                   borderWidth:0.5
                                   borderColor:RedColor
                                  cornerRadius:5
                                       supView:self.contentView
                                   constraints:^(MASConstraintMaker *make) {
                                       make.right.offset  = AdaptedWidth(-12);
                                       make.height.offset = AdaptedHeight(25);
                                       make.width.offset  = AdaptedWidth(70);
                                       make.top.offset    = AdaptedHeight(9);
                                   } touchUp:^(id sender) {
                                       
                                       if (self.delegate && [self.delegate respondsToSelector:@selector(didGoPayBtnChick:Section:)]) {
                                           [self.delegate didGoPayBtnChick:self Section:self.section];
                                       }
                                   }];
    }
    return _rightBtn;
}


- (UIButton *)leftBtn {
    if (!_leftBtn){
        _leftBtn = [UIButton zj_buttonWithTitle:self.leftText
                                    titleColor:TextColor
                                      norImage:nil
                                 selectedImage:nil
                                     backColor:[UIColor clearColor]
                                      fontSize:12
                                        isBold:NO
                                   borderWidth:0.5
                                   borderColor:TextColor
                                  cornerRadius:5
                                       supView:self.contentView
                                   constraints:^(MASConstraintMaker *make) {
                                       make.right.mas_equalTo(self.rightBtn.mas_left).offset  = AdaptedWidth(-13);
                                       make.height.offset = AdaptedHeight(25);
                                       make.width.offset  = AdaptedWidth(70);
                                       make.top.offset    = AdaptedHeight(9);
                                   } touchUp:^(id sender) {
                                       
                                       if (self.delegate && [self.delegate respondsToSelector:@selector(didGoPayBtnChick:Section:)]) {
                                           [self.delegate didGoPayBtnChick:self Section:self.section];
                                       }
                                   }];
    }
    return _leftBtn;
}


- (UILabel *)desLab {
    if (!_desLab){
        _desLab = [UILabel zj_labelWithFontSize:10
                                          lines:1
                                           text:@"30分钟之内付款"
                                      textColor:TextColor
                                      superView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.right.mas_equalTo(self.rightBtn.mas_left).offset =AdaptedWidth(-10);
                                        make.height.offset = AdaptedHeight(15);
                                        make.centerY.mas_equalTo(self.rightBtn);
                                        make.left.offset = AdaptedWidth(30);
                                    }];
        _desLab.textAlignment = NSTextAlignmentRight;
    }
    return _desLab;
}

- (UIView *)lineView {
    if (!_lineView){
        _lineView = [UIView zj_viewWithBackColor:SpacColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.height.offset =AdaptedHeight(5);
                                     make.left.right.bottom.offset = 0;
                                 }];
    }
    return _lineView;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.height.offset =0.5;
                                     make.left.right.top.offset = 0;
                                 }];
    }
    return _line;
    
}


@end
