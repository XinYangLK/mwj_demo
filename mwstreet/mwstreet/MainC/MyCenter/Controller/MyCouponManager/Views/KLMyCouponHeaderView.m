//
//  KLMyCouponHeaderView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/11.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyCouponHeaderView.h"

@implementation KLMyCouponHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =[UIColor whiteColor];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.textField];
        [self exchangeBtn];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset    = AdaptedWidth(10);
            make.height.offset  = AdaptedHeight(15);
            make.width.offset   = AdaptedWidth(48);
            make.centerY.offset = 0;
        }];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(5);
            make.right.offset   = AdaptedWidth(-70);
            make.height.offset  = AdaptedHeight(28);
            make.centerY.offset = 0;
        }];
    }
    return self;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_14];
        _titleLab.text =@"兑换码";
    }
    return _titleLab;
}

- (UITextField *)textField {
    if (!_textField){
        _textField = [[UITextField alloc]init];
        _textField.backgroundColor = BackgroundColor;
        _textField.font = kFont_13;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.placeholder =@"请输入兑换码";
        _textField.tintColor = MainColor;
        UIView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        _textField.leftView = leftView;
    }
    return _textField;
}

- (UIButton *)exchangeBtn {
    if (!_exchangeBtn){
        @weakify(self)
        _exchangeBtn = [UIButton zj_buttonWithTitle:@"兑换"
                                         titleColor:MainColor
                                          backColor:[UIColor clearColor]
                                           fontSize:15
                                             isBold:NO
                                       cornerRadius:0
                                            supView:self.contentView
                                        constraints:^(MASConstraintMaker *make) {
                                            make.left.mas_equalTo(self.textField.mas_right).offset =AdaptedWidth(5);
                                            make.right.offset =AdaptedWidth(-12);
                                            make.height.offset =AdaptedHeight(20);
                                            make.centerY.mas_equalTo(self.textField);
                                        } touchUp:^(id sender) {
                                            @strongify(self)
                                            self.exchangeBlock ? self.exchangeBlock(sender) : nil;
                                        }];
    }
    return _exchangeBtn;
}

@end
