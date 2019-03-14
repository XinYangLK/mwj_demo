//
//  KLMallActivityBtn.m
//  mwstreet
//
//  Created by 科pro on 2018/12/29.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLMallActivityBtn.h"

@implementation KLMallActivityBtn
- (instancetype)initActivityType:(ActivityType)type;{
    self =[super init];
    if (self) {
        
        [self setLayerCornerRadius:5];
        self.type = type;
        
        [self configerUI];
        switch (type) {
            case ActivityVerticalType://***  竖直布局  **/
            {
                [self ActivityVerticalUI];
            }
                break;
            case ActivityHorizontalType://***  横向布局  **/
            {
                [self ActivityHorizontalUI];
            }
                break;
                
            default:
                break;
        }
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w =[UILabel getWidthWithTitle:self.decLab.text font:self.decLab.font];
    switch (self.type) {
       
        case ActivityVerticalType://***  竖直布局  **/
        {
            [self.imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.offset = 0;
                make.height.offset =1;
                make.width.offset = w + AdaptedWidth(58);
                make.top.mas_equalTo(self.titleLab.mas_bottom).offset = AdaptedHeight(22);
            }];
            self.decLab.backgroundColor =self.backgroundColor;

            [self.decLab  mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.centerY.mas_equalTo(self.imgV);
                make.height.offset =AdaptedHeight(15);
                make.width.offset = w + AdaptedWidth(10);
            }];
        }
            break;
        case ActivityHorizontalType://***  横向布局  **/
        {
            [self.imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.titleLab);
                make.height.offset =AdaptedHeight(15);
                make.width.offset = w + AdaptedWidth(20);
                make.top.mas_equalTo(self.titleLab.mas_bottom).offset = AdaptedHeight(14);
            }];
            
            [self.decLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.centerY.mas_equalTo(self.imgV);
                make.height.offset =AdaptedHeight(13);
                make.width.offset = w;
            }];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark ------ 构建 UI
- (void)configerUI {
    
    [self addSubview:self.titleLab];
    [self addSubview:self.imgV];
    [self addSubview:self.decLab];
    [self addSubview:self.goodsImg];
}

//***  竖直布局  **/
- (void)ActivityVerticalUI{
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset =AdaptedHeight(15);
        make.centerX.offset =0;
        make.height.offset =AdaptedHeight(15);
        make.width.offset =AdaptedWidth(140);
    }];
    
    self.decLab.textColor =RGBSigle(51);
    self.imgV.backgroundColor =LineColor;
    
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.height.offset =1;
        make.width.offset = AdaptedWidth(60) + AdaptedWidth(48);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset = AdaptedHeight(22);
    }];
    [self.decLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.imgV);
        make.height.offset =AdaptedHeight(15);
        make.width.offset = AdaptedWidth(60) + AdaptedWidth(10);
    }];
    
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(15);
        make.right.offset =AdaptedWidth(-15);
        make.bottom.offset =AdaptedHeight(-10);
        make.top.mas_equalTo(self.decLab.mas_bottom).offset =AdaptedHeight(8);
    }];
    
}

//***  横向布局  **/
- (void)ActivityHorizontalUI{
    
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset =AdaptedHeight(18);
        make.left.offset =AdaptedWidth(10);
        make.height.offset =AdaptedHeight(15);
        make.width.offset =AdaptedWidth(80);
    }];
    
    self.decLab.textColor =RGBSigle(255);
    self.imgV.backgroundColor =LineColor;
    
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.titleLab);
        make.height.offset =AdaptedHeight(15);
        make.width.offset = AdaptedWidth(90);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset = AdaptedHeight(14);
    }];
    
    [self.decLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.imgV);
        make.height.offset =AdaptedHeight(13);
        make.width.offset = AdaptedWidth(80);
    }];
    
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset =0;
        make.right.offset =AdaptedWidth(-5);
        make.width.offset =AdaptedWidth(65);
        make.height.offset =AdaptedHeight(90);
    }];
    
}




- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [[UILabel alloc]init];
    }
    return _titleLab;
}

- (UILabel *)decLab {
    if (!_decLab){
        _decLab = [[UILabel alloc]init];
        _decLab.textAlignment =NSTextAlignmentCenter;
        _decLab.font =kFont_10;
    }
    return _decLab;
}

- (UIImageView *)imgV {
    if (!_imgV){
        _imgV = [[UIImageView alloc]init];
    }
    return _imgV;
}
- (UIImageView *)goodsImg {
    if (!_goodsImg){
        _goodsImg = [[UIImageView alloc]init];
        _goodsImg.contentMode =UIViewContentModeScaleAspectFit;
    }
    return _goodsImg;
}


@end
