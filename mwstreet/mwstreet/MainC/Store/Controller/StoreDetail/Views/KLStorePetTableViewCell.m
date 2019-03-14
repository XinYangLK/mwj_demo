//
//  KLStorePetTableViewCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/30.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStorePetTableViewCell.h"

@interface KLStorePetViewBtn ()
//***  宠物图片  **/
@property (nonatomic, strong) UIImageView * petImgV;
//***  宠物名称  **/
@property (nonatomic, strong) UILabel     * petNameLab;
//***  宠物年龄  **/
@property (nonatomic, strong) UILabel     * petAgeLab;
//***  宠物价格  **/
@property (nonatomic, strong) UILabel     * petPriceLab;

@end

@implementation KLStorePetViewBtn

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self configerUI];
    }
    return self;
}

- (void)configerUI {
    [self petImgV];
    [self addSubview:self.petNameLab];
    [self petAgeLab];
    [self petPriceLab];
}

- (void)setPetImg:(NSString *)petImg {
    _petImg = petImg;
    self.petImgV.image =[UIImage imageNamed:petImg];
}
- (void)setPetName:(NSString *)petName {
    _petName = petName;
    self.petNameLab.text = petName;

}
- (void)setPetAge:(NSString *)petAge {
    _petAge = petAge;
    self.petAgeLab.text = petAge;
}
- (void)setPetPrice:(NSString *)petPrice {
    _petPrice = petPrice;
    self.petPriceLab.text = petPrice;
}



- (UIImageView *)petImgV {
    if (!_petImgV){
        _petImgV = [UIImageView zj_imageViewWithImage:nil SuperView:self constraints:^(MASConstraintMaker *make) {
            make.left.top.right.offset = 0;
            make.height.offset =AdaptedHeight(97);
        }];
        [_petImgV setLayerCornerRadius:5];
    }
    return _petImgV;
}

- (UILabel *)petNameLab {
    if (!_petNameLab){
        
        _petNameLab = [UILabel zj_labelWithFrame:CGRectMake(0, AdaptedHeight(75), AdaptedWidth(61), AdaptedHeight(22))
                                            text:nil
                                        fontSize:12
                                          isBold:NO
                                       textColor:[UIColor whiteColor]
                                    textAligment:NSTextAlignmentCenter
                                        numLines:1];
        [_petNameLab clipCornViewWith:UIRectCornerTopRight withCornRad:CGSizeMake(5, 5)];

        _petNameLab.backgroundColor = AlphaColor(33,0.5);
    }
    return _petNameLab;
}


- (UILabel *)petAgeLab {
    if (!_petAgeLab){
        _petAgeLab = [UILabel zj_labelWithFontSize:12
                                              lines:1
                                               text:nil
                                          textColor:TextColor
                                          superView:self
                                        constraints:^(MASConstraintMaker *make) {
                                            make.height.offset =AdaptedHeight(14);
                                            make.top.mas_equalTo(self.petImgV.mas_bottom).offset =AdaptedHeight(9);
                                            make.left.right.offset =0;
                                        }];
    }
    return _petAgeLab;
}


- (UILabel *)petPriceLab {
    if (!_petPriceLab){
        _petPriceLab = [UILabel zj_labelWithFontSize:14
                                               lines:1
                                                text:nil
                                           textColor:RedColor
                                           superView:self
                                         constraints:^(MASConstraintMaker *make) {
                                             make.bottom.offset =AdaptedHeight(-5);
                                             make.height.left.right.mas_equalTo(self.petAgeLab);
                                         }];
    }
    return _petPriceLab;
}

@end



/***************************    KLStorePetTableViewCell    ********************/

@interface KLStorePetTableViewCell ()

@property (nonatomic, strong) UIScrollView   * titleScrollView;
@property (nonatomic, strong) UIView         * line;
@property (nonatomic, strong) NSMutableArray * buttonArray;
@property (nonatomic, assign) NSInteger        titleMarkCount;
@end


@implementation KLStorePetTableViewCell

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
        item.tag = i + 200;
        [item setTitle:titleArray[i] forState:UIControlStateNormal];
        [item setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
        [item setTitleColor:MainColor forState:UIControlStateSelected];
        item.titleLabel.font =kFont_15;
        [item addTarget:self action:@selector(btnChick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrollView addSubview:item];
        item.selected = i == 0 ?  YES :  NO;
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
    self.btnChick(sender,weakSelf);
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
    CGFloat toTop = AdaptedHeight(10);  //布局区域距离顶部的距离
    CGFloat gap = AdaptedWidth(8);    //按钮与按钮之间的距离
    NSInteger col = 3;    //这里只布局5列
    NSInteger count = itemsArray.count;  //这里先设置布局5个按钮
    
    CGFloat viewWidth = MainWidth + AdaptedWidth(90);  //视图的宽度
    CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1)*gap)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
    CGFloat height = AdaptedHeight(150);   //按钮的高度可以根据情况设定 这里设置为相等
    self.scrollView.contentSize = CGSizeMake(count*((viewWidth - marginX)/col)+ gap, AdaptedHeight(180));
    
    UIButton *lastItem = nil;   //上一个按钮
    //准备工作完毕 既可以开始布局了
    for (int i = 0 ; i < count; i++) {
        KLStorePetViewBtn * item =[[KLStorePetViewBtn alloc]initWithFrame:CGRectZero];
        item.tag = i + 22;
        item.petImg      = itemsArray[i];
        item.petName    = @"阿拉斯加";
        item.petAge     = @"三个月零20天";
        item.petPrice   = @"￥2999";
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
- (void)goodsBtnChick:(KLStorePetViewBtn *)sender {
    
    self.goodsChick(sender);
    
}



@end
