//
//  KLStoreDetailNavigationView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreDetailNavigationView.h"

@implementation KLStoreDetailNavigationView
- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backBtn];
        [self addSubview:self.titleLab];
        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.offset = 0;
            make.height.offset = 0.5;
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset   = MainWidth - AdaptedWidth(80);
            make.height.offset  = 20;
            make.centerX.offset = 0;
            make.centerY.mas_equalTo(self.backBtn);
        }];
    }
    return self;
}

//***  返回按钮  **/
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
        _backBtn.frame = CGRectMake(5, 8 + StatusBarHeight, 28, 25);
        _backBtn.adjustsImageWhenHighlighted = YES;
        [_backBtn addTarget:self action:@selector(backChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel createLabelTextColor:RGBSigle(51) font:AdaptedBOLDSYSFontSize(16)];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.hidden = YES;
    }
    return _titleLab;
}



- (UIView *)line {
    if (!_line){
        _line = [[UIView alloc]init];
        _line.backgroundColor = LineColor;
        _line.hidden = YES;
    }
    return _line;
}

//***  导航返回按钮响应  **/
- (void)backChick:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(popViewControllerBtnChick:)]) {
        [self.delegate popViewControllerBtnChick:sender];
    }
}


@end
