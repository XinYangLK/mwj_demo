//
//  KLPetHotTableViewCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/18.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLPetHotTableViewCell.h"

@interface KLHotPetButton ()

//@property (nonatomic, strong) UIImageView * petImgV;
//@property (nonatomic, strong) UILabel     * petNameLab;

@end

@implementation KLHotPetButton

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self petImgV];
        [self petNameLab];
    }
    return self;
}

- (UIImageView *)petImgV {
    if (!_petImgV){
        _petImgV = [UIImageView zj_imageViewWithImage:nil
                                            SuperView:self
                                          constraints:^(MASConstraintMaker *make) {
                                              make.left.right.top.offset = 0;
                                              make.bottom.offset =AdaptedHeight(-30);
                                          }];
        _petImgV.backgroundColor = ARCColor;
        [_petImgV setLayerCornerRadius:8];
    }
    return _petImgV;
}
- (UILabel *)petNameLab {
    if (!_petNameLab){
        _petNameLab = [UILabel zj_labelWithFontSize:14
                                          textColor:RGBSigle(51)
                                          superView:self
                                        constraints:^(MASConstraintMaker *make) {
                                            make.bottom.left.right.offset =0;
                                            make.height.offset =AdaptedHeight(20);
                                        }];
        _petNameLab.textAlignment = NSTextAlignmentCenter;
    }
    return _petNameLab;
}

@end



@implementation KLPetHotTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier hotPetArray:(NSArray *)hotPetArray{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat marginX = AdaptedWidth(20);     //按钮距离左边和右边的距离
        CGFloat marginY = AdaptedHeight(10);    //距离上下边缘距离
        CGFloat toTop = 0;                      //按钮距离顶部的距离
        CGFloat gapX = AdaptedWidth(10);        //左右按钮之间的距离
        CGFloat gapY = AdaptedHeight(10);       //上下按钮之间的距离
        NSInteger col = 3;                      //这里只布局3列
        NSInteger count = hotPetArray.count;   //这里先设置布局任意个按钮
        CGFloat viewWidth = MainWidth - AdaptedWidth(20);        //视图的宽度
        //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
        CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1)*gapX)/col*1.0f;
        CGFloat itemHeight = itemWidth + AdaptedWidth(30); //按钮的高度可以根据情况设定 这里设置为相等

        UIButton *lastBtn = nil;   //上一个按钮
        for (int i = 0; i < count; i++) {
            
            KLHotPetButton * button = [[KLHotPetButton alloc]init];
            [button addTarget:self action:@selector(hotPetChangeChick:) forControlEvents:UIControlEventTouchUpInside];
//            button.petImgV.image = [UIImage imageNamed:@""];
            button.petNameLab.text = hotPetArray[i];
            [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
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

+ (KLPetHotTableViewCell *)initWith:(UITableView *)tableView hotPetArray:(NSArray *)hotPetArray{
    
    KLPetHotTableViewCell * cell = kCellIdentifier(KLPetHotTableViewCell);
    if (!cell) {
        cell = [[KLPetHotTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([KLPetHotTableViewCell class]) hotPetArray:hotPetArray];
    }
    return cell;
    
}

#pragma mark - 热门宠物选择
- (void)hotPetChangeChick:(KLHotPetButton *)sender {
    
    self.hotPetBlock(sender);
    
}



@end
