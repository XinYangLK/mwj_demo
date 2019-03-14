//
//  KLMyPetInputView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyPetInputView.h"

@implementation KLMyPetInputView

- (instancetype)initWithFrame:(CGRect)frame eidtType:(MyPetEidtType)type{
    self =[super initWithFrame:frame];
    if (self) {
        [self eidtType:type];
    }
    return self;
}


- (void)eidtType:(MyPetEidtType)type{
    [self addSubview:self.titleLab];
    [self addSubview:self.line];
    CGFloat width =[UILabel getWidthWithTitle:self.titleLab.text font:self.titleLab.font];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.offset = 0;
        make.height.offset =AdaptedHeight(40);
        make.width.offset = width;
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(5);
        make.right.bottom.offset =0;
        make.height.offset =1;
    }];
    
    switch (type) {
        case MyPetEidtTextInput:{
            [self addSubview:self.textField];
            
            [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(35);
                make.centerY.offset =0;
                make.right.offset =0;
                make.bottom.offset =AdaptedHeight(-1);
            }];
        }
            
            break;
        case MyPetEidtSexChange:{
            [self addSubview:self.sexMale];
            [self addSubview:self.sexFemale];
            [self.sexMale mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(35);
                make.centerY.offset =0;
                make.width.offset =AdaptedWidth(35);
                make.bottom.offset =AdaptedHeight(-1);
            }];
            [self.sexFemale mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.sexMale.mas_right).offset =AdaptedWidth(35);
                make.centerY.offset =0;
                make.width.offset =AdaptedWidth(35);
                make.bottom.offset =AdaptedHeight(-1);
            }];
        }
            break;
        case MyPetEidtDateChange:{
            [self addSubview:self.dateBtn];
            
            [self.dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(35);
                make.centerY.offset =0;
                make.right.offset = 0;
                make.bottom.offset =AdaptedHeight(-1);
            }];
        }
            break;
            
        default:
            break;
    }

}



- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_14];
        _titleLab.text =@"我的宠物";
    }
    return _titleLab;
}

- (UILabel *)line {
    if (!_line){
        _line = [[UILabel alloc]init];
        _line.backgroundColor = LineColor;
    }
    return _line;
}

- (UITextField *)textField {
    if (!_textField){
        _textField = [[UITextField alloc]init];
        _textField.font =kFont_12;
        _textField.tintColor = TitleColor;
        _textField.textColor =TitleColor;
        _textField.clearButtonMode =UITextFieldViewModeAlways;
    }
    return _textField;
}

- (UIButton *)sexMale {
    if (!_sexMale){
        klWeakSelf;
        _sexMale = [UIButton createBtnTitle:@"男" titleColor:MainColor font:kFont_12 imageName:@"nan" backgrounColor:[UIColor clearColor] SSImagePositionType:SSImagePositionTypeLeft spacing:4 action:^(UIButton * _Nonnull button) {
            UIButton * nvBtn =[weakSelf viewWithTag:51];
            [nvBtn setImage:[UIImage imageNamed:@"nv_h"] forState:UIControlStateNormal];
            [nvBtn setTitleColor:RGBSigle(153) forState:UIControlStateNormal];
            
            [button setImage:[UIImage imageNamed:@"nan"] forState:UIControlStateNormal];
            [button setTitleColor:MainColor forState:UIControlStateNormal];

        }];
        _sexMale.tag =50;
    }
    return _sexMale;
}

- (UIButton *)sexFemale {
    if (!_sexFemale){
        klWeakSelf;
        _sexFemale = [UIButton createBtnTitle:@"女" titleColor:RGBSigle(153) font:kFont_12 imageName:@"nv_h" backgrounColor:[UIColor clearColor] SSImagePositionType:SSImagePositionTypeLeft spacing:4 action:^(UIButton * _Nonnull button) {
            UIButton * maleBtn =[weakSelf viewWithTag:50];
            [maleBtn setImage:[UIImage imageNamed:@"nan_h"] forState:UIControlStateNormal];
            [maleBtn setTitleColor:RGBSigle(153) forState:UIControlStateNormal];

            [button setImage:[UIImage imageNamed:@"nv"] forState:UIControlStateNormal];
            [button setTitleColor:MainColor forState:UIControlStateNormal];
        }];
        _sexFemale.tag =51;
    }
    return _sexFemale;
}

- (UIButton *)dateBtn {
    if (!_dateBtn){
        _dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dateBtn.titleLabel.font = kFont_12;
        [_dateBtn setTitleColor:RGBSigle(200) forState:UIControlStateNormal];
        _dateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _dateBtn;
}


@end
