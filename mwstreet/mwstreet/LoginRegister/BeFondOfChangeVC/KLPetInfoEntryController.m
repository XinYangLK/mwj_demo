//
//  KLPetInfoEntryController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/18.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLPetInfoEntryController.h"

@interface KLPetInfoEntryController ()

@property (nonatomic, strong) UIButton    * petImgBtn;  //上传宠物图像
@property (nonatomic, strong) UILabel     * hintTitle;  //上传提示语
@property (nonatomic, strong) UITextField * textField;  //录入宠物名称
@property (nonatomic, strong) UIButton    * confirmBtn; //确认完成录入

@property (nonatomic, strong) NSString * petName;
@end

@implementation KLPetInfoEntryController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"添加宠物"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self petImgBtn];
    [self hintTitle];
    [self textField];
    [self confirmBtn];
}

//***  上传图像  **/
- (void)upLoadingPetImgChick:(UIButton *)sender {
    KLLog(@"上传图像");
}
//***  获取宠物名称  **/
- (void)textFieldEditChanged:(UITextField *)textField {
    
    KLLog(@"=========%@",textField.text);
    self.petName = textField.text;
}
//***  完成  **/
- (void)confirmChick:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
     KLLog(@"完成");
}


#pragma mark - lazy UI

- (UIButton *)petImgBtn {
    if (!_petImgBtn){
        klWeakSelf;
        _petImgBtn = [UIButton zj_buttonWithNorImage:@"tx-h"
                                        cornerRadius:AdaptedHeight(30)
                                             supView:self.view
                                         constraints:^(MASConstraintMaker *make) {
                                             make.centerX.offset = 0;
                                             make.height.width.offset =AdaptedHeight(60);
                                             make.top.offset =AdaptedHeight(21);
                                         } touchUp:^(id sender) {
                                             [weakSelf upLoadingPetImgChick:sender];
                                         }];
    }
    return _petImgBtn;
}


- (UILabel *)hintTitle {
    if (!_hintTitle){
        _hintTitle = [UILabel zj_labelWithFont:AdaptedSYSFontSize(14)
                                         lines:1
                                          text:@"上传宠物图像"
                                     textColor:TextColor
                                     superView:self.view
                                   constraints:^(MASConstraintMaker *make) {
                                       make.centerX.offset = 0;
                                       make.top.mas_equalTo(self.petImgBtn.mas_bottom).offset =AdaptedHeight(26);
                                       make.height.offset =AdaptedHeight(15);
                                       make.width.offset =MainWidth -AdaptedWidth(60);
                                   }];
        _hintTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _hintTitle;
}

- (UITextField *)textField {
    if (!_textField){
        _textField = [UITextField zj_textFieldWithHolder:@"请输入宠物名称"
                                               superView:self.view
                                             constraints:^(MASConstraintMaker *make) {
                                                 make.top.mas_equalTo(self.hintTitle.mas_bottom).offset =AdaptedWidth(36);
                                                 make.height.offset =AdaptedHeight(49);
                                                 make.width.offset = MainWidth -AdaptedWidth(50);
                                                 make.centerX.offset = 0;
                                             }];
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.tintColor = MainColor;
        _textField.textColor = TitleColor;
        _textField.font      = kFont_14;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_textField setLayerCornerRadius:AdaptedHeight(24) borderWidth:1 borderColor:LineColor];
        [_textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn){
        klWeakSelf;
        _confirmBtn = [UIButton zj_buttonWithTitle:@"完成"
                                        titleColor:[UIColor whiteColor]
                                         backColor:MainColor
                                          fontSize:16
                                            isBold:YES
                                      cornerRadius:AdaptedHeight(24)
                                           supView:self.view
                                       constraints:^(MASConstraintMaker *make) {
                                           make.centerX.offset = 0;
                                           make.bottom.offset  = - AdaptedHeight(22)- TabbarSafeBottomMargin;
                                           make.width.offset   = MainWidth -AdaptedWidth(40);
                                           make.height.offset  = AdaptedHeight(49);
                                       } touchUp:^(id sender) {
                                           [weakSelf confirmChick:sender];
                                       }];
    }
    return _confirmBtn;
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
