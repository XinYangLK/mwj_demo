//
//  KLGoodsDetailCountdownCell.m
//  mwstreet
//
//  Created by 科pro on 2019/3/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLGoodsDetailCountdownCell.h"

@implementation KLGoodsDetailCountdownCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = XMainColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self titleLab];
        [self countdownView];
        [self line];
    }
    return self;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:@"距秒杀结束还有"
                                        textColor:RedColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset    = AdaptedWidth(13);
                                          make.centerY.offset = 0;
                                          make.height.offset  = AdaptedHeight(15);
                                          make.width.offset   = AdaptedWidth(150);
                                      }];
        _titleLab.backgroundColor =[UIColor clearColor];
    }
    return _titleLab;
}
//***  倒计时 View  **/
- (KLCountdownView *)countdownView {
    if (!_countdownView){
        _countdownView = [[KLCountdownView alloc]initWithFrame:CGRectZero size:AdaptedWidth(20)];
        _countdownView.color = RedColor;
        [self.contentView addSubview:_countdownView];
        [_countdownView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset   = AdaptedWidth(-13);
            make.width.offset   = AdaptedWidth(90);
            make.height.offset  = AdaptedHeight(20);
            make.centerY.offset = 0;
        }];
    }
    return _countdownView;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:[UIColor whiteColor]
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.right.mas_equalTo(self.countdownView.mas_left).offset = AdaptedWidth(-58);
                                     make.width.offset   = 1.0f;
                                     make.height.offset  = AdaptedHeight(33);
                                     make.centerY.offset = 0;
                                 }];
    }
    return _line;
}

@end
