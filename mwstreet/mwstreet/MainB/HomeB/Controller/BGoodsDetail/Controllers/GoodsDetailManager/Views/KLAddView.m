//
//  KLAddView.m
//  mwstreet
//
//  Created by 科pro on 2019/2/28.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLAddView.h"
#import "KLShopCartTool.h"
#import "KLGoodsAttributeModel.h"
#import "UIView+SDAutoLayout.h"
#import "BVAddNumView.h"

@interface KLAddView ()<AddNumViewDelegate>{
    
    UIView *_autoMarginViewsContainer;
    UIView *_autoMarginViewsContainer2;
    UIView *_autoMarginViewsContainer3;
    UILabel *_alreadyLb;
    UILabel*_styleLabel;
    NSString *_goodID;
    NSInteger _number;
    NSString *_order_infoStr;

}
@property (nonatomic ,strong) UIButton *selectButton;
@property (nonatomic ,strong) UIButton *selectButton2;
@property (nonatomic ,strong) NSMutableArray *buttonArray;
@property (nonatomic ,strong) NSMutableArray *buttonArray2;
@property (nonatomic ,strong) NSMutableArray *goodsColorArr;
@property (nonatomic ,strong) NSMutableArray *goodsSizeArr;
@property (nonatomic ,strong) NSMutableArray *addViewArr;
@property (nonatomic ,strong) NSMutableDictionary *dic;
/** 商品图片*/
@property (nonatomic ,strong) UIImageView *goodsImg;


@property (nonatomic ,strong) NSMutableDictionary *currentDict;



//***  商品图片背景View  **/
@property (nonatomic, strong) UIView       * imgBgView;

//***  弹出视图空白区域点击  **/
@property (nonatomic, strong) UIView       * allBgView;

//***  弹窗滚动图背景view  **/
@property (nonatomic, strong) UIView       * bgView;

//***  价格lab  **/
@property (nonatomic, strong) UILabel  * priceLb;
//***  名称lab  **/
@property (nonatomic, strong) UILabel  * titleLb;
//***  移除弹窗按钮  **/
@property (nonatomic, strong) UIButton * shutDownBtn;
//***  分割线  **/
@property (nonatomic, strong) UIView   * line;

//***  背景view上滚动视图  **/
@property (nonatomic, strong) UIScrollView * scrollView;
//***  规格标题  **/
@property (nonatomic, strong) UILabel *specLab;
//***  规格标题  **/
@property (nonatomic, strong) UILabel *sizeLb;
//***  加减数量  **/
@property (nonatomic, strong) BVAddNumView * addView;

@end

@implementation KLAddView


- (instancetype)initWithGoodsid:(NSString *)goodsid{
    if (self = [super init]) {
        [self setBackgroundColor:RGBA(150, 150, 150, 0.2)];
        [self layoutUI];
        [self fetchGoodsAttributeWith:goodsid];
        _goodID = goodsid;
        
    }
    return self;
}

