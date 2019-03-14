//
//  KLMyDistributionApplyVC.m
//  mwstreet
//
//  Created by 科pro on 2019/2/1.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyDistributionApplyVC.h"
#import "KLMyDistributionCenterVC.h"
#import "KLMyDisInputConfigure.h"
#import "KLMyDisInputView.h"

@interface KLMyDistributionApplyVC ()
@property (nonatomic, strong) UILabel     * titleLab;
@property (nonatomic, strong) UITextField * nameField;
@property (nonatomic, strong) UITextField * phoneField;
@property (nonatomic, strong) UITextField * ageField;
@property (nonatomic, strong) UITextField * sexField;
@property (nonatomic, strong) UIButton    * submitBtn;

@property (nonatomic, strong) KLMyDisInputView * phoneInputView;

@property (nonatomic, strong) NSString * nameStr;
@property (nonatomic, strong) NSString * phoneStr;
@property (nonatomic, strong) NSString * ageStr;
@property (nonatomic, strong) NSString * sexStr;


@end

@implementation KLMyDistributionApplyVC


- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"分销"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self titleLab];
    [self nameField];
    [self phoneInputView];
    [self ageField];
    [self sexField];
    [self submitBtn];
}

#pragma mark - 提交申请
- (void)didSubmitChick:(UIButton *)sender {
    
    KLLog(@"提交 \n %@ \n %@ \n %@ \n %@",self.nameStr,self.phoneStr,self.ageStr,self.sexStr);
    KLMyDistributionCenterVC *vc =[[KLMyDistributionCenterVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}


//***  获取 输入框中的值  **/
- (void)textFieldEditChanged:(UITextField *)textField {
    
    switch (textField.tag) {
        case 7:
            self.nameStr = textField.text;
            break;
        case 8:
            self.phoneStr = textField.text;
            break;
        case 9:
            self.ageStr = textField.text;
            break;
        case 10:
            self.sexStr = textField.text;
            break;
            
        default:
            break;
    }
}



#pragma mark - lazy UI

- (UILabel *)titleLab {
 
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:@"立即申请"
                                        textColor:RGBSigle(51)
                                        superView:self.view
                                      constraints:^(MASConstraintMaker *make) {
                                          make.centerX.offset =0;
                                          make.width.offset =AdaptedWidth(100);
                                          make.height.offset =AdaptedHeight(15);
                                          make.top.offset =AdaptedHeight(28);
                                      }];
        _titleLab.textAlignment =NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UITextField *)nameField {
    if (!_nameField){
        _nameField = [self creatTextField:_nameField PlaceHolder:@"请输入您的姓名" tag:7];
        [self.view addSubview:_nameField];
        [_nameField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset =0;
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset = AdaptedHeight(26);
            make.height.offset =AdaptedHeight(30);
            make.width.offset =MainWidth -AdaptedWidth(106);
        }];
    }
    return _nameField;
}

- (KLMyDisInputView *)phoneInputView {
    if (!_phoneInputView){
        
        KLMyDisInputConfigure *configure =[KLMyDisInputConfigure textInputConfigure];
        configure.type  = MyTextEidtTextInput;
        configure.placeholder =@"请输入您的手机号";
        _phoneInputView = [[KLMyDisInputView alloc]initWithConfigure:configure];
        [_phoneInputView.textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        _phoneInputView.textField.tag = 8;
        [_phoneInputView setLayerCornerRadius:AdaptedHeight(15) borderWidth:0 borderColor:[UIColor clearColor]];
        _phoneInputView.backgroundColor = RGBSigle(238);
        [self.view addSubview:_phoneInputView];
        [_phoneInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameField.mas_bottom).offset = AdaptedHeight(18);
            make.centerX.width.height.mas_equalTo(self.nameField);
        }];
        
//        _phoneField = [self creatTextField:_phoneField PlaceHolder:@"请输入您的手机号" tag:8];
//        [self.view addSubview:_phoneField];
//        [_phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        }];
    }
    return _phoneInputView;
}

- (UITextField *)ageField {
    if (!_ageField){
        _ageField = [self creatTextField:_ageField PlaceHolder:@"年龄" tag:9];
        [self.view addSubview:_ageField];
        [_ageField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneInputView.mas_bottom).offset = AdaptedHeight(18);
            make.centerX.width.height.mas_equalTo(self.nameField);
        }];
    }
    return _ageField;
}

- (UITextField *)sexField {
    if (!_sexField){
        _sexField = [self creatTextField:_sexField PlaceHolder:@"性别" tag:10];
        [self.view addSubview:_sexField];
        [_sexField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.ageField.mas_bottom).offset = AdaptedHeight(18);
            make.centerX.width.height.mas_equalTo(self.nameField);
        }];
    }
    return _sexField;
}


- (UIButton *)submitBtn {
    if (!_submitBtn){
        klWeakSelf;
        _submitBtn = [UIButton zj_buttonWithTitle:@"立即申请"
                                       titleColor:RGBSigle(255)
                                         norImage:nil
                                    selectedImage:nil
                                        backColor:MainColor
                                         fontSize:14
                                           isBold:NO
                                      borderWidth:0
                                      borderColor:[UIColor clearColor]
                                     cornerRadius:AdaptedHeight(15)
                                          supView:self.view
                                      constraints:^(MASConstraintMaker *make) {
                                          make.top.mas_equalTo(self.sexField.mas_bottom).offset = AdaptedHeight(18);
                                          make.centerX.width.height.mas_equalTo(self.nameField);
                                      } touchUp:^(id sender) {
                                          [weakSelf didSubmitChick:sender];
                                      }];
    }
    return _submitBtn;
}


- (UITextField *)creatTextField:(UITextField *)textField PlaceHolder:(NSString *)holder tag:(NSInteger)tag{
   
    textField =[[UITextField alloc]init];
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(-AdaptedWidth(30), 0, AdaptedWidth(10), AdaptedHeight(30))];
    textField.tintColor = MainColor;
    textField.font = kFont_12;
    textField.tag = tag;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.leftViewMode = UITextFieldViewModeAlways; //此处用来设置leftview显示时机
    textField.backgroundColor = RGBSigle(238);
    textField.placeholder = holder;
    [textField setLayerCornerRadius:AdaptedHeight(15) borderWidth:0 borderColor:[UIColor clearColor]];
    [textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    
    return textField;
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
