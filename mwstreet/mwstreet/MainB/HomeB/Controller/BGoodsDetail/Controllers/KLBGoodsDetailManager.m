//
//  KLBGoodsDetailManager.m
//  mwstreet
//
//  Created by 科pro on 2019/2/27.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBGoodsDetailManager.h"
#import "KLNavigationBarTitleView.h"
#import "KLBGoodsMessageController.h"
#import "KLBGoodsDetailMsgManager.h"

@interface KLBGoodsDetailManager ()
<SGPageTitleViewDelegate,
SGPageContentCollectionViewDelegate
>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;

@end

@implementation KLBGoodsDetailManager

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar navBarBottomLineHidden:YES];
    [self creatLetfBackBtn];
    [self setupPageView];
}

- (void)setupPageView {
    NSArray *titleArr = @[@"商品", @"详情"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle = SGIndicatorStyleCover;
    configure.titleFont = kFont_14;
    configure.titleColor = TitleColor;
    configure.titleSelectedFont = kFont_14;
    configure.titleSelectedColor = [UIColor whiteColor];
    configure.indicatorColor = MainColor;
    configure.showVerticalSeparator =YES;
    configure.verticalSeparatorColor = LineColor;
    configure.bottomSeparatorColor = LineColor;
    configure.indicatorAdditionalWidth = MainWidth / 2;
    // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.indicatorHeight = AdaptedHeight(40);
    // 说明：不设置，遮盖样式下，默认高度为文字高度 + 5；若设置无限大，则高度为 PageTitleView 高度
    configure.titleGradientEffect = YES;
    /// pageTitleView
    // 这里的 - 10 是为了让 SGPageTitleView 超出父视图，给用户一种效果体验
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, AdaptedHeight(7), AdaptedWidth(184), AdaptedHeight(30)) delegate:self titleNames:titleArr configure:configure];
    _pageTitleView.backgroundColor = [UIColor clearColor];
    [_pageTitleView setLayerCornerRadius:AdaptedHeight(15) borderWidth:1 borderColor:LineColor];
    // 对 navigationItem.titleView 的包装，为的是 让View 占据整个视图宽度
    KLNavigationBarTitleView *view = [[KLNavigationBarTitleView alloc] initWithFrame:CGRectMake(0, 0, AdaptedWidth(184), 44)];
    self.navigationItem.titleView = view;
    [view addSubview:_pageTitleView];
    
    KLBGoodsMessageController *oneVC = [[KLBGoodsMessageController alloc] init];
    KLBGoodsDetailMsgManager *twoVC = [[KLBGoodsDetailMsgManager alloc] init];
    
    NSArray *childArr = @[oneVC, twoVC];
    
    /// pageContentCollectionView
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight) parentVC:self childVCs:childArr];
    _pageContentCollectionView.delegatePageContentCollectionView = self;
    [self.view addSubview:_pageContentCollectionView];
}

//***  导航返回按钮响应  **/
- (void)left_click:(UIButton *)sender {
   
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)right_click:(UIButton *)sender {
    
    self.tabBarController.selectedIndex =2;
}
//***  创建导航右边按钮  **/
- (void)creatLetfBackBtn{
    
    UIButton *leftbutton = [self set_leftButton];
    [leftbutton addTarget:self action:@selector(left_click:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = item;
    
    UIButton *rightbutton = [self set_rightButton];
    [rightbutton addTarget:self action:@selector(right_click:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = item2;
}
//***  导航返回按钮  **/
- (UIButton *)set_leftButton {
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(-7, -18, 0, 0);
    leftBtn.tintColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    
    return leftBtn;
}

#pragma mark ------ UI 构建
//***  导航右边按钮  **/
- (UIButton *)set_rightButton{
    UIButton  *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightBtn setImage:[UIImage imageNamed:@"gouwuche"] forState:UIControlStateNormal];
    //解决偏移问题:
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(-7,0,0, 0);
    
    return rightBtn;
}



- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];
}

- (void)pageContentCollectionView:(SGPageContentCollectionView *)pageContentCollectionView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}




@end
