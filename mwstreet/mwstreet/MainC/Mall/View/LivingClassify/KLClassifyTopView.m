//
//  KLClassifyTopView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/21.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLClassifyTopView.h"
@interface KLClassifyTopView()
@property (nonatomic, strong) UIView * lineView; //滚动指示条
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UILabel *lines;
@end


@implementation KLClassifyTopView
- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self addSubview:self.lines];
        [self.lines mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.offset =0;
            make.height.offset =0.5;
        }];
    }
    return self;
}


- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray =[NSMutableArray array];
    }
    return _buttonArray;
}


- (void)setTitleArray:(NSArray *)titleArray {
    
    self.markCount ++;
    if (self.markCount > 1) {
        return;
    }
    _titleArray = titleArray;
    
    CGFloat btnW = MainWidth/titleArray.count;
    CGFloat btnH = AdaptedHeight(38);
    
    for (int i = 0 ; i < titleArray.count ; i++) {
        
        UIButton * button = [UIButton buttonWithType: UIButtonTypeCustom];
        [self.buttonArray addObject:button];
        button.frame = CGRectMake(btnW * i, 0, btnW, btnH);
        [button setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        [button setTitleColor:MainColor forState:UIControlStateSelected];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = kFont_15;
        button.tag = i + 100;
        [button addTarget:self action:@selector(regionalActionChick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            CGFloat h =1;
            CGFloat y =AdaptedHeight(38);
            [button.titleLabel sizeToFit];
            self.lineView =[[UIView alloc]init];
            self.lineView.backgroundColor = MainColor;
            self.lineView.width = button.titleLabel.width + AdaptedWidth(10);
            self.lineView.height = h;
            self.lineView.top = y;
            self.lineView.centerX = button.centerX;
            [self addSubview:self.lineView];
        }else{
            button.selected = NO;
        }
    }
}


-(UILabel *)lines {
    if (!_lines) {
        _lines =[[UILabel alloc]init];
        _lines.backgroundColor = LineColor;
    }
    return _lines;
}





#pragma mark ------ 方法回调

- (void)regionalActionChick:(UIButton *)sender {
    
    for (UIButton * btn in _buttonArray) {
        btn.selected = NO;
    }
    sender.selected =YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.lineView.centerX = sender.centerX;
    }];
    
    //    if (self.delegate && [self.delegate respondsToSelector:@selector(AreaActionBtnChick:)]) {
    //        [self.delegate AreaActionBtnChick:sender];
    //    }
}


@end
