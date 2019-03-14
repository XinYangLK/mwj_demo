//
//  KLCountFooterView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/31.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLCountFooterView.h"

@implementation KLCountFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        self.userInteractionEnabled = YES;
        [self addSubview:self.numberButton];
        [_numberButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.offset(-AdaptedWidth(15));
            make.bottom.offset(0);
            make.width.offset(AdaptedWidth(150));
            make.height.offset(AdaptedHeight(35));
        }];
        [self countLab];
    }
    return self;
}
//***  设置最大值为库存值  **/
- (void)setMaxValue:(NSInteger)maxValue {
    _maxValue = maxValue;
    _numberButton.maxValue = maxValue;
}



- (PPNumberButton *)numberButton {
    if (!_numberButton){
        _numberButton = [[PPNumberButton alloc]init];
        // 开启抖动动画
        _numberButton.shakeAnimation = YES;
        //设置边框颜色
        _numberButton.borderColor = [UIColor blackColor];
        // 设置最小值
        _numberButton.minValue = 1;
        // 设置最大值
        _numberButton.maxValue = 100;
        //输入框中的内容
        _numberButton.currentNumber = 0;
        // 设置输入框中的字体大小
        _numberButton.inputFieldFont = 14;
        _numberButton.increaseTitle = @"＋";
        _numberButton.decreaseTitle = @"－";
        __weak typeof(self) _weakSelf = self;
        _numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus) {
            _weakSelf.changeNumCellBlock ? _weakSelf.changeNumCellBlock(number) : nil;
        };
    }
    return _numberButton;
}

- (UILabel *)countLab {
    if (!_countLab){
        _countLab = [UILabel zj_labelWithFontSize:14
                                            lines:0
                                             text:@"数量"
                                        textColor:RGBSigle(51)
                                        superView:self
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset(AdaptedWidth(15));
                                          make.centerY.equalTo(self.numberButton);
                                      }];
    }
    return _countLab;
}



@end
