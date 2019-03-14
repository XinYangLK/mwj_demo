//
//  KLMyOrderManagerHeaderView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/15.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyOrderManagerHeaderView.h"

@interface KLMyOrderManagerHeaderView ()
//***  上分割线  **/
@property (nonatomic, strong) UIView  * lineView;
//***  店名  **/
@property (nonatomic, strong) UILabel * titleLab;
//***  下单时间  **/
@property (nonatomic, strong) UILabel * timeLab;
//***  状态  **/
@property (nonatomic, strong) UILabel * statusLab;
//***  下分割线  **/
@property (nonatomic, strong) UIView  * line;

@end


@implementation KLMyOrderManagerHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =[UIColor whiteColor];
        [self configerUI];
    }
    return self;
}

- (void)setStoreName:(NSString *)storeName {
    _storeName = storeName;
    self.titleLab.text = _storeName;
    CGFloat width =[UILabel getWidthWithTitle:self.titleLab.text font:self.titleLab.font];
    CGFloat maxW = MainWidth - AdaptedWidth(185);
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(10);
        make.height.offset =AdaptedHeight(15);
        make.centerY.offset = AdaptedHeight(5);
        make.width.offset = width > maxW ? maxW : width;
    }];
   
}

- (void)setOrderTime:(NSString *)orderTime {
    _orderTime = orderTime;
    self.timeLab.text = _orderTime;
    [self.timeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset = AdaptedWidth(10);
        make.height.centerY.mas_equalTo(self.titleLab);
        make.right.mas_equalTo(self.statusLab.mas_left);
    }];
}

- (void)setOrderStatus:(NSString *)orderStatus {
    _orderStatus = orderStatus;
    self.statusLab.text = _orderStatus;
    [self.statusLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.offset = AdaptedWidth(75);
        make.height.centerY.mas_equalTo(self.titleLab);
        make.right.offset = AdaptedWidth(-11);
    }];
}




#pragma mark - lazy -- UI
- (void)configerUI {
    [self titleLab];
    [self statusLab];
    [self timeLab];
    [self lineView];
    [self line];
}
- (UIView *)lineView {
    if (!_lineView){
        _lineView = [UIView zj_viewWithBackColor:SpacColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.right.top.offset =0;
                                     make.height.offset = AdaptedHeight(5);
                                 }];
    }
    return _lineView;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                         supView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.right.bottom.offset =0;
                                         make.height.offset =0.5;
                                     }];
    }
    return _line;
}



- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:12
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset    = AdaptedWidth(10);
                                          make.height.offset  = AdaptedHeight(15);
                                          make.centerY.offset = 0;
                                          make.width.offset   = MainWidth/2;
                                      }];
    }
    return _titleLab;
}



- (UILabel *)statusLab {
    
    if (!_statusLab){
        _statusLab = [UILabel zj_labelWithFontSize:12
                                         textColor:RedColor
                                         superView:self.contentView
                                       constraints:^(MASConstraintMaker *make) {
                                           make.right.offset =AdaptedWidth(-11);
                                           make.height.offset =AdaptedHeight(15);
                                           make.centerY.mas_equalTo(self.titleLab);
                                           make.width.offset = AdaptedWidth(75);
                                       }];
        _statusLab.textAlignment = NSTextAlignmentRight;
    }
    return _statusLab;
}


- (UILabel *)timeLab {
    if (!_timeLab){
        _timeLab = [UILabel zj_labelWithFontSize:10
                                       textColor:TextColor
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.mas_equalTo(self.titleLab.mas_right).offset = AdaptedWidth(5);
                                         make.height.offset = AdaptedHeight(15);
                                         make.centerY.mas_equalTo(self.titleLab);
                                         make.right.mas_equalTo(self.statusLab.mas_left).offset  = AdaptedWidth(-5);
                                     }];
        _timeLab.textAlignment = NSTextAlignmentRight;
    }
    return _timeLab;
}



@end
