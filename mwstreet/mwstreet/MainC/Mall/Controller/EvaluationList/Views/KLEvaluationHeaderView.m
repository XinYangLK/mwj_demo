//
//  KLEvaluationHeaderView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/24.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLEvaluationHeaderView.h"


@implementation KLEvaluationHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier tagArray:(NSArray *)tagArray{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =[UIColor whiteColor];
        CGFloat width = 13.5;//记录每一行已使用宽度
        CGFloat leftRightSpec = 13.5;
        CGFloat y = AdaptedHeight(20);
        CGFloat specW = 15;
        CGFloat specH = 10;

        for (int i = 0; i < tagArray.count; i ++) {
            UIButton *btn = [self loadButton:tagArray[i]];
            if (btn.mj_w + width + 13.5 > MainWidth) {
                width = 13.5;
                y = y + 28 + specH;
                btn.mj_x = width;
                btn.mj_y = y;
                width = btn.mj_x + btn.mj_w + specW;
            }else {
                btn.mj_x = width;
                btn.mj_y = y;
                width = btn.mj_x + btn.mj_w + specW;
            }
            if (btn.mj_w > MainWidth - leftRightSpec * 2) {
                btn.mj_w = MainWidth - leftRightSpec * 2;
            }
            [self.contentView addSubview:btn];
        }
    }
    return self;
}


+ (KLEvaluationHeaderView *)initWith:(UITableView *)tableView tagArray:(NSArray *)tagArray{
    KLEvaluationHeaderView *headerView  = kHeaderFooterIdentifier(KLEvaluationHeaderView);
    if (!headerView) {
        headerView =[[KLEvaluationHeaderView alloc]initWithReuseIdentifier:NSStringFromClass([KLEvaluationHeaderView class]) tagArray:tagArray];
    }
    return headerView;
}



//循环创建button
- (UIButton *)loadButton:(NSString *)text {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([text hasPrefix:@"差评"]) {
        [button setBackgroundImage:[UIImage imageWithColor:RGBSigle(245)] forState:UIControlStateNormal];
    }else{
        [button setBackgroundImage:[UIImage imageWithColor:RGB(255,218,231)] forState:UIControlStateNormal];
    }
    CGFloat w = [UILabel getWidthWithTitle:text font:[UIFont systemFontOfSize:13]];
    CGFloat width;
    if (w < 22) {
        width = 50.0f;
    }else {
        width = w + 28;
    }
    button.mj_w = width;
    button.mj_h = 28;
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:RGBSigle(102) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.backgroundColor = RGBSigle(245);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 14;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (void)buttonClick:(UIButton *)sender {
    
    
}



- (CGFloat)headerForHeight{

    KLLog(@"=====3232==%lf",[UIView getBottomViewBottomFrom:self.contentView]);
    return [UIView getBottomViewBottomFrom:self.contentView];
}


@end
