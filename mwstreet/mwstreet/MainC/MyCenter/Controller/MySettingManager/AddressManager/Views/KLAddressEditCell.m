//
//  KLAddressEditCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/21.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLAddressEditCell.h"

@implementation KLAddressEditCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self confingUI];
    }
    return self;
}

#pragma mark - lazy UI
- (void)confingUI {
    [self titleLab];
    [self inputField];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(12);
                                          make.height.offset =AdaptedHeight(15);
                                          make.centerY.offset =0;
                                          make.width.offset =AdaptedWidth(80);
                                      }];
    }
    return _titleLab;
}

- (UITextField *)inputField {
    if (!_inputField){
        _inputField = [[UITextField alloc]init];
        _inputField.tintColor =MainColor;
        _inputField.font =kFont_14;
        _inputField.textColor =TitleColor;
        _inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.contentView addSubview:_inputField];
        [_inputField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(5);
            make.right.offset   = AdaptedWidth(-12);
            make.centerY.offset = 0;
            make.height.offset  = AdaptedHeight(35);
        }];
    }
    return _inputField;
}


@end




#pragma mark - 地址选择cell

@implementation KLAddressChangeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self confingUI];
    }
    return self;
}

#pragma mark - lazy UI
- (void)confingUI {
    [self titleLab];
    [self angleImg];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:@"所在地区"
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(12);
                                          make.height.offset =AdaptedHeight(15);
                                          make.centerY.offset =0;
                                          make.width.offset =AdaptedWidth(80);
                                      }];
    }
    return _titleLab;
}


- (UILabel *)textLab {
    if (!_textLab){
        _textLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(208)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(5);
                                          make.right.offset   = AdaptedWidth(-37);
                                          make.centerY.offset = 0;
                                          make.height.offset  = AdaptedHeight(35);
                                      }];
    }
    return _textLab;
}


- (UIImageView *)angleImg {
    if (!_angleImg){
        _angleImg = [[UIImageView alloc]init];
        _angleImg.contentMode = UIViewContentModeScaleAspectFit;
        _angleImg.image = [UIImage imageNamed:@"more"];
        [self.contentView addSubview:_angleImg];
        [_angleImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset = -15;
            make.centerY.offset =0;
            make.height.offset =AdaptedHeight(15);
            make.width.offset =AdaptedWidth(12);
        }];
    }
    return _angleImg;
}


@end



@implementation KLAddressSwitchCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self confingUI];
    }
    return self;
}

#pragma mark - lazy UI
- (void)confingUI {
    [self titleLab];
    [self switc];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:@"设置为默认地址"
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(12);
                                          make.height.offset =AdaptedHeight(15);
                                          make.centerY.offset =0;
                                          make.width.offset =AdaptedWidth(180);
                                      }];
    }
    return _titleLab;
}


- (LQXSwitch *)switc {
    if (!_switc){
        _switc = [[LQXSwitch alloc]initWithFrame:CGRectZero onColor:MainColor  offColor:RGBSigle(200) font:kFont_14 ballSize:AdaptedHeight(24)];
        _switc.onText = @"开";
        _switc.offText = @"关";
        [self.contentView addSubview:_switc];
        [_switc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset = 0;
            make.height.offset =AdaptedHeight(26);
            make.width.offset =AdaptedWidth(52);
            make.right.offset =AdaptedWidth(-12);
        }];
    }
    return _switc;
}




@end
