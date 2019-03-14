//
//  KLMyIntegralManagerCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/18.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyIntegralManagerCell.h"
@interface KLMyIntegralManagerCell ()
//***  背景图  **/
@property (nonatomic, strong) UIImageView * backGroundImg;
//***  积分数  **/
@property (nonatomic, strong) UILabel     * numberLab;
//***  积分text **/
@property (nonatomic, strong) UILabel     * textLab;


@end
@implementation KLMyIntegralManagerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self confingerUI];
    }
    return self;
}

- (void)setNumber:(NSString *)number {
    _number = number;
    self.numberLab.text = _number;
}

- (void)confingerUI {
    [self backGroundImg];
    [self numberLab];
    [self textLab];
}


- (UIImageView *)backGroundImg {
    if (!_backGroundImg){
        _backGroundImg = [UIImageView zj_imageViewWithImage:@"mengdoubg"
                                                  SuperView:self.contentView
                                                constraints:^(MASConstraintMaker *make) {
                                                    make.edges.mas_equalTo(self);
                                                }];
    }
    return _backGroundImg;
}

- (UILabel *)numberLab {
    if (!_numberLab){
        _numberLab = [UILabel zj_labelWithFontSize:18
                                             lines:1
                                              text:self.number
                                         textColor:RGBSigle(255)
                                         superView:self.contentView
                                       constraints:^(MASConstraintMaker *make) {
                                           make.centerX.offset = 0;
                                           make.top.offset =AdaptedHeight(25);
                                           make.width.offset =MainWidth - AdaptedWidth(60);
                                           make.height.offset = AdaptedHeight(18);
                                       }];
        _numberLab.backgroundColor =[UIColor clearColor];
        _numberLab.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLab;
}


- (UILabel *)textLab {
    if (!_textLab){
        _textLab = [UILabel zj_labelWithFontSize:15
                                             lines:1
                                              text:@"当前萌豆"
                                         textColor:RGBSigle(255)
                                         superView:self.contentView
                                       constraints:^(MASConstraintMaker *make) {
                                           make.centerX.offset = 0;
                                           make.top.mas_equalTo(self.numberLab.mas_bottom).offset =AdaptedHeight(15);
                                           make.width.offset =MainWidth -AdaptedWidth(60);
                                           make.height.offset = AdaptedHeight(15);
                                       }];
        _textLab.backgroundColor =[UIColor clearColor];
        _textLab.textAlignment = NSTextAlignmentCenter;
    }
    return _textLab;
}





@end
