//
//  KLRegisterViewController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/17.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLRegisterViewController.h"
#import "KLTextInputConfigure.h"
#import "KLTextInputView.h"
#import "KLPetClassifyController.h"

@interface KLRegisterViewController ()

@property (nonatomic, strong) KLTextInputView * accoutView;
@property (nonatomic, strong) KLTextInputView * passwordView;
@property (nonatomic, strong) KLTextInputView * verCodeView;
@property (nonatomic, strong) UIButton        * confirmBtn;
@property (nonatomic, strong) UIButton        * checkBtn;
@property (nonatomic, strong) UILabel         * agreementlab;

@property (nonatomic, strong) NSString * accoutStr;
@property (nonatomic, strong) NSString * passwordStr;
@property (nonatomic, strong) NSString * vCodeStr;

@end

@implementation KLRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self configerUI];
}

#pragma mark - 注册

- (void)didRegisterVChick:(UIButton *)sender {
    
   NSString * accoutName = [NSString getWithFilteringStringSpace:self.accoutStr];
   NSString * passeord   = [NSString getWithFilteringStringSpace:self.passwordStr];
   NSString * VCode      = [NSString getWithFilteringStringSpace:self.vCodeStr];

    KLPetClassifyController *vc =[[KLPetClassifyController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    KLLog(@"-------\n%@\n%@\n%@",accoutName,passeord,VCode);
}

#pragma mark - 协议勾选
- (void)checkBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}
#pragma mark - 协议
- (void)event:(UITapGestureRecognizer *)tap{
    KLLog(@"----- 协议");
}



#pragma mark - 获取输入框 值
- (void)textFieldEditChanged:(UITextField *)textField {
    
    switch (textField.tag) {
        case 5:
            self.accoutStr = textField.text;

            break;
        case 6:
            self.passwordStr = textField.text;
            
            break;
        case 7:
             self.vCodeStr = textField.text;
            
            break;
            
        default:
            break;
    }
}




#pragma mark - lazy - UI
- (void)configerUI {
    [self.view addSubview:self.accoutView];
    [self.view addSubview:self.passwordView];
    [self.view addSubview:self.verCodeView];
    [self confirmBtn];
    [self.view addSubview:self.checkBtn];
    [self agreementlab];
    
    [self.accoutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset =0;
        make.top.offset =AdaptedHeight(24);
        make.width.offset =MainWidth - AdaptedWidth(74);
        make.height.offset =AdaptedWidth(43);
    }];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.mas_equalTo(self.accoutView);
        make.top.mas_equalTo(self.accoutView.mas_bottom).offset =AdaptedHeight(18);
    }];
    [self.verCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.mas_equalTo(self.accoutView);
        make.top.mas_equalTo(self.passwordView.mas_bottom).offset =AdaptedHeight(18);
    }];
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(42);
        make.width.height.offset =AdaptedHeight(16);
        make.bottom.offset = - AdaptedHeight(16) - TabbarSafeBottomMargin;
    }];
}


