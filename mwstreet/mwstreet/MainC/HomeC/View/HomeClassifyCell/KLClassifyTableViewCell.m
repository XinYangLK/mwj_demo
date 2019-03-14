//
//  KLClassifyTableViewCell.m
//  mwstreet
//
//  Created by 科pro on 2018/12/20.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLClassifyTableViewCell.h"

@implementation KLClassifyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setBtnArray:(NSArray *)btnArray {

    self.markNumber ++;
    if (self.markNumber > 1) {
        return;
    }
    CGFloat marginX = 10;  //按钮距离左边和右边的距离
    CGFloat marginY = 1;  //距离上下边缘距离
    CGFloat toTop = 0;  //按钮距离顶部的距离
    CGFloat gapX = 10;    //左右按钮之间的距离
    CGFloat gapY = 0;    //上下按钮之间的距离
    NSInteger col = 4;    //这里只布局4列
    NSInteger count = btnArray.count;  //这里先设置布局任意个按钮
    
    CGFloat viewWidth = MainWidth;  //视图的宽度
//    CGFloat viewHeight = self.contentView.mj_h;  //视图的高度

//    NSArray * btnImgArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1)*gapX)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
    CGFloat itemHeight = itemWidth;   //按钮的高度可以根据情况设定 这里设置为相等
    
    UIButton *lastBtn = nil;   //上一个按钮
    
    for (int i = 0; i < count; i++) {
        klWeakSelf;
        
        UIButton * button = [UIButton createBtnTitle:btnArray[i] titleColor:RGBSigle(51) font:kFont_13 imageName:[@(i+1) stringValue] backgrounColor:[UIColor clearColor] SSImagePositionType:SSImagePositionTypeTop spacing:4 action:^(UIButton * _Nonnull button) {
            
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didClickBtn:indexPath:)]) {
                [weakSelf.delegate didClickBtn:button indexPath:weakSelf.indexPath];
            }
        }];
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






@end