-(void)layoutUI{
   
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  
//    [Util addClickEvent:self action:@selector(shutDownBtnClick:) owner:allBgView];
    
    self.allBgView = [UIView zj_viewWithBackColor:[UIColor clearColor]
                                          supView:self
                                      constraints:^(MASConstraintMaker *make) {
                                          make.top.left.right.offset = 0;
                                          make.height.offset = [self topHeight];
                                      }];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shutDownBtnClick:)];
    gesture.numberOfTouchesRequired = 1;
    self.allBgView.userInteractionEnabled = YES;
    [self.allBgView addGestureRecognizer:gesture];
    
    self.bgView = [UIView zj_viewWithBackColor:[UIColor whiteColor]
                                       supView:self constraints:^(MASConstraintMaker *make) {
                                           make.left.offset   = 0;
                                           make.top.offset    = [self topHeight];
                                           make.width.offset  = MainWidth;
                                           make.height.offset = [self VHeight];
                                       }];
    
    self.imgBgView = [UIView zj_viewWithBackColor:[UIColor whiteColor]
                                      supView:self
                                  constraints:^(MASConstraintMaker *make) {
                                      make.left.offset = AdaptedWidth(10);
                                      make.top.offset = [self topHeight]-AdaptedHeight(20);
                                      make.height.width.offset = AdaptedHeight(90);
                                  }];
    
    self.goodsImg = [UIImageView zj_imageViewWithImage:@"pic_6"
                                         SuperView:self.imgBgView
                                       constraints:^(MASConstraintMaker *make) {
                                           make.left.top.offset =AdaptedHeight(5);
                                           make.width.height.offset =AdaptedHeight(80);
                                       }];
    [self.goodsImg setContentMode:UIViewContentModeScaleAspectFit];

    self.titleLb = [UILabel zj_labelWithFontSize:14 textColor:RGBSigle(51)
                                   superView:self.bgView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.top.offset =AdaptedHeight(10);
                                     make.left.mas_equalTo(self.imgBgView.mas_right).offset = AdaptedWidth(10);
                                     make.height.offset =AdaptedHeight(15);
                                     make.right.offset =AdaptedWidth(-60);
                                 }];
    [self.titleLb setText:@"夏日秋装上新"];
    
    self.priceLb = [UILabel zj_labelWithFontSize:14
                                   textColor:RedColor
                                   superView:self.bgView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.right.height.mas_equalTo(self.titleLb);
                                     make.top.mas_equalTo(self.titleLb.mas_bottom).offset =AdaptedHeight(25);
                                 }];
    [self.priceLb setText:@"¥ 49.00"];
    
    
    self.shutDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shutDownBtn setBackgroundImage:[UIImage imageNamed:@"delect"] forState:UIControlStateNormal];
    [self.shutDownBtn addTarget:self action:@selector(shutDownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.shutDownBtn];
    [self.shutDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset =AdaptedHeight(10);
        make.right.offset =AdaptedWidth(-12);
        make.height.width.offset =AdaptedHeight(15);
    }];
    
    self.line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.bgView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.right.offset = 0;
                                     make.height.offset = 0.5f;
                                     make.top.offset = AdaptedHeight(85);
                                 }];

    self.scrollView = [[UIScrollView alloc]init];
    [self.bgView addSubview:self.scrollView];
    