- (KLTextInputView *)accoutView {
    if (!_accoutView){
        KLTextInputConfigure * configure =[KLTextInputConfigure textInputConfigure];
        configure.imgName     = @"shouji";
        configure.placeholder = @"请输入手机号";
        configure.type        = TextFieldDefaultType;
        _accoutView = [[KLTextInputView alloc]initWithFrame:CGRectZero configure:configure];
        _accoutView.textField.tag = 5;
        [_accoutView.textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _accoutView;
}




- (KLTextInputView *)passwordView {
    if (!_passwordView){
        KLTextInputConfigure * configure =[KLTextInputConfigure textInputConfigure];
        configure.imgName     = @"mimasuo";
        configure.placeholder = @"请输入密码";
        configure.type        = TextFieldDefaultType;
        configure.security    = YES;
        _passwordView = [[KLTextInputView alloc]initWithFrame:CGRectZero configure:configure];
        _passwordView.textField.tag = 6;
        [_passwordView.textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordView;
}

- (KLTextInputView *)verCodeView {
    if (!_verCodeView){
        KLTextInputConfigure * configure =[KLTextInputConfigure textInputConfigure];
        configure.imgName     = @"yanzhengma";
        configure.placeholder = @"请输入验证码";
        configure.type        = TextFieldVerificationType;
        configure.timeCount   = 60;
        _verCodeView = [[KLTextInputView alloc]initWithFrame:CGRectZero configure:configure];
        _verCodeView.textField.tag = 7;
        [_verCodeView.textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _verCodeView;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn){
        klWeakSelf;
        _confirmBtn = [UIButton zj_buttonWithTitle:@"注册"
                                        titleColor:[UIColor whiteColor]
                                         backColor:MainColor
                                          fontSize:18
                                            isBold:YES
                                      cornerRadius:AdaptedHeight(21)
                                           supView:self.view
                                       constraints:^(MASConstraintMaker *make) {
                                           make.centerX.height.width.mas_equalTo(self.accoutView);
                                           make.top.mas_equalTo(self.verCodeView.mas_bottom).offset = AdaptedHeight(35);
                                       } touchUp:^(id sender) {
                                           [weakSelf didRegisterVChick:sender];
                                       }];
    }
    return _confirmBtn;
}


- (UIButton *)checkBtn {
    if (!_checkBtn){
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkBtn setImage:[UIImage imageNamed:@"kuangkuang"] forState:UIControlStateNormal];
        [_checkBtn setImage:[UIImage imageNamed:@"gdnbgj"] forState:UIControlStateSelected];
        [_checkBtn addTarget:self action:@selector(checkBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBtn;
}

- (UILabel *)agreementlab {
    if (!_agreementlab){
        _agreementlab = [UILabel zj_labelWithFontSize:12 text:@"注册表示同意该软件用户服务协议和隐私政策" superView:self.view constraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.checkBtn.mas_right).offset =AdaptedWidth(8);
            make.height.centerY.mas_equalTo(self.checkBtn);
            make.right.offset =AdaptedWidth(-30);
        }];
        _agreementlab.userInteractionEnabled = YES;
        _agreementlab.textColor = TitleColor;
        _agreementlab.attributedText = [self setPriceAttreWith:_agreementlab.text handleString:@"用户服务协议" handleString:@"隐私政策" handleStrFont:kFont_12 handleStrColor:MainColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
        [tap setNumberOfTapsRequired:1];
        [_agreementlab addGestureRecognizer:tap];
    }
    return _agreementlab;
}









#pragma mark - 富文本设置字体 <注册协议文字>
- (NSMutableAttributedString *)setPriceAttreWith:(NSString *)string handleString:(NSString *)handleString handleString:(NSString *)handle2String  handleStrFont:(UIFont *)font handleStrColor:(UIColor *)color {

    //创建一个富文本
    NSMutableAttributedString *inteMutStr = [[NSMutableAttributedString alloc] initWithString:string];
    //字符串起始位置
    NSInteger loc = [[inteMutStr string] rangeOfString:handleString].location;
    //字符串长度
    NSInteger len = [[inteMutStr string] rangeOfString:handleString].length;
    //组合范围域
    NSRange orangeRange = NSMakeRange(loc, len);
    //将此范围域中字符添加颜色
    [inteMutStr addAttribute:NSForegroundColorAttributeName value:color range:orangeRange];
    //将此范围域中字符添加大小
    [inteMutStr addAttribute:NSFontAttributeName value:font range:orangeRange];
    
    //字符串起始位置
    NSInteger loc2 = [[inteMutStr string] rangeOfString:handle2String].location;
    //字符串长度
    NSInteger len2 = [[inteMutStr string] rangeOfString:handle2String].length;
    //组合范围域
    NSRange orangeRange2 = NSMakeRange(loc2, len2);
   
    //将此范围域中字符添加颜色
    [inteMutStr addAttribute:NSForegroundColorAttributeName value:color range:orangeRange2];
    //将此范围域中字符添加大小
    [inteMutStr addAttribute:NSFontAttributeName value:font range:orangeRange];
   
    return inteMutStr;
}

@end
