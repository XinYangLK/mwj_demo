//
//  KLMyDisInputView.m
//  mwstreet
//
//  Created by 科pro on 2019/2/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyDisInputView.h"

@interface KLMyDisInputView ()<UITextFieldDelegate>
{
    NSString    *_previousTextFieldContent;
    UITextRange *_previousSelection;
}
@property (nonatomic, strong) KLMyDisInputConfigure * configure;

@property (nonatomic, strong) UILabel     * titleLab;
@property (nonatomic, strong) UIButton * sexMaleBtn;
@property (nonatomic, strong) UIButton * sexFemaleBtn;
@end

@implementation KLMyDisInputView

- (instancetype)initWithConfigure:(KLMyDisInputConfigure *)configure {
    self =[super init];
    if (self) {
        
        self.configure = configure;
        
        [self configerUI];
        
        if ([configure.placeholder hasSuffix:@"手机号"]) {
            self.textField.delegate = self;
            self.textField.keyboardType=UIKeyboardTypeNumberPad;
            [self.textField addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];
        }
    }
    return self;
}


#pragma mark - 输入手机号处理
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
- (void)configerUI {
    
   
    if(self.configure.type == MyTextEidtTitleInput){
       
        [self titleLab];
        [self textField];
   
    }else if (self.configure.type == MyTextEidtTextInput) {
        
        [self textField];
        
    }else if(self.configure.type == MyTextEidtSexChange) {
        
        [self titleLab];
        [self addSubview:self.sexMaleBtn];
        [self addSubview:self.sexFemaleBtn];
        
        [self.sexMaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(30);
            make.width.offset   = AdaptedWidth(35);
            make.height.offset  = AdaptedHeight(40);
            make.centerY.offset = 0;
        }];
        
        [self.sexFemaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.sexMaleBtn.mas_right).offset =AdaptedWidth(39);
            make.width.height.centerY.mas_equalTo(self.sexMaleBtn);
        }];
    }
}


- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:self.configure.title
                                        textColor:TitleColor
                                        superView:self
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset    = AdaptedWidth(15);
                                          make.width.offset   = AdaptedWidth(45);
                                          make.centerY.offset = 0;
                                          make.height.offset  = AdaptedHeight(30);
                                      }];
    }
    return _titleLab;
}


- (UITextField *)textField {
    if (!_textField){
        
        _textField = [UITextField zj_textFieldWithHolder:self.configure.placeholder
                                               superView:self
                                             constraints:^(MASConstraintMaker *make) {
                                                 if ([NSString isBlankString:self.configure.title]) {
                                                     make.left.offset = AdaptedWidth(10);
                                                 }else{
                                                     make.left.mas_equalTo(self.titleLab.mas_right).offset = AdaptedWidth(10);
                                                 }
                                                 make.left.mas_equalTo(self.titleLab.mas_right).offset = AdaptedWidth(10);
                                                 make.centerY.offset = 0;
                                                 make.top.offset     = AdaptedHeight(5);
                                                 make.right.offset   = AdaptedWidth(-8);
                                             }];
        _textField.tintColor = MainColor;
        _textField.textColor = TitleColor;
        _textField.font      = kFont_14;
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}



- (UIButton *)sexMaleBtn {
    if (!_sexMaleBtn){
        klWeakSelf;
        _sexMaleBtn = [UIButton createBtnTitle:@"男" titleColor:MainColor font:kFont_12 imageName:@"nan" backgrounColor:[UIColor clearColor] SSImagePositionType:SSImagePositionTypeLeft spacing:4 action:^(UIButton * _Nonnull button) {
            UIButton * nvBtn =[weakSelf viewWithTag:51];
            [nvBtn setImage:[UIImage imageNamed:@"nv_h"] forState:UIControlStateNormal];
            [nvBtn setTitleColor:RGBSigle(153) forState:UIControlStateNormal];
            
            [button setImage:[UIImage imageNamed:@"nan"] forState:UIControlStateNormal];
            [button setTitleColor:MainColor forState:UIControlStateNormal];
            weakSelf.sexChangeBlock ? weakSelf.sexChangeBlock(button) : nil;
        }];
        _sexMaleBtn.tag =50;
    }
    return _sexMaleBtn;
}

- (UIButton *)sexFemaleBtn {
    if (!_sexFemaleBtn){
        klWeakSelf;
        _sexFemaleBtn = [UIButton createBtnTitle:@"女" titleColor:RGBSigle(153) font:kFont_12 imageName:@"nv_h" backgrounColor:[UIColor clearColor] SSImagePositionType:SSImagePositionTypeLeft spacing:4 action:^(UIButton * _Nonnull button) {
            UIButton * maleBtn =[weakSelf viewWithTag:50];
            [maleBtn setImage:[UIImage imageNamed:@"nan_h"] forState:UIControlStateNormal];
            [maleBtn setTitleColor:RGBSigle(153) forState:UIControlStateNormal];
            
            [button setImage:[UIImage imageNamed:@"nv"] forState:UIControlStateNormal];
            [button setTitleColor:MainColor forState:UIControlStateNormal];
            weakSelf.sexChangeBlock ? weakSelf.sexChangeBlock(button) : nil;
        }];
        _sexFemaleBtn.tag =51;
    }
    return _sexFemaleBtn;
}

@end
