//
//  KLFlashManagerController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/28.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLFlashManagerController.h"
#import "KLChildsFlashController.h"
@interface KLFlashManagerController ()<
SGPageTitleViewDelegate,
SGPageContentScrollViewDelegate
>
@property (nonatomic, strong) SGPageTitleView * pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property (nonatomic, strong) NSMutableArray  * titleArray;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation KLFlashManagerController


- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"限时抢购"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPageView];
}



- (NSMutableArray *)titleArray {
    if (!_titleArray){
        _titleArray = [NSMutableArray arrayWithObjects:@"6:00",@"8:00",@"10:00",@"12:00",@"14:00",@"16:00",@"18:00",@"20:00",@"22:00",@"00:00", nil];
    }
    return _titleArray;
}


- (void)setupPageView {
    
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle            = SGIndicatorStyleCover;
    configure.titleFont                 = AdaptedSYSFontSize(18);
    configure.titleColor                = TextColor;
    configure.titleSelectedFont         = AdaptedSYSFontSize(18);;
    configure.titleSelectedColor        = [UIColor whiteColor];
    configure.indicatorColor            = MainColor;
    configure.titleGradientEffect       = YES;
    // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.indicatorAdditionalWidth  = MainWidth / 3;
    // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.titleAdditionalWidth      = AdaptedWidth(30);
    // 说明：不设置，遮盖样式下，默认高度为文字高度 + 5；若设置无限大，则高度为 PageTitleView 高度
    configure.indicatorHeight           = AdaptedHeight(59);
    
    
    NSMutableArray * titleSourceArray =[NSMutableArray new];
    [self.titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *string;
        if (idx == 0) {
            string = [NSString stringWithFormat:@"%@\n进行中",obj];
        }else {
            string = [NSString stringWithFormat:@"%@\n即将开始",obj];
        }
        [titleSourceArray addObject:string];
    }];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, MainWidth, AdaptedHeight(59)) delegate:self titleNames:titleSourceArray configure:configure];
    self.pageTitleView.backgroundColor = RGB(255,167,197);
    self.pageTitleView.selectedIndex = 0;
    [self.view addSubview:_pageTitleView];
    
    
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    [self.titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        KLChildsFlashController * vc = [[KLChildsFlashController alloc]init];
        if (idx == 0) {
            vc.type = @"进行中";
            vc.status =@"结束";
        }else {
            vc.type = @"即将开始";
            vc.status =@"开始";
        }
        vc.index = idx;
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
    if (index == 0) {
        self.navigationItem.rightBarButtonItem.customView.hidden = NO;
    } else {
        self.navigationItem.rightBarButtonItem.customView.hidden = YES;
    }
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
