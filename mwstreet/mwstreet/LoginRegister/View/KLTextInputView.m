//
//  KLTextInputView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/17.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLTextInputView.h"
#import "KLTextInputConfigure.h"

@interface KLTextInputView ()<UITextFieldDelegate>
{
    NSString    *_previousTextFieldContent;
    UITextRange *_previousSelection;
}

@property (nonatomic, strong) KLTextInputConfigure * configure;
//***  计时器  **/
@property (nonatomic, strong) NSTimer  * timer;
//***  图标  **/
@property (nonatomic, strong) UIImageView * imgView;

//***  获取验证码按钮  **/
@property (nonatomic, strong) UIButton    * validationBtn;
//***  获取验证码遮盖Lab  **/
@property (nonatomic, strong) UILabel     * tipLab;
@end

@implementation KLTextInputView

- (instancetype)initWithFrame:(CGRect)frame configure:(KLTextInputConfigure *)configure{
    
    self =[super initWithFrame:frame];
    if (self) {
        self.configure = configure;
        [self setLayerCornerRadius:0 borderWidth:0.5f borderColor:MainColor];
        [self confingUI];
        
        if ([configure.placeholder hasSuffix:@"手机号"]) {
            self.textField.delegate = self;
            self.textField.keyboardType=UIKeyboardTypeNumberPad;
            [self.textField addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];
        }
        
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        if ([_configure.placeholder hasSuffix:@"手机号"]) {
            [self.textField addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];
        }
    }
    return self;
}





-(void)reformatAsPhoneNumber:(UITextField *)textField {
    /**
     *  判断正确的光标位置
     */
    NSUInteger targetCursorPostion = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
    NSString *phoneNumberWithoutSpaces = [NSString removeNonDigits:textField.text andPreserveCursorPosition:&targetCursorPostion];
    
    if([phoneNumberWithoutSpaces length]>11) {
        /**
         *  避免超过11位的输入
         */
        [textField setText:_previousTextFieldContent];
        textField.selectedTextRange = _previousSelection;
        return;
    }
    
    NSString *phoneNumberWithSpaces = [NSString insertSpacesEveryFourDigitsIntoString:phoneNumberWithoutSpaces andPreserveCursorPosition:&targetCursorPostion];
    
    textField.text = phoneNumberWithSpaces;
    UITextPosition *targetPostion = [textField positionFromPosition:textField.beginningOfDocument offset:targetCursorPostion];
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPostion toPosition:targetPostion]];
}


#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([self.configure.placeholder hasSuffix:@"手机号"]) {
        
        _previousSelection = textField.selectedTextRange;
        _previousTextFieldContent = textField.text;
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if(range.location==0) {
            if(toBeString.integerValue >1)
            {
                return NO;
            }
        }
        if ([toBeString length] > 13) {
            
            return NO;
        }
    }
    if([string hasSuffix:@" "])     // 忽视空格
        return NO;
    else
        return YES;
    return YES;

}








#pragma mark - lazy UI
- (void)confingUI {
    [self imgView];
    [self textField];
    if (self.configure.type == TextFieldVerificationType) {
        [self validationBtn];
        [self tipLab];
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imgView.mas_right).offset =AdaptedWidth(10);
            make.bottom.offset =0;
            make.top.offset =AdaptedHeight(5);
            make.right.offset =AdaptedWidth(-130);
        }];
    }
}


- (UIImageView *)imgView {
    if (!_imgView){
        _imgView = [UIImageView zj_imageViewWithImage:self.configure.imgName
                                            SuperView:self
                                          contentMode:UIViewContentModeScaleAspectFit
                                               isClip:NO
                                          constraints:^(MASConstraintMaker *make) {
                                              make.left.offset =AdaptedWidth(8);
                                              make.top.offset =AdaptedHeight(11);
                                              make.width.offset =AdaptedWidth(18);
                                              make.height.offset =AdaptedHeight(23);
                                          }];
    }
    return _imgView;
}


- (UITextField *)textField {
    if (!_textField){
        _textField = [UITextField zj_textFieldWithHolder:self.configure.placeholder
                                               superView:self
                                             constraints:^(MASConstraintMaker *make) {
                                                 make.left.mas_equalTo(self.imgView.mas_right).offset =AdaptedWidth(10);
                                                 make.bottom.offset =0;
                                                 make.top.offset =AdaptedHeight(5);
                                                 make.right.offset =AdaptedWidth(-8);
                                             }];
        _textField.tintColor = MainColor;
        _textField.textColor = TitleColor;
        _textField.font      = kFont_14;
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        if (self.configure.security) {

            if (@available(iOS 12.0, *)) {
                _textField.textContentType = UITextContentTypeNewPassword;
                _textField.passwordRules = [UITextInputPasswordRules passwordRulesWithDescriptor:@"required: lower; required: upper; allowe: digit; required: [-]; minlength: 5;"];
            } else {
                [_textField setTextContentType:UITextContentTypePassword];
            }
            _textField.secureTextEntry = self.configure.security;
        }
        
    }
    return _textField;
}


- (UIButton *)validationBtn {
    if (!_validationBtn){
        klWeakSelf;
        _validationBtn = [UIButton zj_buttonWithTitle:@"获取验证码"
                                           titleColor:[UIColor whiteColor]
                                             norImage:nil
                                        selectedImage:nil
                                            backColor:MainColor
                                             fontSize:15
                                               isBold:NO
                                         cornerRadius:0
                                              supView:self
                                          constraints:^(MASConstraintMaker *make) {
                                              make.right.top.bottom.offset =0;
                                              make.width.offset =AdaptedHeight(130);
                                          } touchUp:^(id sender) {
                                              weakSelf.validationBtn.hidden=YES;
                                              weakSelf.tipLab.hidden= NO;
                                              self->_timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dealTimer) userInfo:nil repeats:YES];
                                              self->_timer.fireDate=[NSDate distantPast];
                                          }];
    }
    return _validationBtn;
}


- (UILabel *)tipLab {
    if (!_tipLab){
        _tipLab = [UILabel zj_labelWithFontSize:14
                                      textColor:RGBSigle(51)
                                      superView:self
                                    constraints:^(MASConstraintMaker *make) {
                                        make.edges.mas_equalTo(self.validationBtn);
                                    }];
        _tipLab.textAlignment =NSTextAlignmentCenter;
        _tipLab.backgroundColor = BackgroundColor;
        _tipLab.hidden = YES;
    }
    return _tipLab;
}


- (void)dealTimer {
    
    _tipLab.text = [[NSString alloc]initWithFormat:@"(%lds)后重新获取",(long) self.configure.timeCount];
    self.configure.timeCount   = self.configure.timeCount - 1;
    if( self.configure.timeCount == -1){
        _timer.fireDate=[NSDate distantFuture];
        self.configure.timeCount = 60;
        _tipLab.hidden = YES;
        _validationBtn.hidden = NO;
    }
}


@end
