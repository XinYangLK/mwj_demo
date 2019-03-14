//
//  KLScrollActivityView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/23.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLScrollActivityView.h"
#import "KLGoodsButton.h"

@interface KLScrollActivityView()
//***  标题  **/
@property (nonatomic, strong) UILabel       * titleLab;
//***  副标题  **/
@property (nonatomic, strong) UILabel       * textLab;
//***  更多  **/
@property (nonatomic, strong) UIButton      * moreBtn;
//***  滚动画轉  **/
@property (nonatomic, strong) UIScrollView  * scrollView;



//***  数据array  **/
@property (nonatomic, strong) NSArray          * btnArray;
//标题
@property (nonatomic, strong) NSString         * titleStr;
//副标题
@property (nonatomic, strong) NSString         * textStr;
//是否隐藏倒计时
@property (nonatomic, assign) BOOL               hidden;
//***  点击当前cell  **/
@property (nonatomic, strong) NSIndexPath      * indexPath;
@end


@implementation KLScrollActivityView

- (instancetype)initWithFrame:(CGRect)frame title:(nonnull NSString *)title text:(nonnull NSString *)text goodsArray:(nonnull NSArray *)goodsArray hidden:(BOOL)hidden indexPath:(NSIndexPath *)indexPath{
    
    self =[super initWithFrame:frame];
    if (self) {
        self.titleStr = title;
        self.textStr  = text;
        self.btnArray = goodsArray;
        self.hidden   = hidden;
        self.indexPath = indexPath;
        
        [self configUI];
    }
    return self;
}


#pragma mark ------ UI 构建
- (void)configUI {
    
    [self addSubview:self.scrollView];
    [self addSubview:self.titleLab];
    [self addSubview:self.textLab];
   
    [self addSubview:self.moreBtn];
   
    self.titleLab.text = [NSString getBlankString:self.titleStr];
    CGFloat titleLab_W = [UILabel getWidthWithTitle:self.titleLab.text font:self.titleLab.font];
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = AdaptedWidth(10);
        make.top.offset =AdaptedHeight(10);
        make.width.offset = titleLab_W;
        make.height.offset =AdaptedHeight(20);
    }];
    
    self.textLab.text = [NSString getBlankString:self.textStr];
    CGFloat textLab_W = [UILabel getWidthWithTitle:self.textLab.text font:self.textLab.font];
    [self.textLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(15);
        make.centerY.mas_equalTo(self.titleLab);
        make.height.offset =AdaptedHeight(15);
        make.width.offset = textLab_W;
    }];
    
    //***  不隐藏倒计时时才加载  **/
    if (!self.hidden) {
        [self addSubview:self.countdownView];
        [self.countdownView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.textLab.mas_right).offset =AdaptedWidth(8);
            make.height.offset =AdaptedHeight(15);
            make.centerY.mas_equalTo(self.titleLab);
            make.width.offset =AdaptedWidth(84);
        }];
    }
   
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset =AdaptedWidth(-10);
        make.height.offset =AdaptedHeight(30);
        make.width.offset =AdaptedWidth(40);
        make.centerY.mas_equalTo(self.titleLab);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset =AdaptedHeight(40);
        make.left.right.offset =0;
        make.height.offset =AdaptedHeight(170);
    }];
    
    
    //单行布局 不需要考虑换行的问题
    CGFloat marginX = AdaptedWidth(10);  //按钮距离左边和右边的距离
    CGFloat marginY = 0;  //按钮距离布局顶部的距离
    CGFloat toTop = AdaptedHeight(10);  //布局区域距离顶部的距离
    CGFloat gap = AdaptedWidth(3);    //按钮与按钮之间的距离
    NSInteger col = 4;    //这里只布局5列
    NSInteger count = self.btnArray.count;  //这里先设置布局5个按钮
    
    CGFloat viewWidth = MainWidth + AdaptedWidth(90);  //视图的宽度
    CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1)*gap)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
    CGFloat height = AdaptedHeight(150);   //按钮的高度可以根据情况设定 这里设置为相等
    self.scrollView.contentSize = CGSizeMake(count*((viewWidth - marginX)/4)+ gap, AdaptedHeight(170));
    
    UIButton *lastItem = nil;   //上一个按钮
    //准备工作完毕 既可以开始布局了
    for (int i = 0 ; i < count; i++) {
        
        KLGoodsButton * item =[[KLGoodsButton alloc]init];
        item.tag = i + 22;
        item.goodsImg      = [NSString stringWithFormat:@"pic_%u",1 + arc4random()%7];
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
}




- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel createLabelTextColor:RGBSigle(27) font:AdaptedBOLDSYSFontSize(20)];
    }
    return _titleLab;
}

- (UILabel *)textLab {
    if (!_textLab){
        _textLab = [UILabel createLabelTextColor:TitleColor font:kFont_13];
    }
    return _textLab;
}

//***  倒计时 View  **/
- (KLCountdownView *)countdownView {
    if (!_countdownView){
        _countdownView = [[KLCountdownView alloc]initWithFrame:CGRectZero size:AdaptedWidth(15)];
        _countdownView.hidden =self.hidden;
    }
    return _countdownView;
}

- (UIButton *)moreBtn {
    if (!_moreBtn){
        klWeakSelf;
        _moreBtn = [UIButton createBtnTitle:@"更多" titleColor:TitleColor font:kFont_12 imageName:@"more" backgrounColor:[UIColor clearColor] SSImagePositionType:SSImagePositionTypeRight spacing:4 action:^(UIButton * _Nonnull button) {
            //***  回调  **/
            if (weakSelf.moreBlock) {
                weakSelf.moreBlock(button);
            }
        }];
    }
    return _moreBtn;
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


#pragma mark ------ 商品选择 btn响应
- (void)goodsBtnChick:(UIButton *)sender {
    
    CGRect centerRect = CGRectMake(sender.centerX - CGRectGetWidth(self.scrollView.bounds)/2, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds));
    [self.scrollView scrollRectToVisible:centerRect animated:YES];
    //***  回调  **/
    klWeakSelf;
    self.goodsBlock(sender,weakSelf.indexPath);
}


@end
