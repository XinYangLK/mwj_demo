//
//  KLBGoodsDetailMsgManager.m
//  mwstreet
//
//  Created by 科pro on 2019/2/27.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBGoodsDetailMsgManager.h"
#import "KLBGoodsDetailWebController.h"
#import "KLBGoodsDetailController.h"
@interface KLBGoodsDetailMsgManager ()<
SGPageTitleViewDelegate,
SGPageContentScrollViewDelegate
>
@property (nonatomic, strong) SGPageTitleView * pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property (nonatomic, strong) NSMutableArray  * titleArray;

@end

@implementation KLBGoodsDetailMsgManager

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray =[NSMutableArray arrayWithObjects:@"产品属性",@"图文详情",nil];
    }
    return _titleArray;
}
-(void)viewDidLoad {
    [super viewDidLoad];
    [self setupPageView];
    
    self.view.backgroundColor =[UIColor cyanColor];
}

- (void)setupPageView {
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle = SGIndicatorStyleDefault;
    configure.titleFont = kFont_14;
    configure.titleColor = TitleColor;
    configure.titleSelectedFont = kFont_14;
    configure.titleSelectedColor = MainColor;
    configure.indicatorColor = MainColor;
    configure.showVerticalSeparator =YES;
    configure.verticalSeparatorColor = LineColor;
    configure.bottomSeparatorColor = LineColor;
    configure.verticalSeparatorReduceHeight = AdaptedHeight(15);
    configure.indicatorAdditionalWidth = MainWidth / 2;
    // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.indicatorHeight = 1.5;
    // 说明：不设置，遮盖样式下，默认高度为文字高度 + 5；若设置无限大，则高度为 PageTitleView 高度
    configure.titleGradientEffect = YES;
    
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, MainWidth, AdaptedHeight(40)) delegate:self titleNames:self.titleArray configure:configure];
    self.pageTitleView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;
    
    
    KLBGoodsDetailController *oneVC = [[KLBGoodsDetailController alloc] init];
    KLBGoodsDetailWebController *twoVC = [[KLBGoodsDetailWebController alloc] init];
    NSArray * childArr = @[oneVC, twoVC];
    
    /// pageContentScrollView
    CGFloat contentViewHeight = MainHeight - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), MainWidth, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:_pageContentScrollView];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:selectedIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index {
    /// 说明：在此获取标题or当前子控制器下标值
    //    if (index == 0) {
    //        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //    } else {
    //        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    //    }
}










@end
