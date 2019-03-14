//
//  KLLoginViewController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/17.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLLoginViewController.h"
#import "KLTextInputConfigure.h"
#import "KLTextInputView.h"

@interface KLLoginViewController ()

@property (nonatomic, strong) KLTextInputView * accoutView;
@property (nonatomic, strong) KLTextInputView * passwordView;
@property (nonatomic, strong) KLTextInputView * verCodeView;
@property (nonatomic, strong) UIButton        * forgetBtn;
@property (nonatomic, strong) UIButton        * confirmBtn;
@property (nonatomic, strong) UILabel         * titlelab;
@property (nonatomic, strong) UIView          * line;
@property (nonatomic, strong) NSArray         * imageArray;

@end

@implementation KLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self configerUI];
    self.imageArray =@[@"weixin",@"qq",@"weib"];
    [self creatThreePartiesLoginBtn:self.imageArray];
}

#pragma mark - 登录 / 三方登录
- (void)threePartiesLoginBtnChick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 18:
            KLLog(@"===登录 ===");
            break;
        case 22:
            KLLog(@"===微信登录 ===");
            break;
        case 23:
            KLLog(@"===QQ登录 ===");
            break;
        case 24:
            KLLog(@"===微博登录 ===");
            break;
            
        default:
            break;
    }
}
#pragma mark - 找回密码
- (void)forgetPasswordBtnChick:(UIButton *)sender {
     KLLog(@"===找回密码 ===");
}







#pragma mark - lazy -- UI
- (void)configerUI {
    [self.view addSubview:self.accoutView];
    [self.view addSubview:self.passwordView];
    [self forgetBtn];
    [self confirmBtn];
    [self line];
    [self titlelab];
    
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
  ;
}

- (KLTextInputView *)accoutView {
    if (!_accoutView){
        KLTextInputConfigure * configure =[KLTextInputConfigure textInputConfigure];
        configure.imgName     = @"shouji";
        configure.placeholder = @"请输入手机号";
        configure.type        = TextFieldDefaultType;
        _accoutView = [[KLTextInputView alloc]initWithFrame:CGRectZero configure:configure];
//        _accoutView.textField.delegate =self;
    }
    return _accoutView;
}
//限制最大输入字数限制
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
//{
//    if (textField == _accoutView.textField) {
//
//        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//        if(range.location==0) {
//            if(toBeString.integerValue >1)
//            {
//                return NO;
//            }
//        }
//        if ([toBeString length] > 13) {
//
//            return NO;
//        }
//    }
//    if([string hasSuffix:@" "])     // 忽视空格
//        return NO;
//    else
//        return YES;
//    return YES;
//}




- (KLTextInputView *)passwordView {
    if (!_passwordView){
        KLTextInputConfigure * configure =[KLTextInputConfigure textInputConfigure];
        configure.imgName     = @"mimasuo";
        configure.placeholder = @"请输入密码";
        configure.type        = TextFieldDefaultType;
        configure.security    = YES;
        _passwordView = [[KLTextInputView alloc]initWithFrame:CGRectZero configure:configure];
    }
    return _passwordView;
}

- (UIButton *)forgetBtn {
    if (!_forgetBtn){
        klWeakSelf;
        _forgetBtn = [UIButton zj_buttonWithTitle:@"找回密码"
                                       titleColor:MainColor
                                        backColor:[UIColor clearColor]
                                         fontSize:12
                                           isBold:YES
                                     cornerRadius:0
                                          supView:self.view
                                      constraints:^(MASConstraintMaker *make) {
                                          make.top.mas_equalTo(self.passwordView.mas_bottom).offset =AdaptedHeight(6);
                                          make.right.mas_equalTo(self.passwordView);
                                          make.height.offset =AdaptedHeight(20);
                                          make.width.offset =AdaptedWidth(100);
                                      } touchUp:^(id sender) {
                                          [weakSelf forgetPasswordBtnChick:sender];
                                      }];
        [_forgetBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
    return _forgetBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn){
        klWeakSelf;
        _confirmBtn = [UIButton zj_buttonWithTitle:@"登录"
                                        titleColor:[UIColor whiteColor]
                                         backColor:MainColor
                                          fontSize:18
                                            isBold:YES
                                      cornerRadius:AdaptedHeight(21)
                                           supView:self.view
                                       constraints:^(MASConstraintMaker *make) {
                                           make.centerX.height.width.mas_equalTo(self.accoutView);
                                           make.top.mas_equalTo(self.passwordView.mas_bottom).offset = AdaptedHeight(35);
                                       } touchUp:^(id sender) {
                                           [weakSelf threePartiesLoginBtnChick:sender];
                                       }];
        _confirmBtn.tag = 18;
    }
    return _confirmBtn;
}


- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.view
                                 constraints:^(MASConstraintMaker *make) {
                                     make.centerX.offset =0;
                                     make.width.offset = MainWidth -AdaptedWidth(40);
                                     make.height.offset =0.5f;
                                     make.top.mas_equalTo(self.confirmBtn.mas_bottom).offset = AdaptedHeight(46);
                                 }];
    }
    return _line;
}

- (UILabel *)titlelab {
    if (!_titlelab){
        _titlelab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:@"第三方登录"
                                        textColor:TextColor
                                        superView:self.view
                                      constraints:^(MASConstraintMaker *make) {
                                          make.centerX.centerY.mas_equalTo(self.line);
                                          make.height.offset =AdaptedHeight(15);
                                          make.width.offset =AdaptedWidth(90);
                                      }];
        _titlelab.textAlignment =NSTextAlignmentCenter;
    }
    return _titlelab;
}


- (void)creatThreePartiesLoginBtn:(NSArray *)imageArray {
    //单行布局 不需要考虑换行的问题
    CGFloat marginX = AdaptedWidth(80);  //按钮距离左边和右边的距离
//    CGFloat marginY = 0;  //按钮距离布局顶部的距离
//    CGFloat toTop = 0;  //布局区域距离顶部的距离
    CGFloat gap = AdaptedWidth(45);    //按钮与按钮之间的距离
    NSInteger col = imageArray.count;    //这里只布局3列
    NSInteger count = imageArray.count;  //这里先设置布局3个按钮
    CGFloat itemWidth = (MainWidth - marginX *2 - (col - 1)*gap)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
    CGFloat height = itemWidth;   //按钮的高度可以根据情况设定 这里设置为相等
    
    UIButton *lastItem = nil;   //上一个按钮
    //准备工作完毕 既可以开始布局了
    for (int i = 0 ; i < count; i++) {
        
        UIButton * loginBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        loginBtn.tag = i + 22;
        [loginBtn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [loginBtn addTarget:self action:@selector(threePartiesLoginBtnChick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loginBtn];
        //布局
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            //宽高是固定的，前面已经算好了
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(height);
            //topTop距离顶部的距离，单行不用考虑太多，多行，还需要计算距离顶部的距离
            make.top.mas_equalTo(self.line.mas_bottom).offset =AdaptedHeight(30);
            if (!lastItem) {  //last为nil 说明是第一个按钮
                make.left.mas_offset(marginX);
            }else{
                //第二个或者后面的按钮 距离前一个按钮右边的距离都是gap个单位
                make.left.mas_equalTo(lastItem.mas_right).mas_offset(gap);
            }
        }];
        lastItem = loginBtn;
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
