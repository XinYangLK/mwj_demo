//
//  KLMyDistritionHeaderCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/1.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyDistritionHeaderCell.h"

@interface KLMyDistritionHeaderCell ()

@property (nonatomic, strong) UIImageView * accoutImgV;
@property (nonatomic, strong) UILabel     * nameLab;
@property (nonatomic, strong) UIButton    * editBtn;

@property (nonatomic, strong) UIButton    * leftBtn;
@property (nonatomic, strong) UIView      * line;
@property (nonatomic, strong) UIButton    * rightBtn;

@property (nonatomic, strong) UIView      * bottomView;
@property (nonatomic, strong) UILabel     * withAmountLab;
@property (nonatomic, strong) UIButton    * WithdrawBtn;
@property (nonatomic, strong) UIView      * lineView;
@end


@implementation KLMyDistritionHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor =RGB(255,142,142);
        [self confingerUI];
    }
    return self;
}


- (void)setAccoutImg:(NSString *)accoutImg {
    _accoutImg = accoutImg;
    self.accoutImgV.image =[UIImage imageNamed:_accoutImg];
}

- (void)setName:(NSString *)name {
    _name =name;
    self.nameLab.text = _name;
}

- (void)setSalesAmount:(NSString *)salesAmount {
    _salesAmount = salesAmount;
    NSString * text = [NSString stringWithFormat:@"累计销售金额(元)\n%@",_salesAmount];
    [_leftBtn setTitle:text forState:UIControlStateNormal];
    _leftBtn.titleLabel.attributedText =[NSMutableAttributedString getAttributedString:text
                                                                          handleString:_salesAmount
                                                                         handleStrFont:kFont_14
                                                                        handleStrColor:[UIColor whiteColor]
                                                                             lineSpace:5];
    _leftBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
}


- (void)setCommission:(NSString *)commission {
    
    _commission = commission;
    NSString * text = [NSString stringWithFormat:@"累计佣金(元)\n%@",_commission];
    [_rightBtn setTitle:text forState:UIControlStateNormal];
    _rightBtn.titleLabel.attributedText =[NSMutableAttributedString getAttributedString:text
                                                                           handleString:_commission
                                                                          handleStrFont:kFont_14
                                                                         handleStrColor:[UIColor whiteColor]
                                                                              lineSpace:2];
    _rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setWithAmount:(NSString *)withAmount {
    _withAmount =withAmount;
   
    self.withAmountLab.text = [NSString stringWithFormat:@"可提现佣金（元）\n%@",_withAmount];
    CGSize size =[self.withAmountLab getLableRectWithMaxWidth:MainWidth/2];
    [self.withAmountLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset = size.height;
    }];

}
   



#pragma mark - lazy UI
- (void)confingerUI {
    
    [self accoutImgV];
    [self nameLab];
    [self editBtn];
    [self leftBtn];
    [self rightBtn];
    [self line];
    [self bottomView];
    [self withAmountLab];
    [self WithdrawBtn];
    [self lineView];
}


- (UIImageView *)accoutImgV {
    if (!_accoutImgV){
        _accoutImgV = [UIImageView zj_imageViewWithImage:nil
                                              SuperView:self.contentView
                                            constraints:^(MASConstraintMaker *make) {
                                                make.centerX.offset = 0;
                                                make.height.width.offset = AdaptedHeight(43);
                                                make.top.offset = AdaptedHeight(8);
                                            }];
        [_accoutImgV setLayerCornerRadius:AdaptedWidth(22) borderWidth:1 borderColor:RGBSigle(255)];
    }
    return _accoutImgV;
}

- (UILabel *)nameLab {
    if (!_nameLab){
        _nameLab = [UILabel zj_labelWithFontSize:14
                                           lines:1
                                            text:nil
                                       textColor:RGBSigle(255)
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.top.mas_equalTo(self.accoutImgV.mas_bottom).offset =AdaptedHeight(6);
                                         make.height.offset  = AdaptedHeight(15);
                                         make.centerX.offset = 0;
                                         make.width.offset   = MainWidth -AdaptedWidth(50);
                                     }];
        _nameLab.backgroundColor =[UIColor clearColor];
        _nameLab.textAlignment =NSTextAlignmentCenter;
    }
    return _nameLab;
}

