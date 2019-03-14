//
//  KLDetailNavigationView.m
//  mwstreet
//
//  Created by 科pro on 2018/12/25.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLDetailNavigationView.h"

@implementation KLDetailNavigationView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

//*** 使导航view能够穿透点击到后面的tableviewCell  **/
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        return nil;
    }
    return hitView;
}

#pragma mark ------ 构建 UI
- (void)configUI{
    [self addSubview:self.backView];
    [self addSubview:self.backBtn];
    [self addSubview:self.leftBtn];
    [self addSubview:self.centerBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.line];
    
    [self.centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset =0;
        make.top.offset = StatusBarHeight + 8;
        make.height.offset = 30;
        make.width.offset =AdaptedWidth(40);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.mas_equalTo(self.centerBtn);
        make.right.mas_equalTo(self.centerBtn.mas_left).offset =AdaptedWidth(-20);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.mas_equalTo(self.centerBtn);
        make.left.mas_equalTo(self.centerBtn.mas_right).offset =AdaptedWidth(20);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

}


- (UIView *)backView {
    if (!_backView){
        _backView = [[UIView alloc]init];
    }
    return _backView;
}


//***  返回按钮  **/
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
        _backBtn.frame = CGRectMake(0, 10 + StatusBarHeight, 44, 25);
        _backBtn.adjustsImageWhenHighlighted = YES;
        [_backBtn addTarget:self action:@selector(backChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIView *)line {
    if (!_line){
        CGFloat x = MainWidth / 2 - AdaptedWidth(80);
        CGFloat y = StatusBarAndNavigationBarHeight -2;
        _line = [[UIView alloc]initWithFrame:CGRectMake(x+AdaptedWidth(2.5), y, AdaptedWidth(35), 2)];
        _line.backgroundColor = RGBSigle(51);
    }
    return _line;
}


- (UIButton *)leftBtn {
    if (!_leftBtn){
        _leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:@"商品" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        _leftBtn.titleLabel.font =kFont_15;
        _leftBtn.tag = 1;
        [_leftBtn addTarget:self action:@selector(btnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)centerBtn {
    if (!_centerBtn){
        _centerBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_centerBtn setTitle:@"评价" forState:UIControlStateNormal];
        [_centerBtn setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        _centerBtn.titleLabel.font =kFont_15;
        _centerBtn.tag = 2;
        [_centerBtn addTarget:self action:@selector(btnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn){
        _rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"详情" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        _rightBtn.titleLabel.font =kFont_15;
        _rightBtn.tag = 3;
        [_rightBtn addTarget:self action:@selector(btnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}



#pragma mark ------ 商品 评价 详情 按钮点击事件
- (void)btnChick:(UIButton *)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationViewBtnChick:)]) {
        [self.delegate navigationViewBtnChick:sender];
    }
}

//***  导航返回按钮响应  **/
- (void)backChick:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(popViewController)]) {
        [self.delegate popViewController];
    }
}

@end
