//
//  KLStoreGoodsCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/30.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreGoodsCell.h"


@interface KLStoreGoodsViewBtn ()
//***  商品图片  **/
@property (nonatomic, strong) UIImageView * goodsImgV;
//***  商品名称  **/
@property (nonatomic, strong) UILabel     * goodsNameLab;
//***  商品价格  **/
@property (nonatomic, strong) UILabel     * goodsPriceLab;
//***  商品原价格  **/
@property (nonatomic, strong) UILabel     * goodsOldPriceLab;
//***  删除线  **/
@property (nonatomic, strong) UIView      * line;
@end

@implementation KLStoreGoodsViewBtn

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self configerUI];
    }
    return self;
}

- (void)configerUI {
    [self goodsImgV];
    [self goodsNameLab];
    [self goodsPriceLab];
    [self goodsOldPriceLab];
}

- (void)setGoodsImg:(NSString *)goodsImg {
    _goodsImg = goodsImg;
    self.goodsImgV.image =[UIImage imageNamed:goodsImg];
}
- (void)setGoodsName:(NSString *)goodsName {
    _goodsName = goodsName;
    self.goodsNameLab.text = goodsName;
}
- (void)setGoodsPrice:(NSString *)goodsPrice {
    _goodsPrice = goodsPrice;
    self.goodsPriceLab.text = goodsPrice;
}
- (void)setGoodsOldPrice:(NSString *)goodsOldPrice {
    _goodsOldPrice = goodsOldPrice;
    self.goodsOldPriceLab.text = goodsOldPrice;
    CGFloat width = [UILabel getWidthWithTitle:self.goodsOldPriceLab.text font:self.goodsOldPriceLab.font];
    [self.goodsOldPriceLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset = AdaptedHeight(-5);
        make.height.mas_equalTo(self.goodsPriceLab);
        make.width.offset =width;
        make.left.offset =AdaptedWidth(5);
    }];
    [self.line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self.goodsOldPriceLab);
        make.height.offset =1;
        make.width.offset =width + AdaptedWidth(10);
    }];
}



- (UIImageView *)goodsImgV {
    if (!_goodsImgV){
        _goodsImgV = [UIImageView zj_imageViewWithImage:nil
                                              SuperView:self
                                            constraints:^(MASConstraintMaker *make) {
                                                make.left.top.offset = 0;
                                                make.right.offset =AdaptedWidth(-20);
                                                make.height.offset =AdaptedHeight(86);
                                            }];
        _goodsImgV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goodsImgV;
}

- (UILabel *)goodsNameLab {
    if (!_goodsNameLab){
        
        _goodsNameLab = [UILabel zj_labelWithFontSize:12
                                                lines:1
                                                 text:nil
                                            textColor:RGBSigle(51)
                                            superView:self
                                          constraints:^(MASConstraintMaker *make) {
                                              make.left.right.offset = 0;
                                              make.top.mas_equalTo(self.goodsImgV.mas_bottom).offset =AdaptedHeight(12);
                                              make.height.offset =AdaptedHeight(15);
                                          }];
    }
    return _goodsNameLab;
}


- (UILabel *)goodsPriceLab {
    if (!_goodsPriceLab){
        _goodsPriceLab = [UILabel zj_labelWithFontSize:12
                                             lines:1
                                              text:nil
                                         textColor:RedColor
                                         superView:self
                                       constraints:^(MASConstraintMaker *make) {
                                           make.height.offset =AdaptedHeight(15);
                                           make.top.mas_equalTo(self.goodsNameLab.mas_bottom).offset =AdaptedHeight(9);
                                           make.left.right.offset =0;
                                       }];
    }
    return _goodsPriceLab;
}


- (UILabel *)goodsOldPriceLab {
    if (!_goodsOldPriceLab){
        _goodsOldPriceLab = [UILabel zj_labelWithFontSize:10
                                               lines:1
                                                text:nil
                                           textColor:TextColor
                                           superView:self
                                         constraints:^(MASConstraintMaker *make) {
                                             make.bottom.offset = AdaptedHeight(-5);
                                             make.height.left.right.mas_equalTo(self.goodsPriceLab);
                                         }];
    }
    return _goodsOldPriceLab;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self
                                 constraints:^(MASConstraintMaker *make) {
                                     make.centerX.centerY.mas_equalTo(self.goodsOldPriceLab);
                                     make.height.offset =1;
                                     make.width.offset =AdaptedWidth(50);
                                 }];
    }
    return _line;
}

@end




/***************************    KLStoreGoodsCell    ********************/

@interface KLStoreGoodsCell ()
@property (nonatomic, strong) UIScrollView   * titleScrollView;
@property (nonatomic, strong) UIView         * line;
@property (nonatomic, strong) NSMutableArray * buttonArray;
@property (nonatomic, assign) NSInteger        titleMarkCount;

@end


@implementation KLStoreGoodsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.titleScrollView];
        [self line];
        [self.titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.offset =0;
            make.height.offset =AdaptedHeight(40);
        }];
        
        [self.contentView addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset =0;
            make.top.mas_equalTo(self.line.mas_bottom);
            make.height.offset =AdaptedHeight(180);
        }];
    }
    return self;
}


- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.offset =AdaptedWidth(15);
                                     make.right.offset =0;
                                     make.top.offset =AdaptedHeight(40);
                                     make.height.offset = 0.5f;
                                 }];
    }
    return _line;
}

//***  滚动背景  **/
- (UIScrollView *)titleScrollView {
    if (!_titleScrollView){
        _titleScrollView = [[UIScrollView alloc]init];
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.showsVerticalScrollIndicator = NO;
    }
    return _titleScrollView;
}
- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray =[NSMutableArray array];
    }
    return _buttonArray;
}

- (void)setTitleArray:(NSArray *)titleArray {
    self.titleMarkCount++;
    if (self.titleMarkCount > 1) {
        return;
    }
    //单行布局 不需要考虑换行的问题
    CGFloat marginX = AdaptedWidth(30);  //按钮距离左边和右边的距离
    CGFloat marginY = 0;  //按钮距离布局顶部的距离
    CGFloat toTop   = 0;  //布局区域距离顶部的距离
    CGFloat gap     = AdaptedWidth(10);    //按钮与按钮之间的距离
    NSInteger col   = 4;    //这里只布局5列
    NSInteger count = titleArray.count;  //这里先设置布局5个按钮
    
    CGFloat viewWidth = MainWidth - AdaptedWidth(10);  //视图的宽度
    CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1)*gap)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
    CGFloat height = AdaptedHeight(40);   //按钮的高度可以根据情况设定 这里设置为相等
    self.titleScrollView.contentSize = CGSizeMake(count*((viewWidth - marginX)/col)+ gap, AdaptedHeight(40));
    
    UIButton *lastItem = nil;   //上一个按钮
    //准备工作完毕 既可以开始布局了
    for (int i = 0 ; i < count; i++) {
        UIButton * item =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonArray addObject:item];
        item.tag = i + 300;
        [item setTitle:titleArray[i] forState:UIControlStateNormal];
        [item setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        [item setTitleColor:MainColor forState:UIControlStateSelected];
        item.titleLabel.font =kFont_15;
        [item addTarget:self action:@selector(btnChick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrollView addSubview:item];
        if (i == 0) {
            item.selected = YES;
            
        }else{
            item.selected = NO;
        }
        //布局
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
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
        lastItem = item;
    }
}

- (void)btnChick:(UIButton *)sender {
    CGRect centerRect = CGRectMake(sender.centerX - CGRectGetWidth(self.titleScrollView.bounds)/2, 0, CGRectGetWidth(self.titleScrollView.bounds), CGRectGetHeight(self.titleScrollView.bounds));
    [self.titleScrollView scrollRectToVisible:centerRect animated:YES];
    for (UIButton * btn in _buttonArray) {
        btn.selected = NO;
    }
    sender.selected =YES;
    klWeakSelf;
    self.btnChick ? self.btnChick(sender,weakSelf) : nil;
}





//***  滚动背景  **/
- (UIScrollView *)scrollView {
    if (!_scrollView){
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (void)setItemsArray:(NSMutableArray *)itemsArray {
    self.markCount++;
    if (self.markCount > 1) {
        return;
    }
    //单行布局 不需要考虑换行的问题
    CGFloat marginX = AdaptedWidth(10);  //按钮距离左边和右边的距离
    CGFloat marginY = AdaptedHeight(10);  //按钮距离布局顶部的距离
    CGFloat toTop = 0;  //布局区域距离顶部的距离
    CGFloat gap = AdaptedWidth(8);    //按钮与按钮之间的距离
    NSInteger col = 3;    //这里只布局5列
    NSInteger count = itemsArray.count;  //这里先设置布局5个按钮
    
    CGFloat viewWidth = MainWidth + AdaptedWidth(90);  //视图的宽度
    CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1)*gap)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
    CGFloat height = AdaptedHeight(160);   //按钮的高度可以根据情况设定 这里设置为相等
    self.scrollView.contentSize = CGSizeMake(count*((viewWidth - marginX)/col)+ gap, AdaptedHeight(180));
    
    UIButton *lastItem = nil;   //上一个按钮
    //准备工作完毕 既可以开始布局了
    for (int i = 0 ; i < count; i++) {
        KLStoreGoodsViewBtn * item =[[KLStoreGoodsViewBtn alloc]initWithFrame:CGRectZero];
        item.tag = i + 400;
        item.goodsImg      = itemsArray[i];
        item.goodsName     = @"进口狗粮小型犬10kg...";
        item.goodsPrice    = @"￥2999";
        item.goodsOldPrice = @"￥2999";

        [item addTarget:self action:@selector(goodsBtnChick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:item];
        //布局
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
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
        lastItem = item;
    }
    [self layoutIfNeeded];
}

//***   点击滚动图商品事件  **/
- (void)goodsBtnChick:(KLStoreGoodsViewBtn *)sender {
    
    self.goodsChick ? self.goodsChick(sender) : nil;
}



@end
