//
//  KLMyDistributionAssistantCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyDistributionAssistantCell.h"
#import "KLMyDisInputView.h"

@interface KLMyDistributionAssistantCell ()

@property (nonatomic, strong) KLMyDisInputView * nameInputView;
@property (nonatomic, strong) KLMyDisInputView * phoneInputView;
@property (nonatomic, strong) KLMyDisInputView * QQChangeView;
@property (nonatomic, strong) KLMyDisInputView * mailChangeView;

@property (nonatomic, strong) UIButton  * submitBtn;
@property (nonatomic, strong) UIButton  * forDetailBtn;

@end


@implementation KLMyDistributionAssistantCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        [self nameInputView];
        [self phoneInputView];
        [self QQChangeView];
        [self mailChangeView];
        [self submitBtn];
        [self forDetailBtn];

    }
    return self;
}
//***  输入框获取文本  **/
- (void)textFieldEditChanged:(UITextField *)textField {
    
    self.cellTextBlock ? self.cellTextBlock(textField.text,textField.tag) : nil;
}


- (KLMyDisInputView *)nameInputView {
    if (!_nameInputView){
        KLMyDisInputConfigure *configure =[KLMyDisInputConfigure textInputConfigure];
        configure.type  = MyTextEidtTextInput;
        configure.title = @"姓名 :";
        configure.placeholder = @"请输入您的姓名";
        _nameInputView = [[KLMyDisInputView alloc]initWithConfigure:configure];
        [_nameInputView.textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        _nameInputView.textField.tag = 100;
        [_nameInputView setLayerCornerRadius:0 borderWidth:0.5f borderColor:LineColor];
        [self.contentView addSubview:_nameInputView];
        [_nameInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset  = AdaptedHeight(50);
            make.left.right.top.offset = 0;
        }];
    }
    return _nameInputView;
}


- (KLMyDisInputView *)phoneInputView {
    if (!_phoneInputView){
        KLMyDisInputConfigure *configure =[KLMyDisInputConfigure textInputConfigure];
        configure.type  = MyTextEidtTitleInput;
        configure.title = @"电话 :";
        configure.placeholder =@"请输入您的手机号";
        _phoneInputView = [[KLMyDisInputView alloc]initWithConfigure:configure];
        [_phoneInputView.textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        _phoneInputView.textField.tag = 101;
        [_phoneInputView setLayerCornerRadius:0 borderWidth:0.5f borderColor:LineColor];
        [self.contentView addSubview:_phoneInputView];
        [_phoneInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.right.left.mas_equalTo(self.nameInputView);
            make.top.mas_equalTo(self.nameInputView.mas_bottom);
        }];
    }
    return _phoneInputView;
}

- (KLMyDisInputView *)QQChangeView {
    if (!_QQChangeView){
        KLMyDisInputConfigure *configure =[KLMyDisInputConfigure textInputConfigure];
        configure.type  = MyTextEidtTextInput;
        configure.title = @"QQ :";
        configure.placeholder = @"请输入您的QQ";
        _QQChangeView = [[KLMyDisInputView alloc]initWithConfigure:configure];
        [_QQChangeView.textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        _QQChangeView.textField.tag = 102;
        [_QQChangeView setLayerCornerRadius:0 borderWidth:0.5f borderColor:LineColor];
        [self.contentView addSubview:_QQChangeView];
        [_QQChangeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.right.left.mas_equalTo(self.nameInputView);
            make.top.mas_equalTo(self.phoneInputView.mas_bottom);
        }];
    }
    return _QQChangeView;
}

- (KLMyDisInputView *)mailChangeView {
    if (!_mailChangeView){
        KLMyDisInputConfigure *configure =[KLMyDisInputConfigure textInputConfigure];
        configure.type  = MyTextEidtTextInput;
        configure.title = @"邮箱 :";
        configure.placeholder = @"请输入您的邮箱";
        _mailChangeView = [[KLMyDisInputView alloc]initWithConfigure:configure];
        [_mailChangeView.textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        _mailChangeView.textField.tag = 103;
        [_mailChangeView setLayerCornerRadius:0 borderWidth:0.5f borderColor:LineColor];
        [self.contentView addSubview:_mailChangeView];
        [_mailChangeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.right.left.mas_equalTo(self.nameInputView);
            make.top.mas_equalTo(self.QQChangeView.mas_bottom);
        }];
    }
    return _mailChangeView;
}


- (UIButton *)submitBtn {
    if (!_submitBtn){
        klWeakSelf;
        _submitBtn = [UIButton createBtnTitle:@"提交"
                                   titleColor:[UIColor whiteColor]
                                         font:kFont_14
                                    imageName:@""
                               backgrounColor:BMainColor
                                       action:^(UIButton * _Nonnull button) {
                                           weakSelf.cellBtnBlock ? weakSelf.cellBtnBlock(button) :nil;
                                       }];
         _submitBtn.tag = 20;
        [_submitBtn setLayerCornerRadius:5 borderWidth:0 borderColor:[UIColor clearColor]];
        [self.contentView addSubview:_submitBtn];
        [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset =AdaptedHeight(34);
            make.top.mas_equalTo(self.mailChangeView.mas_bottom).offset =AdaptedHeight(23);
            make.width.offset =AdaptedWidth(94);
            make.left.offset =AdaptedWidth(62);
        }];

    }
    return _submitBtn;
}

- (UIButton *)forDetailBtn {
    if (!_forDetailBtn){
        klWeakSelf;
        _forDetailBtn = [UIButton createBtnTitle:@"转发详情"
                                      titleColor:[UIColor whiteColor]
                                            font:kFont_14
                                       imageName:@""
                                  backgrounColor:BMainColor
                                          action:^(UIButton * _Nonnull button) {
                                              weakSelf.cellBtnBlock ? weakSelf.cellBtnBlock(button) :nil;
                                          }];
        _forDetailBtn.tag = 21;
        [_forDetailBtn setLayerCornerRadius:5 borderWidth:0 borderColor:[UIColor clearColor]];
        [self.contentView addSubview:_forDetailBtn];
        [_forDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.height.mas_equalTo(self.submitBtn);
            make.right.offset =AdaptedWidth(-62);
        }];
    }
    return _forDetailBtn;
}

@end