/*---------------------------------规格---------------------------------------*/

    self.specLab = [UILabel zj_labelWithFontSize:14
                                           lines:1
                                            text:@"规格"
                                       textColor:RGBSigle(51)
                                       superView:self.scrollView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.offset   = AdaptedWidth(12);
                                         make.height.offset = AdaptedHeight(15);
                                         make.top.offset    = AdaptedHeight(18);
                                         make.right.offset  = AdaptedWidth(-12);
                                     }];
    
    self.buttonArray = [NSMutableArray array];
    _autoMarginViewsContainer = [UIView new];
    [_scrollView addSubview:_autoMarginViewsContainer];
    NSMutableArray *temp = [NSMutableArray new];
    for (int i = 0; i < self.goodsColorArr.count; i++) {
        KLGoodsAttributeModel *model = self.goodsColorArr[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitle:model.attr_value forState:UIControlStateNormal];
        [btn setTitleColor:TitleColor forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setLayerCornerRadius:3 borderWidth:0.5 borderColor:LineColor];
        [btn setTag:i];
        [btn addTarget:self action:@selector(setlecedColorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_autoMarginViewsContainer addSubview:btn];
        btn.sd_layout.autoHeightRatio(0.5);
        [temp addObject:btn];
        if (i == 0) {
            self.selectButton = btn;
            [self.selectButton setBackgroundColor:MainColor];
            [self.selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.selectButton.layer setBorderColor:[UIColor clearColor].CGColor];
        }
        [_buttonArray addObject:btn];
    }
    [_autoMarginViewsContainer setupAutoMarginFlowItems:[temp copy] withPerRowItemsCount:4 itemWidth:AdaptedWidth(70) verticalMargin:AdaptedHeight(10) verticalEdgeInset:4 horizontalEdgeInset:10];
    
    
    _autoMarginViewsContainer.sd_layout
    .leftSpaceToView(_scrollView, 0)
    .rightSpaceToView(_scrollView, 0)
    .topSpaceToView(_specLab, AdaptedHeight(10));
    
    UIView *view = [[UIView alloc]init];
    [_scrollView addSubview:view];
    view.sd_layout
    .topSpaceToView(_autoMarginViewsContainer, 10)
    .leftSpaceToView(_scrollView, 0)
    .rightSpaceToView(_scrollView, 0)
    .heightIs(40);
    
    
/*-----------------------------数量-------------------------------------------*/

    self.sizeLb = [UILabel zj_labelWithFontSize:14
                                           lines:1
                                            text:@"请选择对应商品数量"
                                       textColor:RGBSigle(51)
                                       superView:view
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.offset   = AdaptedWidth(12);
                                         make.bottom.top.offset    = 0;
                                         make.right.offset  = AdaptedWidth(-12);
                                     }];
    
  
    
    _buttonArray2 = [NSMutableArray array];
    _autoMarginViewsContainer2 = [UIView new];
    [_scrollView addSubview:_autoMarginViewsContainer2];
    NSMutableArray *temp2 = [NSMutableArray new];
    self.addViewArr = [NSMutableArray array];
    for (int i = 0; i < self.goodsSizeArr.count; i++) {
        KLGoodsAttributeModel *model = self.goodsSizeArr[i];
        UIView *view = [UIView new];
        UILabel * lab = [UILabel createLabelTextColor:TitleColor font:kFont_14];
        lab.text = model.attr_value;
        [view addSubview:lab];
        [lab setFrame:CGRectMake(AdaptedWidth(20), 0, AdaptedWidth(50), AdaptedHeight(40))];
        [_autoMarginViewsContainer2 addSubview:view];
        
        _addView = [[BVAddNumView alloc]initWithFrame:CGRectMake(MainWidth-AdaptedWidth(120), AdaptedHeight(5), AdaptedWidth(105), AdaptedHeight(35))];
        [view addSubview:_addView];
        _addView.delegate = self;
        _addView.minInteget = 0;
        _addView.tag = i;
        _addView.size = model.attr_value;
        [self.addViewArr addObject:_addView];
        view.sd_layout.heightIs(AdaptedHeight(40));
        [temp2 addObject:view];
    }
    
    [_autoMarginViewsContainer2 setupAutoWidthFlowItems:[temp2 copy] withPerRowItemsCount:1 verticalMargin:AdaptedHeight(10) horizontalMargin:0 verticalEdgeInset:0 horizontalEdgeInset:0];
    _autoMarginViewsContainer2.sd_layout
    .leftSpaceToView(_scrollView, 0)
    .rightSpaceToView(_scrollView, 0)
    .topSpaceToView(view,0);
    
    
/*------------------------------已选------------------------------------------*/
    
    UILabel * alreadyLb = [UILabel createLabelTextColor:TitleColor font:kFont_14];
    alreadyLb.text = @"已选";
    _alreadyLb = alreadyLb;
    [_scrollView addSubview:_alreadyLb];
    _alreadyLb.sd_layout
    .topSpaceToView(_autoMarginViewsContainer2, AdaptedHeight(5))
    .leftSpaceToView(_scrollView, AdaptedWidth(10))
    .rightSpaceToView(_scrollView, AdaptedWidth(10))
    .heightIs(AdaptedHeight(30));
    
    UILabel *bgLabel = [[UILabel alloc]init];
    [_scrollView addSubview:bgLabel];
    [_styleLabel setBackgroundColor:[UIColor whiteColor]];
    bgLabel.sd_layout
    .topSpaceToView(_alreadyLb, AdaptedHeight(5))
    .leftSpaceToView(_scrollView, AdaptedWidth(10))
    .rightSpaceToView(_scrollView, AdaptedWidth(10))
    .heightIs(AdaptedHeight(20));
    
    UILabel * styleLabel = [UILabel createLabelTextColor:TitleColor font:kFont_14];
    _styleLabel = styleLabel;
    [_scrollView addSubview:_styleLabel];
    [_styleLabel setBackgroundColor:[UIColor whiteColor]];
    [_styleLabel setNumberOfLines:0];
   
    _styleLabel.sd_layout
    .topSpaceToView(_alreadyLb, AdaptedHeight(5))
    .leftSpaceToView(_scrollView, AdaptedHeight(10))
    .rightSpaceToView(_scrollView, AdaptedWidth(10))
    .autoHeightRatio(0);
    
    
