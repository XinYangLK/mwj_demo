//
//  KLGoodsDetailSecurityCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLGoodsDetailSecurityCell.h"

@implementation KLGoodsDetailSecurityCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

//        [self.contentView addSubview:self.spacLab];
//        [self.spacLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.bottom.offset =0;
//            make.height.offset =AdaptedHeight(5);
//        }];
    }
    return self;
}

//- (UILabel *)spacLab {
//    if (!_spacLab){
//        _spacLab = [[UILabel alloc]init];
//        _spacLab.backgroundColor =RGBSigle(238);
//    }
//    return _spacLab;
//}



- (void)setSecurityBtnArray:(NSArray *)securityBtnArray {
    self.markCount ++;
    if (self.markCount > 1) {
        return;
    }
    //单行布局 不需要考虑换行的问题
    CGFloat marginX = AdaptedWidth(5);  //按钮距离左边和右边的距离
    CGFloat marginY = 0;  //按钮距离布局顶部的距离
    CGFloat toTop   = AdaptedHeight(18);  //布局区域距离顶部的距离
    CGFloat gap     = AdaptedWidth(10);    //按钮与按钮之间的距离
    NSInteger col   = 3;    //这里只布局3列
    NSInteger count = securityBtnArray.count;  //这里先设置布局5个按钮
    
    CGFloat viewWidth = MainWidth - AdaptedWidth(40);  //视图的宽度
    CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1) * gap)/col * 1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
    CGFloat height = AdaptedHeight(20);   //按钮的高度可以根据情况设定 这里设置为相等
    
    NSArray * imgArray =@[@"goods_z",@"goods_c",@"goods_t"];
    UIButton *lastItem = nil;   //上一个按钮
    //准备工作完毕 既可以开始布局了
    for (int i = 0 ; i < count; i++) {
        
        UIButton * item =[UIButton buttonWithType:UIButtonTypeCustom];
        [item setTitle:securityBtnArray[i] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        [item setTitleColor:RGBSigle(153) forState:UIControlStateNormal];
        [item setImagePositionWithType:SSImagePositionTypeLeft spacing:4];
        item.titleLabel.font = kFont_12;
        item.userInteractionEnabled =NO;
        [self.contentView addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            //宽高是固定的，前面已经算好了
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(height);
            //topTop距离顶部的距离，单行不用考虑太多，多行，还需要计算距离顶部的距离
            make.top.mas_offset(toTop + marginY);
            if (!lastItem) {  //last为nil 说明是第一个按钮
                make.left.mas_offset(marginX);
            }else{
                //第二个或者后面的按钮 距离前一个按钮右边的距离都是gap个单位
                make.left.mas_equalTo(lastItem.mas_right).mas_offset(gap);
            }
        }];
        lastItem = item;
    }
    
    
}



@end
