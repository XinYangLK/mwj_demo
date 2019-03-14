//
//  KLBargainManagerController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/11.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBargainManagerController.h"
#import "KLBargainingListController.h" //砍价商品列表
#import "KLMyBargainingController.h"   //我的砍价

@interface KLBargainManagerController ()<
SGPageTitleViewDelegate,
SGPageContentScrollViewDelegate
>
@property (nonatomic, strong) SGPageTitleView * pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property (nonatomic, strong) NSMutableArray  * titleArray;

@end

@implementation KLBargainManagerController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"砍价"];
}


//***  导航右边按钮  **/
- (UIButton *)set_rightButton{
    UIButton  *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightBtn setImage:[UIImage imageNamed:@"gev"] forState:UIControlStateNormal];
    return rightBtn;
}

- (void)right_button_event:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"gev"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"grf"] forState:UIControlStateNormal];
    }

    NSDictionary * dict =[[NSDictionary alloc]initWithObjectsAndKeys:@(sender.selected),@"showType",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BargainingShowType" object:nil userInfo:dict];
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray =[NSMutableArray arrayWithObjects:@"砍价商品",@"我的砍价",nil];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar navBarBottomLineHidden:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupPageView];
}

- (void)setupPageView {
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle            = SGIndicatorStyleCover;
    configure.titleFont                 = kFont_14;
    configure.titleColor                = MainColor;
    configure.titleSelectedFont         = kFont_14;
    configure.titleSelectedColor        = [UIColor whiteColor];
    configure.indicatorColor            = MainColor;
    configure.showVerticalSeparator     = YES;
    configure.verticalSeparatorColor    = LineColor;
    configure.bottomSeparatorColor      = LineColor;
    configure.indicatorAdditionalWidth  = MainWidth / 2;
    // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.indicatorHeight           = AdaptedHeight(40);
    // 说明：不设置，遮盖样式下，默认高度为文字高度 + 5；若设置无限大，则高度为 PageTitleView 高度
    configure.titleGradientEffect       = YES;
    CGFloat contentViewHeight = MainHeight - StatusBarAndNavigationBarHeight- TabbarSafeBottomMargin - AdaptedHeight(40);
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, contentViewHeight , MainWidth, AdaptedHeight(40)) delegate:self titleNames:self.titleArray configure:configure];
    self.pageTitleView.backgroundColor = [UIColor whiteColor];
    [self.pageTitleView setImages:@[@"kanjiajia",@"wofer"] selectedImages:@[@"vbyj",@"wofer_h"] imagePositionType:SGImagePositionTypeDefault spacing:8];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;
    
    
    KLBargainingListController * oneVc = [[KLBargainingListController alloc]init];
    KLMyBargainingController * twoVc = [[KLMyBargainingController alloc]init];
    NSArray *childVCs  = @[oneVc, twoVc];
    
    /// pageContentScrollView
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, contentViewHeight) parentVC:self childVCs:childVCs];
    _pageContentScrollView.isScrollEnabled = NO;
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
