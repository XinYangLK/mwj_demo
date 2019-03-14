//
//  KLBHomeHeaderFooterView.m
//  mwstreet
//
//  Created by 科pro on 2019/2/26.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBHomeHeaderFooterView.h"

@interface KLBHomeHeaderFooterView ()

@property (nonatomic, strong) NSMutableArray * buttonArray;
@property (nonatomic, strong) UIView *line;

@end

@implementation KLBHomeHeaderFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
         [self configUI];
    }
    return self;
}


- (void)configUI {
    [self titleLab];
    [self leftImg];
    [self rightImg];
    [self line];
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray){
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (void)setDataArray:(NSArray *)dataArray {
   
    self.markNumber ++;
    if (self.markNumber > 1) {
        return;
    }
    CGFloat marginX = 0;  //按钮距离左边和右边的距离
    CGFloat marginY = 1;  //距离上下边缘距离
    CGFloat toTop = AdaptedHeight(48);  //按钮距离顶部的距离
    CGFloat gapX = 0;    //左右按钮之间的距离
    CGFloat gapY = 0;    //上下按钮之间的距离
    NSInteger col = 4;    //这里只布局4列
    NSInteger count = dataArray.count;  //这里先设置布局任意个按钮
    
    CGFloat viewWidth = MainWidth;  //视图的宽度
    //    CGFloat viewHeight = self.contentView.mj_h;  //视图的高度
    
    //    NSArray * btnImgArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1)*gapX)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
    CGFloat itemHeight = AdaptedHeight(47);   //按钮的高度可以根据情况设定 这里设置为相等
    
    UIButton *lastBtn = nil;   //上一个按钮
    
    for (int i = 0; i < count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
       
        [button setTitle:dataArray[i] forState:UIControlStateNormal];
        
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        button.titleLabel.font = kFont_14;
        [button setBackgroundImage:[UIImage imageNamed:@"bjingtu"] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 10;
        if (i == 0) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
        [self.buttonArray addObject:button];
        [self.contentView addSubview:button];
        //布局
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            //宽高是固定的，前面已经算好了
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(itemHeight);
            //topTop距离顶部的距离，单行不用考虑太多，多行，还需要计算距离顶部的距离
            //计算距离顶部的距离 --- 根据换行
            CGFloat top = toTop + marginY + (i/col)*(itemHeight+gapY);
            make.top.mas_offset(top);
            if ( !lastBtn || (i % col) == 0) {  //last为nil  或者(i%col) == 0 说明换行了 每行的第一个确定它距离左边边缘的距离
                make.left.mas_offset(marginX);
            }else{
                //第二个或者后面的按钮 距离前一个按钮右边的距离都是gap个单位
                make.left.mas_equalTo(lastBtn.mas_right).mas_offset(gapX);
            }
        }];
        lastBtn = button;
    }
    
}


- (void)tapAction:(UIButton *)sender {
  
    for (UIButton * btn in self.buttonArray) {
        btn.selected = NO;
    }
    sender.selected = YES;
    self.titleBlock ? self.titleBlock(sender) : nil;

}



- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.contentView constraints:^(MASConstraintMaker *make) {
                                         make.left.bottom.right.offset = 0.0f;
                                         make.height.offset = 0.5f;
                                     }];
    }
    return _line;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFont:kFont_14
                                        lines:1
                                         text:@"特惠商品"
                                    textColor:RGBSigle(51)
                                    superView:self.contentView
                                  constraints:^(MASConstraintMaker *make) {
                                      make.centerX.offset = 0;
                                      make.width.offset =AdaptedWidth(70);
                                      make.height.offset =AdaptedHeight(15);
                                      make.top.offset =AdaptedHeight(18);
                                  }];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UIImageView *)leftImg {
    if (!_leftImg){
        _leftImg = [UIImageView zj_imageViewWithImage:@"xinxinh"
                                            SuperView:self.contentView constraints:^(MASConstraintMaker *make) {
                                                make.width.height.offset =AdaptedHeight(10);
                                                make.centerY.mas_equalTo(self.titleLab);
                                                make.right.mas_equalTo(self.titleLab.mas_left).offset =AdaptedWidth(-5);
                                            }];
    }
    return _leftImg;
}
- (UIImageView *)rightImg {
    if (!_rightImg){
        _rightImg = [UIImageView zj_imageViewWithImage:@"xinxinh"
                                             SuperView:self.contentView constraints:^(MASConstraintMaker *make) {
                                                 make.centerY.width.height.mas_equalTo(self.leftImg);
                                                 make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(5);
                                             }];
    }
    return _rightImg;
}

@end
