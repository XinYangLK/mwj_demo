//
//  KLMeBOrderManger.m
//  mwstreet
//
//  Created by 科pro on 2019/2/28.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMeBOrderManger.h"
#import "KLMeBChildOrderListController.h"

@interface KLMeBOrderManger ()<
SGPageTitleViewDelegate,
SGPageContentScrollViewDelegate
>
@property (nonatomic, strong) SGPageTitleView * pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property (nonatomic, strong) NSMutableArray  * titleArray;
@end

@implementation KLMeBOrderManger

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray =[NSMutableArray arrayWithObjects:@"全部",@"待付款",@"待发货",@"待收货",@"退货单", nil];
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
    
    [self.titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        KLMeBChildOrderListController *vc = [[KLMeBChildOrderListController alloc]init];
        vc.typeId = idx;
        [childVCs addObject:vc];
    }];
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
