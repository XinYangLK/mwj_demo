//
//  KLEvaluationScoreView.m
//  mwstreet
//
//  Created by 科pro on 2019/3/14.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLEvaluationScoreView.h"

@implementation KLEvaluationScoreView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self titleLab];
    [self starView];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:nil
                                        textColor:RGBSigle(51)
                                        superView:self
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset    = AdaptedWidth(10);
                                          make.centerY.offset = 0;
                                          make.height.offset  = AdaptedHeight(18);
                                          make.width.offset   = AdaptedWidth(80);
                                      }];
    }
    return _titleLab;
}

- (SYStarRatingView *)starView {
    if (!_starView){
        _starView = [[SYStarRatingView alloc]initWithFrame:CGRectMake(AdaptedWidth(103), AdaptedHeight(5), AdaptedWidth(140), AdaptedHeight(16)) space:AdaptedWidth(10)];
        _starView.foregroundImageName = @"xin_h";
        _starView.backgroundImageName = @"xin";
        _starView.isMove = YES;
        _starView.foregroundViewColor = MainColor;
        [self addSubview:_starView];
    }
    return _starView;
}




@end
