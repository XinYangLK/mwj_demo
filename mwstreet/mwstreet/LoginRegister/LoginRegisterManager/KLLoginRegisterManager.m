//
//  KLLoginRegisterManager.m
//  mwstreet
//
//  Created by 科pro on 2019/1/17.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLLoginRegisterManager.h"
#import "KLLoginViewController.h"
#import "KLRegisterViewController.h"

@interface KLLoginRegisterManager ()<
UINavigationControllerDelegate,
UIGestureRecognizerDelegate,
SGPageTitleViewDelegate,
SGPageContentScrollViewDelegate
>
@property (nonatomic, strong) SGPageTitleView * pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property (nonatomic, strong) NSMutableArray  * titleArray;
@property (nonatomic, strong) UIImageView     * topImg;
@property (nonatomic, strong) UIImageView     * logoImg;
@property (nonatomic, strong) UIButton        * backBtn;
@end

@implementation KLLoginRegisterManager


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //***  判断进入此界面隐藏导航栏  **/
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (UIButton *)backBtn {
    if (!_backBtn){
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
   
}
- (void)backBtnChick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray =[NSMutableArray arrayWithObjects:@"注册",@"登录", nil];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar navBarBottomLineHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupPageView];
    [self topImg];
    [self logoImg];
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedHeight(15);
        make.height.width.offset =AdaptedHeight(22);
        make.top.offset = StatusBarHeight + 11;
    }];
}



- (UIImageView *)topImg {
    if (!_topImg){
        CGFloat y = AdaptedHeight(192) + StatusBarAndNavigationBarHeight;
        _topImg = [UIImageView zj_imageViewWithImage:@"bjdnf"
                                           SuperView:self.view
                                         constraints:^(MASConstraintMaker *make) {
                                             make.left.top.right.offset = 0;
                                             make.height.offset = y;
                                         }];
    }
    return _topImg;
}

- (UIImageView *)logoImg {
    if (!_logoImg){
        _logoImg = [UIImageView zj_imageViewWithImage:@"tx-h"
                                             SuperView:self.view
                                           constraints:^(MASConstraintMaker *make) {
                                               make.centerX.offset =0;
                                               make.width.height.offset = AdaptedHeight(66);
                                               make.top.offset =37 + StatusBarHeight;
                                           }];
        [_logoImg setLayerCornerRadius:AdaptedHeight(33)];
        
    }
    return _logoImg;
}




- (void)setupPageView {
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleColor                = TextColor;
    configure.titleFont                 = AdaptedBOLDSYSFontSize(16);
    configure.indicatorHeight           = 1.5;
    configure.indicatorCornerRadius     = 0.5;
    configure.indicatorToBottomDistance = 0;
    configure.titleSelectedFont         = AdaptedBOLDSYSFontSize(18);
    configure.titleSelectedColor        = MainColor;
    configure.indicatorColor            = MainColor;
    configure.indicatorStyle            = SGIndicatorStyleFixed;
    configure.indicatorFixedWidth       = MainWidth/2;
    configure.bottomSeparatorColor      = LineColor;
    
    CGFloat y = AdaptedHeight(192) + StatusBarAndNavigationBarHeight;
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, y, MainWidth, 44) delegate:self titleNames:self.titleArray configure:configure];
    self.pageTitleView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = self.indexPage;
    
    KLRegisterViewController * vc1 =[[KLRegisterViewController alloc]init];

    KLLoginViewController * vc2 =[[KLLoginViewController alloc]init];
    NSArray *childVCs = @[vc1,vc2];
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

@end