- (UIButton *)editBtn {
    if (!_editBtn){
        _editBtn = [UIButton createBtnTitle:@"编辑个人资料"
                                 titleColor:RGBSigle(255)
                                       font:kFont_10
                                  imageName:@"bainjibianji"
                             backgrounColor:[UIColor clearColor]
                        SSImagePositionType:SSImagePositionTypeRight
                                    spacing:4
                                     action:^(UIButton * _Nonnull button) {
                                         
                                     }];
        [self.contentView addSubview:_editBtn];
        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLab.mas_bottom).offset =AdaptedHeight(8);
            make.centerX.offset = 0;
            make.height.offset  = AdaptedHeight(15);
            make.width.offset   = MainWidth-AdaptedWidth(70);
        }];
    }
    return _editBtn;
}


- (UIButton *)leftBtn {
    if (!_leftBtn){
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _leftBtn.backgroundColor = RGB(255,113,113);
        _leftBtn.titleLabel.font = kFont_12;
        [self.contentView addSubview:_leftBtn];
        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.bottom.offset =AdaptedHeight(-60);
            make.height.offset = AdaptedHeight(49);
            make.width.offset  = MainWidth/2;
        }];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn){
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _rightBtn.backgroundColor = RGB(255,113,113);
        _rightBtn.titleLabel.font = kFont_12;
        [self.contentView addSubview:_rightBtn];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset = 0;
            make.bottom.mas_equalTo(self.leftBtn);
            make.height.offset = AdaptedHeight(49);
            make.left.mas_equalTo(self.leftBtn.mas_right);
        }];
    }
    return _rightBtn;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:[UIColor whiteColor]
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.centerX.offset = 0;
                                     make.bottom.offset  = AdaptedHeight(-63);
                                     make.width.offset   = 0.5f;
                                     make.height.offset  = AdaptedHeight(43);
                                 }];
    }
    return _line;
}


- (UIView *)bottomView {
    if (!_bottomView){
        _bottomView = [UIView zj_viewWithBackColor:[UIColor whiteColor]
                                           supView:self.contentView
                                       constraints:^(MASConstraintMaker *make) {
                                           make.left.right.offset = 0;
                                           make.bottom.offset =AdaptedHeight(-5);
                                           make.height.offset =AdaptedHeight(55);
                                       }];
    }
    return _bottomView;
}


- (UILabel *)withAmountLab {
    if (!_withAmountLab){
        _withAmountLab = [UILabel zj_labelWithFontSize:14
                                              lines:2
                                               text:nil
                                          textColor:RGBSigle(51)
                                          superView:self.bottomView
                                        constraints:^(MASConstraintMaker *make) {
                                            make.centerY.left.offset = 0;
                                            make.width.offset =MainWidth/2;
                                            make.height.offset =AdaptedHeight(54);
                                        }];
        _withAmountLab.textAlignment = NSTextAlignmentCenter;
        _withAmountLab.lineSpace = 5;
    }
    return _withAmountLab;
}

- (UIButton *)WithdrawBtn {
    if (!_WithdrawBtn){
        _WithdrawBtn = [UIButton zj_buttonWithTitle:@"提现"
                                         titleColor:RGBSigle(255)
                                           norImage:nil
                                      selectedImage:nil
                                          backColor:RGB(255, 113, 113)
                                           fontSize:14
                                             isBold:NO
                                       cornerRadius:0
                                            supView:self.contentView
                                        constraints:^(MASConstraintMaker *make) {
                                            make.right.offset =AdaptedWidth(-10);
                                            make.top.mas_equalTo(self.rightBtn.mas_bottom).offset =AdaptedHeight(11);
                                            make.height.offset =AdaptedHeight(26);
                                            make.width.offset =AdaptedWidth(76);
                                        } touchUp:^(id sender) {
                                            
                                            KLLog(@"=====提现");
                                        }];
    }
    return _WithdrawBtn;
}

- (UIView *)lineView {
    if (!_lineView){
        _lineView = [UIView zj_viewWithBackColor:SpacColor
                                         supView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.bottom.right.offset = 0;
                                         make.height.offset = AdaptedHeight(5);
                                     }];
    }
    return _lineView;
}


@end
