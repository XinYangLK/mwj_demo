//
//  KLRichListManagerController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLRichListManagerController.h"
#import "KLRichChildDistributorsVC.h"

@interface KLRichListManagerController ()
<
SGPageTitleViewDelegate,
SGPageContentScrollViewDelegate
>
@property (nonatomic, strong) SGPageTitleView         * pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView * pageContentScrollView;
@property (nonatomic, strong) NSMutableArray          * titleArray;

@end

@implementation KLRichListManagerController

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray =[NSMutableArray arrayWithObjects:@"总部分销商",@"我的好友",nil];
    }
    return _titleArray;
}
- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"财富排行榜"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar navBarBottomLineHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupPageView];
}

- (void)setupPageView {
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle = SGIndicatorStyleCover;
    configure.titleFont = kFont_14;
    configure.titleColor = BMainColor;
    configure.titleSelectedFont = kFont_14;
    configure.titleSelectedColor = [UIColor whiteColor];
    configure.indicatorColor = BMainColor;
    configure.showVerticalSeparator =YES;
    configure.verticalSeparatorColor = [UIColor whiteColor];
    configure.indicatorAdditionalWidth = MainWidth / 2;
    // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.indicatorHeight = AdaptedHeight(40);
    // 说明：不设置，遮盖样式下，默认高度为文字高度 + 5；若设置无限大，则高度为 PageTitleView 高度
    configure.titleGradientEffect = YES;
    
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(AdaptedWidth(50), 0, MainWidth- AdaptedWidth(100), AdaptedHeight(30)) delegate:self titleNames:self.titleArray configure:configure];
    [self.pageTitleView setLayerCornerRadius:5 borderWidth:1 borderColor:BMainColor];
    self.pageTitleView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;
    
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < self.titleArray.count; i++) {
        KLRichChildDistributorsVC *vc = [[KLRichChildDistributorsVC alloc]init];
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
