//
//  KLGoodsDetailStoreCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLGoodsDetailStoreCell.h"

@implementation KLGoodsStoreView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self configerUI];
    }
    return self;
}

- (void)configerUI {
    
    [self addSubview:self.numLab];
    [self addSubview:self.storeLab];
    
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset =0;
        make.height.offset =AdaptedHeight(15);
    }];
    [self.storeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset =0;
        make.height.offset =AdaptedHeight(15);
    }];
    
}

- (UILabel *)numLab {
    if (!_numLab){
        _numLab = [UILabel createLabelTextColor:TextColor font:kFont_12];
        _numLab.textAlignment =NSTextAlignmentCenter;
    }
    return _numLab;
}

- (UILabel *)storeLab {
    if (!_storeLab){
        _storeLab = [UILabel createLabelTextColor:TextColor font:kFont_12];
        _storeLab.textAlignment =NSTextAlignmentCenter;
    }
    return _storeLab;
}


@end




@implementation KLGoodsDetailStoreCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configerUI];
    }
    return self;
}

- (void)configerUI {
    [self.contentView addSubview:self.storeImg];
    [self.contentView addSubview:self.storeName];
    [self enterStoreBtn];
    
    [self.storeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(10);
        make.top.offset =AdaptedHeight(15);
        make.height.width.offset =AdaptedWidth(28);
    }];
    
    [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.storeImg.mas_right).offset =AdaptedWidth(10);
        make.height.offset =AdaptedHeight(15);
        make.centerY.mas_equalTo(self.storeImg);
        make.right.offset =  AdaptedWidth(-90);;
    }];
}


- (UIImageView *)storeImg {
    if (!_storeImg){
        _storeImg = [[UIImageView alloc]init];
        _storeImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _storeImg;
}

- (UILabel *)storeName {
    if (!_storeName){
        _storeName = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_14];
    }
    return _storeName;
}

- (UIButton *)enterStoreBtn {
    if (!_enterStoreBtn){
        @weakify(self)
        _enterStoreBtn = [UIButton zj_buttonWithTitle:@"进入门店"
                                           titleColor:[UIColor whiteColor] backColor:MainColor fontSize:12
                                               isBold:NO
                                         cornerRadius:5
                                              supView:self.contentView
                                          constraints:^(MASConstraintMaker *make) {
                                              make.right.offset  = AdaptedWidth(-11);
                                              make.height.offset = AdaptedHeight(23);
                                              make.width.offset  = AdaptedWidth(70);
                                              make.centerY.mas_equalTo(self.storeImg);
                                          } touchUp:^(id sender) {
                                             @strongify(self)
                                             self.enterStoreBlock ? self.enterStoreBlock(sender) : nil;
                                          }];
    }
    return _enterStoreBtn;
}


- (void)setStoreDecArray:(NSArray *)storeDecArray {
   
    self.markCount ++;
    if (self.markCount > 1) {
        return;
    }
    //单行布局 不需要考虑换行的问题
    CGFloat marginX = AdaptedWidth(5);  //按钮距离左边和右边的距离
    CGFloat marginY = 0;  //按钮距离布局顶部的距离
    CGFloat toTop   = AdaptedHeight(55);  //布局区域距离顶部的距离
    CGFloat gap     = AdaptedWidth(30);    //按钮与按钮之间的距离
    NSInteger col   = 3;    //这里只布局3列
    NSInteger count = storeDecArray.count;  //这里先设置布局5个按钮
    
    CGFloat viewWidth = MainWidth;  //视图的宽度
    CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1) * gap)/col * 1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
    CGFloat height = AdaptedHeight(35);   //按钮的高度可以根据情况设定 这里设置为相等
    
    NSArray * titleArray =@[@"全部商品",@"促销商品",@"关注人数"];
  
    KLGoodsStoreView *lastView = nil;   //上一个按钮
    //准备工作完毕 既可以开始布局了
    for (int i = 0 ; i < count; i++) {
        KLGoodsStoreView * storeView =[[KLGoodsStoreView alloc]init];
        storeView.numLab.text = storeDecArray[i];
        storeView.storeLab.text =titleArray[i];
        [self.contentView addSubview:storeView];
        [storeView mas_makeConstraints:^(MASConstraintMaker *make) {
            //宽高是固定的，前面已经算好了
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(height);
            //topTop距离顶部的距离，单行不用考虑太多，多行，还需要计算距离顶部的距离
            make.top.mas_offset(toTop + marginY);
            if (!lastView) {  //last为nil 说明是第一个按钮
                make.left.mas_offset(marginX);
            }else{
                //第二个或者后面的按钮 距离前一个按钮右边的距离都是gap个单位
                make.left.mas_equalTo(lastView.mas_right).mas_offset(gap);
            }
        }];
        lastView = storeView;
    }
    
    
}




@end