/*------------------------------下单------------------------------------------*/

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:leftBtn];
    [leftBtn setBackgroundColor:MainColor];
    [leftBtn setTitle:@"加入进货单" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:kFont_14];
    [leftBtn addTarget:self action:@selector(addShopCartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.sd_layout
    .bottomSpaceToView(_bgView, StatusBarAndNavigationBarHeight + TabbarSafeBottomMargin)
    .leftSpaceToView(_bgView, 0)
    .rightSpaceToView(_bgView, MainWidth/2)
    .heightIs(AdaptedHeight(50));
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:rightBtn];
    [rightBtn setBackgroundColor:RedColor];
    [rightBtn setTitle:@"立即下单" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:kFont_14];
    [rightBtn addTarget:self action:@selector(payShopCartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.sd_layout
    .bottomSpaceToView(_bgView, StatusBarAndNavigationBarHeight + TabbarSafeBottomMargin)
    .leftSpaceToView(_bgView, MainWidth/2)
    .rightSpaceToView(_bgView, 0)
    .heightIs(AdaptedHeight(50));
    
    [_scrollView sd_addSubviews:@[_specLab,_autoMarginViewsContainer,view,_autoMarginViewsContainer2,_alreadyLb,bgLabel,_styleLabel]];
    
    _scrollView.sd_layout
    .topSpaceToView(_line, 0)
    .leftSpaceToView(_bgView, 0)
    .rightSpaceToView(_bgView, 0)
    .bottomSpaceToView(leftBtn, 0);
    [_scrollView setupAutoContentSizeWithBottomView:_styleLabel bottomMargin:AdaptedHeight(20)];
    
}

- (CGFloat)topHeight {
    return MainHeight - AdaptedHeight(520);
}
- (CGFloat)VHeight {
    return  MainHeight - [self topHeight];
}



//***  立即下单  **/
- (void)payShopCartBtnClick:(UIButton *)sender{
    
}
//***  加入进货单  **/
- (void)addShopCartBtnClick:(UIButton *)sender {
    
}

#pragma mark - 增减代理方法
-(void)AddNumView:(BVAddNumView *)view{
//    NSInteger str = view.tag;
    // 将属性放入对应的颜色字典
    KLGoodsAttributeModel *model = self.goodsSizeArr[view.tag];
    NSString * number = [NSString stringWithFormat:@"%ld",view.num];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:number forKey:model.attr_value];
    
    if ([[self.currentDict allKeys] containsObject:self.selectButton.titleLabel.text]) {
        NSLog(@"含有么"); // 如果总字典含有某个颜色对应的字典，就去修改
        NSMutableDictionary *dictt = [self.currentDict objectForKey:self.selectButton.titleLabel.text];
        [dictt setObject:number forKey:model.attr_value];
    }else{
        NSLog(@"插入含有"); // 如果总字典不含有某个颜色对应的字典，就插入
        [self.currentDict setObject:dic forKey:self.selectButton.titleLabel.text];
    }
    
    NSArray *arr =  [self.currentDict allKeys];
    for (int i = 0; i < arr.count; i++) {
        // 查看存入了几种颜色的字典
        NSLog(@"查看查看----%@",arr[i]);
    }
    
    if ([number isEqual:@"0"]) {
        // 如果回传来的数量为0 那么就去清除相对应的字典
        NSMutableDictionary *dic = [self.currentDict objectForKey:self.selectButton.titleLabel.text];
     
        KLLog(@"-----呦呦呦---%@",dic);
        
        [dic removeObjectForKey: view.size];
        
        if ([dic allKeys].count <= 0) {
            [self.currentDict removeObjectForKey:self.selectButton.titleLabel.text];
        }
    }
    
    KLLog(@"made---%@",self.currentDict);
    
    NSString *order_info = @"";
    for (NSInteger i = 0; i < self.currentDict.count; i++) {
        NSArray *keyArr =  [self.currentDict allKeys];
        order_info = [NSString stringWithFormat:@" %@\n%@:",order_info,keyArr[i]];
        NSMutableDictionary *dic = [self.currentDict objectForKey:keyArr[i]];
        NSString *str = @"";
        for (int i = 0; i < dic.count; i++) {
            NSArray *keyArr2 = [dic allKeys];
            str = [NSString stringWithFormat:@"%@ %@/%@件,",str,keyArr2[i],[dic objectForKey:keyArr2[i]]];
        }
        order_info = [order_info stringByAppendingString:str];
        order_info = [NSString stringWithFormat:@"%@\n",order_info];
    }

    [_styleLabel setText:order_info];
      
    [_scrollView layoutSubviews];
    
    NSString *order_info2 = @"";
    for (NSInteger i = 0; i < self.currentDict.count; i++) {
        NSArray *keyArr =  [self.currentDict allKeys];
        order_info2 = [NSString stringWithFormat:@" %@\n%@:",order_info2,keyArr[i]];
        NSMutableDictionary *dic = [self.currentDict objectForKey:keyArr[i]];
        NSString *str = @"";
        for (int i = 0; i < dic.count; i++) {
            NSArray *keyArr2 = [dic allKeys];
            str = [NSString stringWithFormat:@"%@ %@/%@件,",str,keyArr2[i],[dic objectForKey:keyArr2[i]]];
        }
        order_info2 = [order_info2 stringByAppendingString:str];
        order_info2 = [NSString stringWithFormat:@"%@|",order_info2];
        
    }
    
    _order_infoStr = order_info2;
    
    self.specChangeBlock ? self.specChangeBlock(order_info) : nil;
//    NSLog(@"-----%@",order_info2);
}


//***  选择规格点击事件  **/
- (void)setlecedColorBtnClick:(UIButton *)sender {
    
    [self.selectButton setTitleColor:TitleColor forState:UIControlStateNormal];
    [self.selectButton.layer setBorderColor:LineColor.CGColor];
    [self.selectButton setBackgroundColor:[UIColor whiteColor]];
    
    self.selectButton = _buttonArray[sender.tag];
    [self.selectButton setBackgroundColor:MainColor];
    [self.selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.selectButton.layer setBorderColor:[UIColor clearColor].CGColor];
    
    for (_addView in self.addViewArr) {
        [_addView.numLabel setText:@"0"];
        _addView.num = 0;
    }
    
    if ([[self.currentDict allKeys] containsObject:self.selectButton.titleLabel.text]) {
        NSLog(@"有没有呢");
        NSMutableDictionary *dictt = [self.currentDict objectForKey:self.selectButton.titleLabel.text];
        NSLog(@"dic----%@",dictt);
        NSArray *keyArr = [dictt allKeys];
        for (int i = 0; i < keyArr.count; i++) {
            NSString *key = keyArr[i];
            for (_addView in self.addViewArr) {
                if ([_addView.size isEqual:key]) {
                    [_addView.numLabel setText:[NSString stringWithFormat:@"%@",[dictt objectForKey:key]]];
                    _addView.num = [[dictt objectForKey:key] integerValue];
                }
            }
        }
    }else{
        NSLog(@"可能没有");
        for (_addView in self.addViewArr) {
            [_addView.numLabel setText:@"0"];
            _addView.num = 0;
        }
    }
    
}



//***  隐藏 alert  **/
- (void)shutDownBtnClick:(UIButton *)sender{
    
    self.disBtnClick ? self.disBtnClick() : nil;
}


#pragma mark - 获取商品属性
-(void)fetchGoodsAttributeWith:(NSString *)ID{
    
    [KLShopCartTool fetchGoodsAttributeDataSuccess:^(NSMutableArray *colorArr, NSMutableArray *sizeArr) {
        
        [self.goodsColorArr addObjectsFromArray:colorArr];
        [self.goodsSizeArr addObjectsFromArray:sizeArr];
        [self layoutUI];
        
    } codeFailure:^(NSString *codeErr) {
        
    } failure:^(NSError *err) {
        
    }];
}

-(NSMutableArray *)goodsColorArr{
    if (!_goodsColorArr) {
        _goodsColorArr = [NSMutableArray array];
    }
    return _goodsColorArr;
}

-(NSMutableArray *)goodsSizeArr{
    if (!_goodsSizeArr) {
        _goodsSizeArr = [NSMutableArray array];
    }
    return _goodsSizeArr;
}

-(NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

-(NSMutableDictionary *)currentDict{
    if (!_currentDict) {
        _currentDict = [NSMutableDictionary dictionary];
    }
    return _currentDict;
}
@end
