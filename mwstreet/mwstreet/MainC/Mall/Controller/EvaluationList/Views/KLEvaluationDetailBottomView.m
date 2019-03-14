//
//  KLEvaluationDetailBottomView.m
//  mwstreet
//
//  Created by 科pro on 2019/3/12.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLEvaluationDetailBottomView.h"

@implementation KLEvaluationDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self leftBtn];
        [self rightBtn];
    }
    return self;
}


- (UIButton *)leftBtn {
    if (!_leftBtn){
        @weakify(self)
        _leftBtn = [UIButton zj_buttonWithTitle:@"评价"
                                     titleColor:TitleColor
                                      backColor:SpacColor
                                       fontSize:14
                                         isBold:NO
                                   cornerRadius:0 supView:self
                                    constraints:^(MASConstraintMaker *make) {
                                        make.bottom.left.offset   = 0.0f;
                                        make.width.offset  = (MainWidth-1)/2;
                                        make.height.offset = AdaptedHeight(49);
                                   } touchUp:^(id sender) {
                                       @strongify(self)
                                       self.msgBlock ? self.msgBlock(sender):nil;
                                   }];
        [_leftBtn setImage:[UIImage imageNamed:@"xiaoxi"] forState:UIControlStateNormal];
        [_leftBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:5];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn){
         @weakify(self)
        _rightBtn = [UIButton zj_buttonWithTitle:@"点赞"
                                      titleColor:TitleColor
                                       backColor:SpacColor
                                        fontSize:14
                                          isBold:NO
                                    cornerRadius:0 supView:self
                                     constraints:^(MASConstraintMaker *make) {
                                         make.right.offset   = 0.0f;
                                         make.bottom.height.width.mas_equalTo(self.leftBtn);
                                     } touchUp:^(id sender) {
                                         @strongify(self)
                                         self.praiseBlock ? self.praiseBlock(sender):nil;
                                     }];
        [_rightBtn setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        [_rightBtn setImagePositionWithType:SSImagePositionTypeLeft spacing:5];
    }
    return _rightBtn;
}

@end
