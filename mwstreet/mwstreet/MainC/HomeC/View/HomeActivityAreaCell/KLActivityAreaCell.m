//
//  KLActivityAreaCell.m
//  mwstreet
//
//  Created by 科pro on 2018/12/20.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLActivityAreaCell.h"
#import "KLCountDownManager.h"
#import "KLCountdownModel.h"

#define NotificationManager ([NSNotificationCenter defaultCenter])

@implementation KLActivityAreaCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        
        [self createUI];
        
    }
    return self;
}


#pragma mark ------ 构建 UI 布局
- (void)createUI {
    
    [self.contentView addSubview:self.backBtn];
    [self.backBtn addSubview:self.titleLab];
    [self.backBtn addSubview:self.decLable];
    [self.backBtn addSubview:self.bigImg];
    [self.backBtn addSubview:self.countdownView];

    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(10);
        make.height.offset =AdaptedHeight(204);
        make.width.offset =AdaptedWidth(142);
        make.top.offset = 0;
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset =AdaptedHeight(15);
        make.right.offset =AdaptedWidth(-21);
        make.left.offset =AdaptedWidth(20);
        make.height.offset =AdaptedHeight(20);
    }];
    
    [self.decLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_titleLab.mas_bottom).offset =AdaptedHeight(8);
        make.left.right.mas_equalTo(self->_titleLab);
        make.height.offset =AdaptedHeight(15);
    }];
    
    [self.countdownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(20);
        make.height.offset =AdaptedWidth(22);
        make.top.mas_equalTo(self.decLable.mas_bottom).offset =AdaptedHeight(6);
        make.width.offset =AdaptedWidth(100);
    }];
    
    
    [self.bigImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.width.offset =AdaptedWidth(100);
        make.top.mas_equalTo(self->_countdownView.mas_bottom).offset =AdaptedHeight(10);
        make.bottom.offset =AdaptedHeight(-5);
    }];
    
    
    
    [self.contentView addSubview:self.specialBtn];
    [self.contentView addSubview:self.bargainBtn];
    [self.contentView addSubview:self.activeBtn];
    
    
    [self.specialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_backBtn.mas_right).offset =AdaptedWidth(8);;
        make.right.offset =AdaptedWidth(-10);
        make.height.offset =AdaptedHeight(73);
        make.top.offset = 0;
    }];
    
    CGFloat w = (MainWidth - AdaptedWidth(178))/2 ;

    [self.bargainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_specialBtn);
        make.top.mas_equalTo(self->_specialBtn.mas_bottom).offset = AdaptedHeight(8);
        make.bottom.mas_equalTo(self->_backBtn.mas_bottom);
        make.width.offset = w;
    }];
    
  
    [self.activeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.mas_equalTo(self->_bargainBtn);
        make.left.mas_equalTo(self->_bargainBtn.mas_right).offset =AdaptedWidth(8);
    }];
    
}




//***  小图标  **/
- (UIView *)backBtn {
    
    if (!_backBtn){
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.backgroundColor =RGB(232, 239, 255);
        [_backBtn setLayerCornerRadius:5];
        _backBtn.tag =53;
        [_backBtn addTarget:self action:@selector(btnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
//***  标题  **/
- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [[UILabel alloc]init];
        _titleLab.font =AdaptedBOLDSYSFontSize(18);
        _titleLab.textColor =RGBSigle(51);
        _titleLab.textAlignment =NSTextAlignmentRight;
        _titleLab.textColor =RGB(206, 147, 216);
        _titleLab.text =@"限时抢购";
    }
    return _titleLab;
}
//***  活动描述 **/
- (UILabel *)decLable {
    if (!_decLable){
        _decLable = [[UILabel alloc]init];
        _decLable.font =kFont_12;
        _decLable.textColor =RGBSigle(142);
        _decLable.text =@"特价商品售完为止";
        
    }
    return _decLable;
}

//***  倒计时 View  **/
- (KLCountdownView *)countdownView {
    if (!_countdownView){
        _countdownView = [[KLCountdownView alloc]initWithFrame:CGRectZero size:AdaptedWidth(22)];
    }
    return _countdownView;
}


//***  图片  **/
- (UIImageView *)bigImg {
    
    if (!_bigImg){
        _bigImg = [[UIImageView alloc]init];
        _bigImg.image =[UIImage imageNamed:@"pic_2"];
        _bigImg.contentMode =UIViewContentModeScaleAspectFit;
    }
    return _bigImg;
}


//***  今日特价  **/
- (KLActivityButton *)specialBtn {
    if (!_specialBtn){
        _specialBtn = [[KLActivityButton alloc]initActivityType:ActivityHorizontalType];
        _specialBtn.backgroundColor = RGB(239,253,255);
        _specialBtn.titleLab.textAlignment =NSTextAlignmentRight;
        _specialBtn.decLable.textAlignment =NSTextAlignmentRight;
        _specialBtn.bigImg.image =[UIImage imageNamed:@"pic_1"];
        _specialBtn.titleLab.text =@"今日特价";
        _specialBtn.titleLab.textColor =RGB(244,143,177);
        _specialBtn.tag = 54;
        [_specialBtn addTarget:self action:@selector(btnChick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _specialBtn;
}

//***  砍价  **/
- (KLActivityButton *)bargainBtn {
    if (!_bargainBtn){
        _bargainBtn = [[KLActivityButton alloc]initActivityType:ActivityVerticalType];
        _bargainBtn.backgroundColor = RGB(255, 239, 239);
        _bargainBtn.bigImg.image =[UIImage imageNamed:@"pic_3"];
        _bargainBtn.titleLab.text =@"砍价";
        _bargainBtn.titleLab.textColor =RGB(252,111,102);
        _bargainBtn.tag = 55;
        [_bargainBtn addTarget:self action:@selector(btnChick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _bargainBtn;
    
}
//***  9.9特价  **/
- (KLActivityButton *)activeBtn {
    if (!_activeBtn){
        _activeBtn = [[KLActivityButton alloc]initActivityType:ActivityVerticalType];
        _activeBtn.backgroundColor = RGB(251, 239, 255);
        _activeBtn.bigImg.image =[UIImage imageNamed:@"pic_4"];
        _activeBtn.titleLab.text =@"9.9包邮";
        _activeBtn.titleLab.textColor =RGB(253,150,88);
        _activeBtn.tag = 56;
        [_activeBtn addTarget:self action:@selector(btnChick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _activeBtn;
}



//***  活动按钮点击事件  **/
- (void)btnChick:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didActivityBtnChick:)]) {
        [self.delegate didActivityBtnChick:sender];
    }
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
