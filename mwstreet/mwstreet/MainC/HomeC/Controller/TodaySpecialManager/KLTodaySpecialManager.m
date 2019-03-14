//
//  KLTodaySpecialManager.m
//  mwstreet
//
//  Created by 科pro on 2019/1/15.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLTodaySpecialManager.h"
#import "KLChildsViewController.h"

@interface KLTodaySpecialManager ()
<
SGPageTitleViewDelegate,
SGPageContentScrollViewDelegate
>
@property (nonatomic, strong) SGPageTitleView * pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property (nonatomic, strong) NSMutableArray  * titleArray;

@end

@implementation KLTodaySpecialManager



- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray =[NSMutableArray arrayWithObjects:@"今日推荐",@"狗狗服饰",@"玩具",@"医疗",@"零食",@"美妆",@"推荐",@"服饰",@"玩具",@"医疗",@"零食",@"美妆", nil];
    }
    return _titleArray;
}

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"今日特价"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SpacColor;
    [self requestCateTitleData];
    
    [self.navigationController.navigationBar navBarBottomLineHidden:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupPageView];
}

- (void)setupPageView {
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleColor                = RGBSigle(51);
    configure.titleFont                 = kFont_14;
    configure.indicatorHeight           = 1;
    configure.titleAdditionalWidth      = AdaptedWidth(40);
    configure.indicatorCornerRadius     = 0.5;
    configure.indicatorToBottomDistance = 1;
    configure.titleSelectedFont         = kFont_14;
    configure.titleSelectedColor        = MainColor;
    configure.indicatorColor            = MainColor;
    configure.indicatorStyle            = SGIndicatorStyleDefault;
    configure.bottomSeparatorColor      = LineColor;
    
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, MainWidth, 44) delegate:self titleNames:self.titleArray configure:configure];
    self.pageTitleView.backgroundColor =[UIColor whiteColor];
    self.pageTitleView.selectedIndex = 0;
    [self.view addSubview:_pageTitleView];
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    for (NSString * data in self.titleArray) {
        KLChildsViewController *vc = [[KLChildsViewController alloc]init];
        vc.typeId = [NSString stringWithFormat:@"%@",data];
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

#pragma mark ------ 获取分类标题
- (void)requestCateTitleData{
    
    //    kWeakSelf;
    //    [RequestHttp brandCateTopTitleTargetViewController:self Complete:^(NSDictionary *dic) {
    //
    //        CateModel *model =[CateModel mj_objectWithKeyValues:dic];
    //        if (model.status ==1) {
    //
    //            [model.data enumerateObjectsUsingBlock:^(CateData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //                [weakSelf.titleArray addObject:obj.title];
    //                [weakSelf.dataArray addObject:obj];
    //
    //            }];
    //            [weakSelf creatScrollViewTitleUI];
    //
    //        }else{
    //            [EasyShowTextView showText:model.msg];
    //        }
    //    } unfinished:^(NSError *error) {
    //
    //    }];
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
