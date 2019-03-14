//
//  KLHotCityTableViewCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLHotCityTableViewCell.h"

@implementation KLHotCityTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier hotCityArray:(NSArray *)hotCityArray{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat marginX = AdaptedWidth(20);     //按钮距离左边和右边的距离
        CGFloat marginY = AdaptedHeight(20);    //距离上下边缘距离
        CGFloat toTop = 0;                      //按钮距离顶部的距离
        CGFloat gapX = AdaptedWidth(15);        //左右按钮之间的距离
        CGFloat gapY = AdaptedHeight(20);       //上下按钮之间的距离
        NSInteger col = 3;                      //这里只布局3列
        NSInteger count = hotCityArray.count;   //这里先设置布局任意个按钮
        CGFloat itemHeight = AdaptedHeight(30); //按钮的高度可以根据情况设定 这里设置为相等
        CGFloat viewWidth = MainWidth - AdaptedWidth(20);        //视图的宽度
         //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
        CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1)*gapX)/col*1.0f;
        klWeakSelf;
        UIButton *lastBtn = nil;   //上一个按钮
        for (int i = 0; i < count; i++) {
          
            UIButton * button = [UIButton createBtnTitle:hotCityArray[i] titleColor:TitleColor font:kFont_13 imageName:@"" backgrounColor:[UIColor clearColor] action:^(UIButton * _Nonnull button) {
                weakSelf.hotCityBlock(button);
            }];
            [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [button setLayerCornerRadius:3 borderWidth:1 borderColor:LineColor];
            button.tag = i + 10;
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
    return self;
}

+ (KLHotCityTableViewCell *)initWith:(UITableView *)tableView hotCityArray:(NSArray *)hotCityArray{
    
    KLHotCityTableViewCell * cell = kCellIdentifier(KLHotCityTableViewCell);
    if (!cell) {
        cell = [[KLHotCityTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([KLHotCityTableViewCell class]) hotCityArray:hotCityArray];
    }
    return cell;
    
}



@end
