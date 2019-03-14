//
//  KLMyOrderManagerController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/11.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyOrderManagerController.h"
#import "KLMyChildOrderListController.h"

@interface KLMyOrderManagerController ()<
SGPageTitleViewDelegate,
SGPageContentScrollViewDelegate
>
@property (nonatomic, strong) SGPageTitleView * pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property (nonatomic, strong) NSMutableArray  * titleArray;
@end

@implementation KLMyOrderManagerController
- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray =[NSMutableArray arrayWithObjects:@"全部",@"待付款",@"待发货",@"待收货",@"待评价", nil];
    }
    return _titleArray;
}
- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"我的订单"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar navBarBottomLineHidden:NO];
     self.view.backgroundColor = [UIColor whiteColor];
    [self setupPageView];
}

- (void)setupPageView {
  
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleFont  = kFont_14;
    configure.titleColor = RGBSigle(51);
    configure.indicatorHeight = 1;
    configure.indicatorCornerRadius = 0.5;
    configure.indicatorToBottomDistance = 5;
    configure.titleSelectedFont = kFont_14;
    configure.titleSelectedColor = MainColor;
    configure.indicatorColor = MainColor;
    configure.indicatorStyle = SGIndicatorStyleDefault;
    configure.bottomSeparatorColor = LineColor;
    
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, MainWidth, 44) delegate:self titleNames:self.titleArray configure:configure];
    self.pageTitleView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = self.indexPage;
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    for (NSString * data in self.titleArray) {
        KLMyChildOrderListController *vc = [[KLMyChildOrderListController alloc]init];
        vc.typeId =[NSString stringWithFormat:@"%@",data];
        [childVCs addObject:vc];
    }
    /// pageContentScrollView
    CGFloat contentViewHeight = MainHeight - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), MainWidth, contentViewHeight) parentVC:self childVCs:childVCs];
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













//- (NSMutableArray *)titleArray{
//    if (!_titleArray) {
//        _titleArray =[NSMutableArray arrayWithObjects:@"全部",@"待付款",@"待发货",@"待收货",@"待评价",@"退货款", nil];
//    }
//    return _titleArray;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self creatScrollViewTitleUI];
//}
//
//#pragma mark - 创建轮播UI
//- (void)creatScrollViewTitleUI{
//
//    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), AdaptedHeight(44)) titles:self.titleArray delegate:self indicatorType:FSIndicatorTypeEqualTitle];
//
//    self.titleView.titleSelectColor = MainColor;
//    self.titleView.indicatorColor   = MainColor;
//
//    self.titleView.titleNormalColor = RGBSigle(51);
//    self.titleView.backgroundColor  = [UIColor whiteColor];
//    self.titleView.titleSelectFont =[UIFont systemFontOfSize:15];
//    self.titleView.selectIndex = 1;
//    [self.view addSubview:_titleView];
//
//    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
//
//    for (NSString * data in self.dataArray) {
//        KLMyChildOrderListController *vc = [[KLMyChildOrderListController alloc]init];
//        vc.typeId =[NSString stringWithFormat:@"%@",data];
//        [childVCs addObject:vc];
//    }
//
//    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, AdaptedHeight(44)+2, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 90) childVCs:childVCs parentVC:self delegate:self];
//    self.pageContentView.contentViewCurrentIndex = 0;
//    //        self.pageContentView.contentViewCanScroll = NO;//设置滑动属性
//    [self.view addSubview:_pageContentView];
//
//}
//
//
//#pragma mark - FSSegment 代理
//- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
//{
//    self.pageContentView.contentViewCurrentIndex = endIndex;
//    //    self.title = self.titleArray[endIndex];
//}
//
//- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
//{
//    self.titleView.selectIndex = endIndex;
//    //    self.title = self.titleArray[endIndex];
//}
//




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
