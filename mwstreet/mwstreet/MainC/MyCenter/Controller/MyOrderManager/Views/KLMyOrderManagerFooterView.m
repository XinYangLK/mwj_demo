//
//  KLMyOrderManagerFooterView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/15.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyOrderManagerFooterView.h"
@interface KLMyOrderManagerFooterView ()

@property (nonatomic, strong) UILabel  * totalLab;
@property (nonatomic, strong) UIView   * line;

@end


@implementation KLMyOrderManagerFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =[UIColor whiteColor];
        [self configerUI];
    }
    return self;
}

- (void)setTotalDes:(NSString *)totalDes {
    _totalDes = totalDes;
    self.totalLab.text = _totalDes;
}

- (void)setRightText:(NSString *)rightText {
    _rightText = rightText;
    [self.rightBtn setTitle:_rightText forState:UIControlStateNormal];
}

- (void)setCenterText:(NSString *)centerText {
    _centerText = centerText;
    [self.centerBtn setTitle:_centerText forState:UIControlStateNormal];

}

- (void)setLeftText:(NSString *)leftText {
    _leftText = leftText;
    [self.leftBtn setTitle:_leftText forState:UIControlStateNormal];

}






#pragma mark - lazy -- UI
- (void)configerUI {
    [self totalLab];
    [self line];
    [self rightBtn];
    [self centerBtn];
    [self leftBtn];
}

- (UILabel *)totalLab {
    if (!_totalLab){
        _totalLab = [UILabel zj_labelWithFontSize:10
                                        textColor:TextColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.right.offset =AdaptedWidth(-11);
                                          make.height.offset =AdaptedHeight(15);
                                          make.top.offset = 0;
                                          make.left.offset =AdaptedWidth(15);
                                      }];
        _totalLab.textAlignment = NSTextAlignmentRight;
    }
    return _totalLab;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.right.offset =0;
                                     make.height.offset = 0.5;
                                     make.top.mas_equalTo(self.totalLab.mas_bottom).offset =AdaptedHeight(7);
                                 }];
    }
    return _line;
}

- (UIButton *)rightBtn {
    if (!_rightBtn){
        @weakify(self)
        _rightBtn = [UIButton zj_buttonWithTitle:self.rightText
                                      titleColor:RedColor
                                        norImage:nil
                                   selectedImage:nil
                                       backColor:[UIColor whiteColor]
                                        fontSize:12
                                          isBold:NO
                                     borderWidth:1
                                     borderColor:RedColor
                                    cornerRadius:5
                                         supView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.right.offset  = AdaptedWidth(-11);
                                         make.width.offset  = AdaptedWidth(65);
                                         make.height.offset =AdaptedHeight(25);
                                         make.top.mas_equalTo(self.line.mas_bottom).offset =AdaptedHeight(13);
                                     } touchUp:^(id sender) {
                                        @strongify(self)
                                        self.sectionBtnBlock ? self.sectionBtnBlock(sender, self.section) : nil;
                                     }];
        _rightBtn.tag = 100;
    }
    return _rightBtn;
}

- (UIButton *)centerBtn {
    if (!_centerBtn){
        @weakify(self)
        _centerBtn = [UIButton zj_buttonWithTitle:self.centerText
                                      titleColor:TextColor
                                        norImage:nil
                                   selectedImage:nil
                                       backColor:[UIColor whiteColor]
                                        fontSize:12
                                          isBold:NO
                                     borderWidth:1
                                     borderColor:TextColor
                                    cornerRadius:5
                                         supView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.right.mas_equalTo(self.rightBtn.mas_left).offset = AdaptedWidth(-13);
                                         make.width.height.centerY.mas_equalTo(self.rightBtn);
                                     } touchUp:^(id sender) {
                                         @strongify(self)
                                         self.sectionBtnBlock ? self.sectionBtnBlock(sender, self.section) : nil;
                                     }];
         _centerBtn.tag = 200;
    }
    return _centerBtn;
}

- (UIButton *)leftBtn {
    if (!_leftBtn){
         @weakify(self)
        _leftBtn = [UIButton zj_buttonWithTitle:self.leftText
                                      titleColor:TextColor
                                        norImage:nil
                                   selectedImage:nil
                                       backColor:[UIColor whiteColor]
                                        fontSize:12
                                          isBold:NO
                                     borderWidth:1
                                     borderColor:TextColor
                                    cornerRadius:5
                                         supView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.right.mas_equalTo(self.centerBtn.mas_left).offset = AdaptedWidth(-13);
                                         make.width.height.centerY.mas_equalTo(self.rightBtn);
                                     } touchUp:^(id sender) {
                                         
                                         @strongify(self)
                                         self.sectionBtnBlock ? self.sectionBtnBlock(sender, self.section) : nil;
                                     }];
         _leftBtn.tag = 300;
    }
    return _leftBtn;
}




@end
