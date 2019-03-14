//
//  KLChangePasswordController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/20.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLChangePasswordController.h"
#import "KLTextFieldView.h"

@interface KLChangePasswordController ()<UITextFieldDelegate>

//***  标题  **/
@property (nonatomic, strong) UILabel * titleLab;
//***  手机号输入框  **/
@property (nonatomic, strong) KLTextFieldView * accoutNameField;
//***  验证码输入框  **/
@property (nonatomic, strong) KLTextFieldView * accoutVerField;
//***  密码输入框  **/
@property (nonatomic, strong) KLTextFieldView * accoutPwdField;
//***  提交按钮  **/
@property (nonatomic, strong) UIButton  * confirmBtn;
@end
@implementation KLChangePasswordController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"账号与安全"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar navBarBottomLineHidden:YES];

    [self titleLab];
    [self accoutNameField];
    [self accoutVerField];
    [self accoutPwdField];
    [self confirmBtn];
    
}
//***  获取输入框值  **/
- (void)textFieldEditChanged:(UITextField *)textField {
    
}
//***  获取验证码  **/
- (void)countdownChickAction:(UIButton *)sender {
    
    [self.accoutVerField readSecond];
}
//***  确定提交  **/
- (void)confirmChick:(UIButton *)sender {
    KLLog(@"----确定提交  --");
}

//***  查看或隐藏密码  **/
- (void)lookPwdChickAction:(UIButton *)sender {
    sender.selected =!sender.selected;
    
    if (sender.selected) {
        self.accoutPwdField.textField.secureTextEntry = NO;
        [sender setImage:[UIImage imageNamed:@"zhengkaiyanjing"] forState:UIControlStateNormal];
    }else{
        self.accoutPwdField.textField.secureTextEntry = YES;
        [sender setImage:[UIImage imageNamed:@"bishangyanjing"] forState:UIControlStateNormal];

    }
}


#pragma mark - lazy UI
- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:15
                                            lines:1
                                             text:@"修改登录密码"
                                        textColor:RGBSigle(51)
                                        superView:self.view
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset = AdaptedWidth(12);
                                          make.right.offset =AdaptedWidth(-12);
                                          make.top.offset =AdaptedHeight(17);
                                          make.height.offset =AdaptedHeight(15);
                                      }];
    }
    return _titleLab;
}


- (KLTextFieldView *)accoutNameField {
    
    if (!_accoutNameField){
        _accoutNameField = [[KLTextFieldView alloc]initWithFrame:CGRectZero type:TextFieldDefaultType];
        _accoutNameField.type = TextFieldDefaultType;
        _accoutNameField.textField.keyboardType = UIKeyboardTypeNumberPad;
        _accoutNameField.textField.placeholder =@"请输入手机号";
        _accoutNameField.textField.tag =21;
        NSString *phone =[kUSER_DEFAULT objectForKey:kUSER_PHONE];
        if (![NSString isBlankString:phone]) {
            _accoutNameField.textField.text = phone;
        }
        _accoutNameField.textField.delegate = self;
        [self.view addSubview:_accoutNameField];
        
        [_accoutNameField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset = AdaptedHeight(30);
            make.centerX.offset = 0;
            make.width.offset   = MainWidth - AdaptedWidth(24);
            make.height.offset  = AdaptedHeight(44);
        }];
    }
    return _accoutNameField;
    
}


- (KLTextFieldView *)accoutVerField {
    if (!_accoutVerField){
        _accoutVerField = [[KLTextFieldView alloc]initWithFrame:CGRectZero type:TextFieldVerificationType];
        _accoutVerField.type = TextFieldVerificationType;
        _accoutVerField.textField.placeholder =@"请输入验证码";
        _accoutVerField.textField.tag =22;
        _accoutVerField.textField.keyboardType = UIKeyboardTypeNumberPad;
        _accoutVerField.textField.delegate = self;
        [_accoutVerField.textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        [_accoutVerField.verBtn addTarget:self action:@selector(countdownChickAction:)
                         forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_accoutVerField];
        [_accoutVerField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.accoutNameField.mas_bottom).offset =AdaptedHeight(30);
            make.centerX.width.height.mas_equalTo(self.accoutNameField);
        }];
    }
    return _accoutVerField;
}


- (KLTextFieldView *)accoutPwdField {
    if (!_accoutPwdField){
        _accoutPwdField = [[KLTextFieldView alloc]initWithFrame:CGRectZero type:TextFieldPasswordType];
        _accoutPwdField.type =TextFieldPasswordType;
        _accoutPwdField.textField.placeholder =@"请输入密码";
        _accoutPwdField.textField.secureTextEntry = YES;
        _accoutPwdField.textField.delegate = self;
        _accoutPwdField.textField.tag =23;
        [_accoutPwdField.textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:_accoutPwdField];
        [_accoutPwdField.lookBtn addTarget:self action:@selector(lookPwdChickAction:)
                         forControlEvents:UIControlEventTouchUpInside];
        
        [_accoutPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.accoutVerField.mas_bottom).offset =AdaptedHeight(30);
            make.centerX.width.height.mas_equalTo(self.accoutNameField);
        }];

    }
    return _accoutPwdField;
}



- (UIButton *)confirmBtn {
    if (!_confirmBtn){
        @weakify(self)
        _confirmBtn = [UIButton zj_buttonWithTitle:@"确定"
                                        titleColor:[UIColor whiteColor]
                                         backColor:MainColor
                                          fontSize:14
                                            isBold:NO
                                      cornerRadius:AdaptedHeight(17)
                                           supView:self.view
                                       constraints:^(MASConstraintMaker *make) {
                                           make.top.mas_equalTo(self.accoutPwdField.mas_bottom).offset =AdaptedWidth(43);
                                           make.centerX.offset = 0;
                                           make.height.offset =AdaptedWidth(34);
                                           make.width.offset = MainWidth - AdaptedWidth(90);
                                       } touchUp:^(id sender) {
                                           @strongify(self)
                                           [self confirmChick:sender];
                                       }];
    }
    return _confirmBtn;
}



//textField__delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField.tag ==21) {
        [self.accoutNameField addLineAnmation];
        [self.accoutPwdField moveLineAnimation];
        [self.accoutVerField moveLineAnimation];
    }else if(textField.tag ==22){
        [self.accoutVerField addLineAnmation];
        [self.accoutNameField moveLineAnimation];
        [self.accoutPwdField moveLineAnimation];
    }else if(textField.tag ==23){
        [self.accoutPwdField addLineAnmation];
        [self.accoutVerField moveLineAnimation];
        [self.accoutNameField moveLineAnimation];
    }
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
