//
//  KLMyDistributionFounderCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyDistributionFounderCell.h"
#import "KLMyDisInputConfigure.h"
#import "KLMyDisInputView.h"

@interface KLMyDistributionFounderCell ()

@property (nonatomic, strong) UILabel * titleLab;

@property (nonatomic, strong) KLMyDisInputView * nameInputView;
@property (nonatomic, strong) KLMyDisInputView * phoneInputView;
@property (nonatomic, strong) KLMyDisInputView * sexChangeView;
@property (nonatomic, strong) UIButton         * applyBtn;
@property (nonatomic, strong) UILabel          * privilegeTitle;

@end

@implementation KLMyDistributionFounderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self titleLab];
        [self nameInputView];
        [self phoneInputView];
        [self sexChangeView];
        [self applyBtn];
        [self privilegeTitle];
    }
    return self;
}

//***  获取输入框中文字  **/
- (void)textFieldEditChanged:(UITextField *)textField {
    
    self.textInputBlock ? self.textInputBlock(textField.text,textField.tag) : nil;
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr =titleStr;
    self.titleLab.text = [NSString getBlankString:_titleStr];
}


- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:18
                                            lines:1
                                             text:nil
                                        textColor:RedColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset = AdaptedWidth(11);
                                          make.top.offset =AdaptedHeight(15);
                                          make.height.offset =AdaptedHeight(18);
                                          make.right.offset =AdaptedWidth(-11);
                                      }];
    }
    return _titleLab;
}


- (KLMyDisInputView *)nameInputView {
    if (!_nameInputView){
        KLMyDisInputConfigure *configure =[KLMyDisInputConfigure textInputConfigure];
        configure.type  = MyTextEidtTextInput;
        configure.title = @"姓名 :";
        configure.placeholder = @"请输入您的姓名";
        _nameInputView = [[KLMyDisInputView alloc]initWithConfigure:configure];
        [_nameInputView.textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        _nameInputView.textField.tag = 10;
        [_nameInputView setLayerCornerRadius:0 borderWidth:0.5f borderColor:LineColor];
        [self.contentView addSubview:_nameInputView];
        [_nameInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset =AdaptedWidth(24);
            make.left.offset    = AdaptedWidth(37);
            make.right.offset   = AdaptedWidth(-37);
            make.height.offset  = AdaptedHeight(43);
        }];
    }
    return _nameInputView;
}
- (KLMyDisInputView *)phoneInputView {
    if (!_phoneInputView){
        KLMyDisInputConfigure *configure =[KLMyDisInputConfigure textInputConfigure];
        configure.type  = MyTextEidtTextInput;
        configure.title = @"电话 :";
        configure.placeholder =@"请输入您的手机号";
        _phoneInputView = [[KLMyDisInputView alloc]initWithConfigure:configure];
        [_phoneInputView.textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        _phoneInputView.textField.tag = 11;
        [_phoneInputView setLayerCornerRadius:0 borderWidth:0.5f borderColor:LineColor];
        [self.contentView addSubview:_phoneInputView];
        [_phoneInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.right.left.mas_equalTo(self.nameInputView);
            make.top.mas_equalTo(self.nameInputView.mas_bottom).offset = AdaptedHeight(18);
        }];
    }
    return _phoneInputView;
}

- (KLMyDisInputView *)sexChangeView {
    if (!_sexChangeView){
        KLMyDisInputConfigure *configure =[KLMyDisInputConfigure textInputConfigure];
        configure.type  = MyTextEidtSexChange;
        configure.title =@"性别 :";
        _sexChangeView  = [[KLMyDisInputView alloc]initWithConfigure:configure];
        klWeakSelf;
        _sexChangeView.sexChangeBlock = ^(UIButton * _Nonnull button) {
            weakSelf.sexChangeCellBlock ? weakSelf.sexChangeCellBlock(button) : nil;
        };
        [_sexChangeView setLayerCornerRadius:0 borderWidth:0.5f borderColor:LineColor];
        [self.contentView addSubview:_sexChangeView];
        [_sexChangeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.right.left.mas_equalTo(self.nameInputView);
            make.top.mas_equalTo(self.phoneInputView.mas_bottom).offset = AdaptedHeight(18);
        }];
    }
    return _sexChangeView;
}


- (UIButton *)applyBtn {
    if (!_applyBtn){
        klWeakSelf;
        _applyBtn = [UIButton zj_buttonWithTitle:@"立即申请"
                                      titleColor:RedColor
                                        norImage:nil
                                   selectedImage:nil
                                       backColor:[UIColor whiteColor]
                                        fontSize:14
                                          isBold:NO
                                     borderWidth:0.5f
                                     borderColor:RedColor
                                    cornerRadius:0
                                         supView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.width.offset = AdaptedWidth(84);
                                         make.right.offset =AdaptedWidth(-37);
                                         make.height.offset = AdaptedHeight(32);
                                         make.top.mas_equalTo(self.sexChangeView.mas_bottom).offset =AdaptedHeight(29);
                                     } touchUp:^(id sender) {
                                         weakSelf.applyBtnChick ? weakSelf.applyBtnChick(sender) : nil;
                                     }];
    }
    return _applyBtn;
}


- (UILabel *)privilegeTitle {
    if (!_privilegeTitle){
        _privilegeTitle = [UILabel zj_labelWithFontSize:15
                                                  lines:1
                                                   text:@"创始人特权："
                                              textColor:RGBSigle(51)
                                              superView:self.contentView
                                            constraints:^(MASConstraintMaker *make) {
                                                make.left.offset = AdaptedWidth(11);
                                                make.top.mas_equalTo(self.applyBtn.mas_bottom).offset =AdaptedHeight(45);
                                                make.height.offset =AdaptedHeight(18);
                                                make.right.offset =AdaptedWidth(-11);
                                            }];
    }
    return _privilegeTitle;
}




@end







@implementation KLMyDistributionFouPriCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self imgV];
        [self titleLab];
        [self textLab];

    }
    return self;
}


- (UIImageView *)imgV {
    if (!_imgV){
        _imgV = [UIImageView zj_imageViewWithImage:nil
                                         SuperView:self.contentView
                                       constraints:^(MASConstraintMaker *make) {
                                           make.left.offset   = AdaptedWidth(11);
                                           make.width.offset  = AdaptedWidth(21);
                                           make.height.offset = AdaptedHeight(19);
                                           make.top.offset = AdaptedHeight(19);
                                       }];
    }
    return _imgV;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:nil
                                        textColor:TitleColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.mas_equalTo(self.imgV.mas_right).offset = AdaptedWidth(12);
                                          make.right.offset  = AdaptedWidth(-15);
                                          make.height.offset = AdaptedHeight(15);
                                          make.top.offset    = AdaptedHeight(14);
                                      }];
    }
    return _titleLab;
}

- (UILabel *)textLab {
    if (!_textLab){
        _textLab = [UILabel zj_labelWithFontSize:10
                                           lines:1
                                            text:nil
                                       textColor:TitleColor
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.right.height.left.mas_equalTo(self.titleLab);
                                         make.top.mas_equalTo(self.titleLab.mas_bottom).offset = AdaptedHeight(10);
                                     }];
    }
    return _textLab;
}


@end
