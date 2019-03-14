//
//  KLMyPetViewController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyPetViewController.h"
#import "KLMyPetInputView.h"

@interface KLMyPetViewController ()

@property (nonatomic, strong) UIButton * saveBtn;
@property (nonatomic, strong) UIButton * imgBtn;
@property (nonatomic, strong) UILabel  * titleLab;
@property (nonatomic, strong) UIView   * lineView;
@property (nonatomic, strong) KLMyPetInputView *petClassifyView;
@property (nonatomic, strong) KLMyPetInputView *petNameView;
@property (nonatomic, strong) KLMyPetInputView *petSexView;
@property (nonatomic, strong) KLMyPetInputView *petBothdayView;
@end

@implementation KLMyPetViewController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"我的爱宠"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    [self configerUI];
}

#pragma mark ------ 保存按钮点击事件
- (void)saveBtnChick:(UIButton *)sender {
    
    KLLog(@"保存按钮");
}



//***  选择宠物生日  **/
- (void)bothdayChangeBtnChick:(UIButton *)sender {
    
    [ZJDatePickerView zj_showDatePickerWithTitle:@"请选择宠物生日" dateType:ZJDatePickerModeYMD defaultSelValue:nil minDate:[NSDate getDate:-30] maxDate:[NSDate getDate:9] isAutoSelect:YES lineColor:MainColor rowHeight:AdaptedHeight(35) leftBtnTitleColor:TextColor rightBtnTitleColor:MainColor selecteRowTextColor:TitleColor selectRowBGColor:RGBSigle(255) resultBlock:^(NSString *selectValue) {
//        NSLog(@"%@",selectValue);
        
        [sender setTitle:selectValue forState:UIControlStateNormal];
        
    } cancelBlock:^{
        
    }];
}




#pragma mark ------ lazy -- UI

- (void)configerUI {
    [self.view addSubview:self.imgBtn];
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.petClassifyView];
    [self.view addSubview:self.petNameView];
    [self.view addSubview:self.petSexView];
    [self.view addSubview:self.petBothdayView];
    [self.view addSubview:self.saveBtn];
    
    [self.imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset =0;
        make.top.offset =AdaptedHeight(20);
        make.width.height.offset =AdaptedHeight(61);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgBtn.mas_bottom).offset =AdaptedHeight(26);
        make.height.offset =AdaptedHeight(15);
        make.width.offset =AdaptedWidth(150);
        make.centerX.offset =0;
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset =0;
        make.height.offset =AdaptedHeight(5);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset =AdaptedHeight(21);
    }];
    
    [self.petClassifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = AdaptedWidth(48);
        make.right.offset =AdaptedWidth(-50);
        make.height.offset =AdaptedHeight(28);
        make.top.mas_equalTo(self.lineView.mas_bottom).offset =AdaptedHeight(15);
    }];
    [self.petNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.right.left.mas_equalTo(self.petClassifyView);
        make.top.mas_equalTo(self.petClassifyView.mas_bottom).offset = AdaptedHeight(20);
    }];
    [self.petSexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.right.left.mas_equalTo(self.petClassifyView);
        make.top.mas_equalTo(self.petNameView.mas_bottom).offset = AdaptedHeight(20);
    }];
    [self.petBothdayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.right.left.mas_equalTo(self.petClassifyView);
        make.top.mas_equalTo(self.petSexView.mas_bottom).offset = AdaptedHeight(20);
    }];
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset =MainWidth - AdaptedWidth(90);
        make.height.offset = AdaptedHeight(34);
        make.top.mas_equalTo(self.petBothdayView.mas_bottom).offset =AdaptedHeight(59);
        make.centerX.offset =0;
    }];
}





- (UIButton *)imgBtn {
    if (!_imgBtn){
        _imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imgBtn setBackgroundImage:[UIImage imageNamed:@"tx-h"] forState:UIControlStateNormal];
    }
    return _imgBtn;
}
- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel createLabelTextColor:RGBSigle(153) font:kFont_14];
        _titleLab.text =@"上传宠物图像";
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UIView *)lineView {
    if (!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = SpacColor;
    }
    return _lineView;
}

- (KLMyPetInputView *)petClassifyView {
    if (!_petClassifyView){
        _petClassifyView = [[KLMyPetInputView alloc]initWithFrame:CGRectZero eidtType:MyPetEidtTextInput];
        _petClassifyView.titleLab.text =@"宠物类别";
        _petClassifyView.textField.placeholder =@"宝贝品种";
    }
    return _petClassifyView;

}
- (KLMyPetInputView *)petNameView {
    if (!_petNameView){
        _petNameView = [[KLMyPetInputView alloc]initWithFrame:CGRectZero eidtType:MyPetEidtTextInput];
        _petNameView.titleLab.text =@"宠物名称";
        _petNameView.textField.placeholder =@"宝贝名称";
    }
    return _petNameView;
    
}
- (KLMyPetInputView *)petSexView {
    if (!_petSexView){
        _petSexView = [[KLMyPetInputView alloc]initWithFrame:CGRectZero eidtType:MyPetEidtSexChange];
        _petSexView.titleLab.text =@"宠物性别";
    }
    return _petSexView;
    
}
- (KLMyPetInputView *)petBothdayView {
    if (!_petBothdayView){
        _petBothdayView = [[KLMyPetInputView alloc]initWithFrame:CGRectZero eidtType:MyPetEidtDateChange];
        _petBothdayView.titleLab.text =@"宠物生日";
        [_petBothdayView.dateBtn setTitle:@"宝贝生日" forState:UIControlStateNormal];
        [_petBothdayView.dateBtn addTarget:self action:@selector(bothdayChangeBtnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _petBothdayView;
    
}

- (UIButton *)saveBtn {
    if (!_saveBtn){
        _saveBtn = [[UIButton alloc]init];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveBtn setBackgroundImage:[UIImage imageWithColor:MainColor] forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = kFont_15;
        [_saveBtn setLayerCornerRadius:AdaptedHeight(16.5)];
        [_saveBtn addTarget:self action:@selector(saveBtnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
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
