//
//  KLCellHeaderView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLCellHeaderView.h"

@interface KLCellHeaderView ()

@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UILabel * textLab;
@property (nonatomic, strong) UILabel * targetTitleLab;
@property (nonatomic, strong) UILabel * targetTextLab;

@property (nonatomic, strong) UIImageView *leftLine;
@property (nonatomic, strong) UIImageView *rightLine;
@property (nonatomic, strong) UILabel * friendTitle;

@end

@implementation KLCellHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        [self configerUI];
    }
    return self;
}

- (void)setPriceStr:(NSString *)priceStr{
    _priceStr = priceStr;
    self.textLab.text =_priceStr;
}
- (void)setTargetPriceStr:(NSString *)targetPriceStr {
    _targetPriceStr = targetPriceStr;
    self.targetTextLab.text =_targetPriceStr;
}

#pragma mark - lazy UI
- (void)configerUI {
    
    [self titleLab];
    [self textLab];
    [self targetTitleLab];
    [self targetTextLab];
    [self sliderBackView];
    [self sliderShowView];
    [self showAngle];
    [self showLable];
    [self leftLine];
    [self rightLine];
    [self friendTitle];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:10
                                        textColor:RGBSigle(51)
                                        superView:self
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(13);
                                          make.top.offset =AdaptedHeight(10);
                                          make.height.offset =AdaptedHeight(14);
                                          make.width.offset =AdaptedWidth(100);
                                      }];
        _titleLab.text =@"市场价";
    }
    return _titleLab;
}
- (UILabel *)textLab {
    if (!_textLab){
        _textLab = [UILabel zj_labelWithFontSize:10
                                       textColor:RGBSigle(51)
                                       superView:self
                                     constraints:^(MASConstraintMaker *make) {
                                         make.top.mas_equalTo(self.titleLab.mas_bottom).offset =AdaptedHeight(3);
                                         make.left.width.height.mas_equalTo(self.titleLab);
                                     }];
    }
    return _textLab;
}

- (UILabel *)targetTitleLab {
    if (!_targetTitleLab){
        _targetTitleLab = [UILabel zj_labelWithFontSize:10
                                              textColor:RedColor
                                              superView:self
                                            constraints:^(MASConstraintMaker *make) {
                                                make.right.offset =AdaptedWidth(-13);
                                                make.top.width.height.mas_equalTo(self.titleLab);
                                            }];
        _targetTitleLab.text = @"目标价";
        _targetTitleLab.textAlignment =NSTextAlignmentRight;
    }
    return _targetTitleLab;
}

- (UILabel *)targetTextLab {
    if (!_targetTextLab){
        _targetTextLab = [UILabel zj_labelWithFontSize:10
                                             textColor:RedColor
                                             superView:self
                                           constraints:^(MASConstraintMaker *make) {
                                               make.right.mas_equalTo(self.targetTitleLab);
                                               make.top.width.height.mas_equalTo(self.textLab);
                                           }];
        _targetTextLab.textAlignment =NSTextAlignmentRight;
    }
    return _targetTextLab;
}

- (UIView *)sliderBackView {
    if (!_sliderBackView){
        _sliderBackView = [[UIView alloc]initWithFrame:CGRectMake(AdaptedWidth(17), AdaptedHeight(50), MainWidth -AdaptedWidth(66), AdaptedHeight(13))];
        [_sliderBackView setLayerCornerRadius:AdaptedHeight(6) borderWidth:0.5 borderColor:MainColor];
         [self addSubview:_sliderBackView];
    }
    return _sliderBackView;
}

- (UIView *)sliderShowView {
    if (!_sliderShowView){
        _sliderShowView = [[UIView alloc]initWithFrame:CGRectMake(AdaptedWidth(17)+1, AdaptedHeight(51), 0, AdaptedHeight(11))];
        _sliderShowView.centerY = _sliderBackView.centerY;
        _sliderShowView.backgroundColor = kRGB(253, 168, 197);
        [_sliderShowView setLayerCornerRadius:AdaptedHeight(5)];
        [self addSubview:_sliderShowView];
    }
    return _sliderShowView;
}

- (UIImageView *)showAngle {
    if (!_showAngle){
        _showAngle = [[UIImageView alloc]initWithFrame:CGRectMake(AdaptedWidth(17), AdaptedHeight(67), AdaptedWidth(10), AdaptedHeight(6))];
        _showAngle.image =[UIImage imageNamed:@"hbvgtfd"];
        [self addSubview:_showAngle];

    }
    return _showAngle;
}

- (UICountingLabel *)showLable {
    if (!_showLable){
        _showLable =[[UICountingLabel alloc]initWithFrame:CGRectMake(AdaptedWidth(10), AdaptedHeight(73),AdaptedWidth(70) , AdaptedHeight(18))];
        _showLable.format =@"%.1f%";
        _showLable.font = SYSTEMFONT(8);
        _showLable.backgroundColor = kRGB(253, 168, 197);
        _showLable.textColor = RedColor;
        _showLable.textAlignment =NSTextAlignmentCenter;
        _showLable.layer.cornerRadius =3;
        _showLable.layer.masksToBounds =YES;
        [self addSubview:_showLable];
    }
    return _showLable;
}


- (UIImageView *)leftLine {
    if (!_leftLine){
        _leftLine = [UIImageView zj_imageViewWithImage:@"jiyrdhp" SuperView:self constraints:^(MASConstraintMaker *make) {
            make.left.offset =AdaptedWidth(17);
            make.top.mas_equalTo(self->_showLable.mas_bottom).offset =AdaptedHeight(20);
            make.height.offset =AdaptedHeight(9);
            make.width.offset = (MainWidth-AdaptedWidth(66))/2 -AdaptedWidth(40);
        }];
    }
    return _leftLine;
}
- (UIImageView *)rightLine {
    if (!_rightLine){
        _rightLine = [UIImageView zj_imageViewWithImage:@"njiuhgt" SuperView:self constraints:^(MASConstraintMaker *make) {
            make.right.offset =AdaptedWidth(-17);
            make.top.height.mas_equalTo(self.leftLine);
            make.width.offset = (MainWidth-AdaptedWidth(66))/2 -AdaptedWidth(40);
        }];
    }
    return _rightLine;
}

- (UILabel *)friendTitle {
    if (!_friendTitle){
        _friendTitle = [UILabel zj_labelWithFontSize:14
                                               lines:0
                                                text:@"好友战况"
                                           textColor:RGBSigle(51)
                                           superView:self
                                         constraints:^(MASConstraintMaker *make) {
                                             make.centerX.offset =0;
                                             make.width.offset =AdaptedWidth(60);
                                             make.height.offset =AdaptedHeight(15);
                                             make.centerY.mas_equalTo(self.rightLine);
                                         }];
        _friendTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _friendTitle;
}

@end
