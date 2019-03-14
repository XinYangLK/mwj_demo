//
//  KLActivityButton.m
//  mwstreet
//
//  Created by 科pro on 2018/12/20.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLActivityButton.h"

@implementation KLActivityButton

- (instancetype)initActivityType:(ActivityType)type
{
    self = [super init];
    if (self) {
        
        [self conifyUI];
        
        switch (type) {
                
            case ActivityHorizontalType: //水平布局btn类型
                
                [self addSubview:self.decLable];

                [self activityHorizontalUICreate];
                
                break;
                
            case ActivityVerticalType: //垂直布局btn类型
                
                [self activityVerticalUICreate];
                
                break;
                
            default:
                break;
        }
    }
    return self;
}

//***  加载视图  **/
- (void)conifyUI{
    
    [self addSubview:self.titleLab];
    [self addSubview:self.bigImg];
}

//***  水平布局btn类型UI创建  **/
- (void)activityHorizontalUICreate {
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset =AdaptedWidth(-92);
        make.top.offset =AdaptedHeight(15);
        make.left.offset =AdaptedWidth(10);
        make.height.offset =AdaptedHeight(20);
    }];
    
    [self.decLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self->_titleLab);
        make.top.mas_equalTo(self->_titleLab.mas_bottom).offset =AdaptedHeight(10);
        make.height.offset =AdaptedHeight(12);
    }];
    
    [self.bigImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset =AdaptedHeight(67);
        make.right.offset =AdaptedWidth(-11);
        make.centerY.offset = 0;
    }];
    
}

//***  垂直布局btn类型UI创建  **/
- (void)activityVerticalUICreate {
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.top.offset =AdaptedWidth(9);
        make.height.offset =AdaptedHeight(10);
    }];
    
    [self.bigImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset =0;
        make.width.offset =AdaptedWidth(80);
        make.top.mas_equalTo(self->_titleLab.mas_bottom).offset =AdaptedHeight(10);
        make.bottom.offset =AdaptedHeight(-5);
    }];
}




//***  标题  **/
- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel createLabelTextColor:RGBSigle(51) font:AdaptedBOLDSYSFontSize(18)];
    }
    return _titleLab;
}
//***  活动描述 **/
- (UILabel *)decLable {
    if (!_decLable){
        _decLable = [UILabel createLabelTextColor:RGBSigle(142) font:kFont_12];
        _decLable.text =@"特价商品售完为止";

    }
    return _decLable;
}

//***  图片  **/
- (UIImageView *)bigImg {
    
    if (!_bigImg){
        _bigImg = [[UIImageView alloc]init];
        _bigImg.contentMode =UIViewContentModeScaleAspectFit;
    }
    return _bigImg;
}
















@end
