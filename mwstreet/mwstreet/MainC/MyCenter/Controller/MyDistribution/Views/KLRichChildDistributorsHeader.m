//
//  KLRichChildDistributorsHeader.m
//  mwstreet
//
//  Created by 科pro on 2019/2/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLRichChildDistributorsHeader.h"

@interface KLRichChildDistributorsHeader ()
//排名
@property (nonatomic, strong) UILabel * rankingLab;
//爵位
@property (nonatomic, strong) UILabel * jueLab;
//佣金
@property (nonatomic, strong) UILabel * commissionLab;
//底部分割线
@property (nonatomic, strong) UIView  * line;

@end

@implementation KLRichChildDistributorsHeader

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =[UIColor whiteColor];
        
        [self rankingLab];
        [self jueLab];
        [self commissionLab];
        [self line];
        
    }
    return self;
}

- (UILabel *)rankingLab {
    if (!_rankingLab){
        _rankingLab = [UILabel zj_labelWithFontSize:12
                                              lines:1
                                               text:@"排名"
                                          textColor:RGBSigle(51)
                                          superView:self.contentView
                                        constraints:^(MASConstraintMaker *make) {
                                            make.bottom.offset =AdaptedHeight(-10);
                                            make.height.offset =AdaptedHeight(15);
                                            make.width.offset = (MainWidth-AdaptedWidth(66))/3;
                                            make.left.offset =AdaptedWidth(18);
                                        }];
    }
    return _rankingLab;
}


- (UILabel *)jueLab {
    if (!_jueLab){
        _jueLab = [UILabel zj_labelWithFontSize:12
                                          lines:1
                                           text:@"爵位"
                                      textColor:RGBSigle(51)
                                      superView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.width.height.bottom.mas_equalTo(self.rankingLab);
                                        make.left.mas_equalTo(self.rankingLab.mas_right).offset =AdaptedWidth(15);
                                    }];
        _jueLab.textAlignment =NSTextAlignmentCenter;
    }
    return _jueLab;
}

- (UILabel *)commissionLab {
    if (!_commissionLab){
        _commissionLab = [UILabel zj_labelWithFontSize:12
                                          lines:1
                                           text:@"佣金"
                                      textColor:RGBSigle(51)
                                      superView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.width.height.bottom.mas_equalTo(self.rankingLab);
                                        make.left.mas_equalTo(self.jueLab.mas_right).offset =AdaptedWidth(15);
                                    }];
        _commissionLab.textAlignment =NSTextAlignmentRight;
    }
    return _commissionLab;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.right.bottom.offset =0;
                                     make.height.offset =0.5f;
                                 }];
    }
    return _line;
}

@end
