//
//  KLSpellGroupOrderMangerController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/15.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLSpellGroupOrderMangerController.h"
#import "KLChildSpellGroupOrderController.h"

@interface KLSpellGroupOrderMangerController ()<
SGPageTitleViewDelegate,
SGPageContentScrollViewDelegate
>
@property (nonatomic, strong) SGPageTitleView * pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property (nonatomic, strong) NSMutableArray  * titleArray;

@end

@implementation KLSpellGroupOrderMangerController

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray =[NSMutableArray arrayWithObjects:@"全部",@"拼团中",@"拼团成功",@"拼团失败",nil];
    }
    return _titleArray;
}
- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"拼团订单"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar navBarBottomLineHidden:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupPageView];
}

- (void)setupPageView {
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleFont = kFont_13;
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
    _pageTitleView.selectedIndex = 0;
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self.pageTitleView resetTitle:@"等待已结束" forIndex:1];
    //    });
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    for (NSString * data in self.titleArray) {
        KLChildSpellGroupOrderController *vc = [[KLChildSpellGroupOrderController alloc]init];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
