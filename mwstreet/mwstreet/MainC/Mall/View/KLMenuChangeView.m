//
//  KLMenuChangeView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/4.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMenuChangeView.h"
@interface KLMenuChangeView ()
@property (nonatomic, strong) UIView *line;
//@property (nonatomic, strong) UIView *line2;

@end

@implementation KLMenuChangeView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        [self addSubview:self.line];

        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset =0;
            make.height.offset =0.5;
            make.top.offset =AdaptedHeight(44);
        }];
    }
    return self;
}
- (UIView *)line {
    if (!_line){
        _line = [[UIView alloc]init];
        _line.backgroundColor =LineColor;
    }
    return _line;
}



- (void)setMenuArray:(NSArray *)menuArray{
    
    _menuArray = menuArray;
    //单行布局 不需要考虑换行的问题
    CGFloat marginX = AdaptedWidth(10);  //按钮距离左边和右边的距离
    CGFloat marginY = 0;  //按钮距离布局顶部的距离
    CGFloat toTop = AdaptedHeight(15);  //布局区域距离顶部的距离
    CGFloat gap = AdaptedWidth(3);    //按钮与按钮之间的距离
    NSInteger col = 4;    //这里只布局4列
    NSInteger count = menuArray.count;  //这里先设置布局5个按钮
    CGFloat itemWidth = (MainWidth - marginX *2 - (col - 1)*gap)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
    CGFloat height = AdaptedHeight(15);   //按钮的高度可以根据情况设定 这里设置为相等
    
    UIButton *lastItem = nil;   //上一个按钮
    //准备工作完毕 既可以开始布局了
    for (int i = 0 ; i < count; i++) {
        
        UIButton * button =[[UIButton alloc]init];
        button.tag = i + 100;
        [button setTitle:menuArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(goodsBtnChick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = kFont_14;
        [button setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        if (i == 1 || i == 2) {
            [button setImage:[UIImage imageNamed:@"angle_h"] forState:UIControlStateNormal];
            [button setImagePositionWithType:SSImagePositionTypeRight spacing:4];
        }else if(i == 3){
            if ([NSString isBlankString:button.titleLabel.text]) {
                [button setImage:[UIImage imageNamed:@"gev"] forState:UIControlStateNormal];
            }else{
                [button setImage:[UIImage imageNamed:@"shaixuan"] forState:UIControlStateNormal];
                [button setImagePositionWithType:SSImagePositionTypeRight spacing:4];
            }
        }
        [self addSubview:button];
        //布局
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            //宽高是固定的，前面已经算好了
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(height);
            //topTop距离顶部的距离，单行不用考虑太多，多行，还需要计算距离顶部的距离
            make.top.mas_offset(toTop+marginY);
            if (!lastItem) {  //last为nil 说明是第一个按钮
                make.left.mas_offset(marginX);
            }else{
                //第二个或者后面的按钮 距离前一个按钮右边的距离都是gap个单位
                make.left.mas_equalTo(lastItem.mas_right).mas_offset(gap);
            }
        }];
        lastItem = button;
    }
}


//***  菜单点击事件  **/
- (void)goodsBtnChick:(UIButton *)sender {
    
    UIButton *button = [self viewWithTag:100];
    UIButton *button1 = [self viewWithTag:101];
    UIButton *button2 = [self viewWithTag:102];
    UIButton *button3 = [self viewWithTag:103];
    

    if (sender.tag == 100) {
        
        [sender setTitleColor:MainColor forState:UIControlStateNormal];
        [button1 setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        [button2 setTitleColor:RGBSigle(51) forState:UIControlStateNormal];

        [button1 setImage:[UIImage imageNamed:@"angle_h"] forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"angle_h"] forState:UIControlStateNormal];
        [button1 setImagePositionWithType:SSImagePositionTypeRight spacing:4];
        [button2 setImagePositionWithType:SSImagePositionTypeRight spacing:4];

        if (![NSString isBlankString:button3.titleLabel.text]) {
            [button3 setImage:[UIImage imageNamed:@"shaixuan"] forState:UIControlStateNormal];
            [button3 setImagePositionWithType:SSImagePositionTypeRight spacing:4];
            [button3 setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        }
        
    }else if (sender.tag == 101) {
        
        sender.selected = !sender.selected;
        if (sender.selected) {
            [sender setImage:[UIImage imageNamed:@"s"] forState:UIControlStateNormal];
        }else{
            [sender setImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
        }
        [button2 setImage:[UIImage imageNamed:@"angle_h"] forState:UIControlStateNormal];
        
        if (![NSString isBlankString:button3.titleLabel.text]) {
            [button3 setImage:[UIImage imageNamed:@"shaixuan"] forState:UIControlStateNormal];
            [button3 setImagePositionWithType:SSImagePositionTypeRight spacing:4];
            [button3 setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        }
        [sender setImagePositionWithType:SSImagePositionTypeRight spacing:4];
        [button2 setImagePositionWithType:SSImagePositionTypeRight spacing:4];

        [sender setTitleColor:MainColor forState:UIControlStateNormal];
        [button setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        [button2 setTitleColor:RGBSigle(51) forState:UIControlStateNormal];

        
    }else if (sender.tag == 102){
        
        sender.selected = !sender.selected;
        if (sender.selected) {
            [sender setImage:[UIImage imageNamed:@"s"] forState:UIControlStateNormal];
        }else{
            [sender setImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
        }
        [button1 setImage:[UIImage imageNamed:@"angle_h"] forState:UIControlStateNormal];
        
        if (![NSString isBlankString:button3.titleLabel.text]) {
            [button3 setImage:[UIImage imageNamed:@"shaixuan"] forState:UIControlStateNormal];
            [button3 setImagePositionWithType:SSImagePositionTypeRight spacing:4];
            [button3 setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        }
       
        [sender setImagePositionWithType:SSImagePositionTypeRight spacing:4];
        [button1 setImagePositionWithType:SSImagePositionTypeRight spacing:4];

        [sender setTitleColor:MainColor forState:UIControlStateNormal];
        [button setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        [button1 setTitleColor:RGBSigle(51) forState:UIControlStateNormal];

        
    }else if (sender.tag == 103){
        
        [button1 setImage:[UIImage imageNamed:@"angle_h"] forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"angle_h"] forState:UIControlStateNormal];
       
        
        if ([NSString isBlankString:sender.titleLabel.text]) {
            sender.selected = !sender.selected;
            if (sender.selected) {
                [sender setImage:[UIImage imageNamed:@"grf"] forState:UIControlStateNormal];
            }else{
                [sender setImage:[UIImage imageNamed:@"gev"] forState:UIControlStateNormal];
            }
        }else{
            [sender setImage:[UIImage imageNamed:@"shaixuan_h"] forState:UIControlStateNormal];
            [sender setImagePositionWithType:SSImagePositionTypeRight spacing:4];
            [sender setTitleColor:MainColor forState:UIControlStateNormal];
        }
        
        [button1 setImagePositionWithType:SSImagePositionTypeRight spacing:4];
        [button2 setImagePositionWithType:SSImagePositionTypeRight spacing:4];
        
        [button setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        [button1 setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        [button2 setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
      
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didChange:actionBtnChick:)]) {
        [self.delegate didChange:self actionBtnChick:sender];
    }
    
}
@end


//        [self addSubview:self.imgView];
//- (UIImageView *)imgView {
//    if (!_imgView){
//        CGFloat Width = (MainWidth - AdaptedWidth(10) * 2 - 3 * AdaptedWidth(20))/4.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
//        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(AdaptedWidth(10), AdaptedHeight(48)+1, Width, AdaptedHeight(36)+1)];
//        _imgView.image =[UIImage imageNamed:@"kuang"];
//        _imgView.backgroundColor =[UIColor whiteColor];
//        _imgView.hidden =YES;
//        [self addSubview:_imgView];
//    }
//    return _imgView;
//}

//- (void)setBtnArray:(NSArray *)btnArray {
//    _btnArray = btnArray;
//    //单行布局 不需要考虑换行的问题
//    CGFloat marginX = AdaptedWidth(10);  //按钮距离左边和右边的距离
//    CGFloat marginY = AdaptedHeight(44)+1;  //按钮距离布局顶部的距离
//    CGFloat toTop = AdaptedHeight(7);  //布局区域距离顶部的距离
//    CGFloat gap = AdaptedWidth(20);    //按钮与按钮之间的距离
//    NSInteger col = 4;    //这里只布局4列
//    NSInteger count = btnArray.count;  //这里先设置布局5个按钮
//    CGFloat itemWidth = (MainWidth - marginX *2 - (col - 1)*gap)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
//    CGFloat height = AdaptedHeight(25);   //按钮的高度可以根据情况设定 这里设置为相等
//    UIButton *lastItem = nil;   //上一个按钮
//    //准备工作完毕 既可以开始布局了
//    for (int i = 0 ; i < count; i++) {
//
//        UIButton * button =[[UIButton alloc]init];
//        button.tag = i + 22;
//        [button setTitle:btnArray[i] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(goodsBtnChick:) forControlEvents:UIControlEventTouchUpInside];
//        [button setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//        button.titleLabel.font = kFont_14;
//        [button setTitleColor:RGBSigle(153) forState:UIControlStateNormal];
//        [button setLayerCornerRadius:5];
//        [button setImage:[UIImage imageNamed:@"xiaxia"] forState:UIControlStateNormal];
//        [button setImagePositionWithType:SSImagePositionTypeRight spacing:4];
//        [self addSubview:button];
//        //布局
//        [button mas_makeConstraints:^(MASConstraintMaker *make) {
//            //宽高是固定的，前面已经算好了
//            make.width.mas_equalTo(itemWidth);
//            make.height.mas_equalTo(height);
//            //topTop距离顶部的距离，单行不用考虑太多，多行，还需要计算距离顶部的距离
//            make.top.mas_offset(toTop+marginY);
//            if (!lastItem) {  //last为nil 说明是第一个按钮
//                make.left.mas_offset(marginX);
//            }else{
//                //第二个或者后面的按钮 距离前一个按钮右边的距离都是gap个单位
//                make.left.mas_equalTo(lastItem.mas_right).mas_offset(gap);
//            }
//        }];
//        lastItem = button;
//    }
//}



//    UIButton *btn = [self viewWithTag:22];
//    UIButton *btn1 = [self viewWithTag:23];
//    UIButton *btn2 = [self viewWithTag:24];
//    UIButton *btn3 = [self viewWithTag:25];
//
//    if (sender.tag == 22 ||sender.tag == 23 ||sender.tag == 24 ||sender.tag == 25 ) {
//        self.imgView.hidden = NO;
//        self.imgView.centerX = sender.centerX;
//        [sender setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
//    }
//
//    if(sender.tag == 22){
//
//        [btn1 setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//        [btn2 setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//        [btn3 setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//
//    }else if (sender.tag == 23){
//
//        [btn setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//        [btn2 setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//        [btn3 setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//
//    }else if (sender.tag == 24){
//
//        [btn1 setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//        [btn3 setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//
//    }else if (sender.tag == 25){
//
//        [btn1 setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//        [btn2 setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//
//    }else if (sender.tag == 100) {
    
//        self.imgView.hidden =YES;
//        [btn setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//        [btn1 setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//        [btn2 setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//        [btn3 setBackgroundImage:[UIImage imageWithColor:RGBSigle(229)] forState:UIControlStateNormal];
//}






//        [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.left.right.offset =0;
//            make.height.offset =0.5;
//        }];
//- (UIView *)line2 {
//    if (!_line2){
//        _line2 = [[UIView alloc]init];
//        _line2.backgroundColor =LineColor;
//    }
//    return _line2;
//}
