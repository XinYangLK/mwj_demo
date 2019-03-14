//
//  KLSearchViewController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/21.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLSearchViewController.h"
#import "UIButton+EnlargeTouchArea.h" //导航按钮点击区域设置
#import "KLSearchHeaderView.h"

@interface KLSearchViewController ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar * customSearchBar;//导航栏搜索
@property (nonatomic, strong) UIView      * historyView;    //搜索历史按钮view

@end

@implementation KLSearchViewController

//***  每次进入加载导航上搜索框  **/
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.view addSubview:self.customSearchBar];
}
//***  每次离开移除导航上搜索框 并置空，防止导航titleView保留影响上下级导航界面 **/
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.customSearchBar removeFromSuperview];
    self.customSearchBar = nil;
}
//***  保持界面加载完（避免上下级界面pop与键盘响应卡顿，不流畅） -- 搜索框响应状态 ， **/
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.customSearchBar becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建searchBar
    [self creatSearchHistoryView];
}



#pragma mark -- 点击事件
//***  导航点击事件  **/
- (void)left_button_event:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)right_button_event:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//***   搜索  **/
- (void)getGoodsListsBySearch:(NSString *)keyword {
    
    KLLog(@"--------%@",keyword);
    //    SearchResultViewController *vc = [[SearchResultViewController alloc] init];
    //    vc.keyword = keyword;
    //    [self.navigationController pushViewController:vc animated:NO];
}
/**
 * 清空历史
 */
- (void)allClearBtnAction{
    NSArray *array = [kUSER_DEFAULT objectForKey:@"SearchHistory"];
    array = @[];
    [kUSER_DEFAULT setObject:array forKey:@"SearchHistory"];
    [self.historyView removeFromSuperview];
    self.historyView = nil;
    [self creatSearchHistoryView];
}

/**
 * 搜索历史按钮点击
 */
- (void)searchHistoryButtonClick:(UIButton *)sender {
    [self getGoodsListsBySearch:sender.titleLabel.text];
}

#pragma mark -- searchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSArray *array = [kUSER_DEFAULT objectForKey:@"SearchHistory"];
    NSMutableArray *historyArray = [[NSMutableArray alloc] initWithArray:array];
    if (historyArray == nil) {
        historyArray = [NSMutableArray arrayWithCapacity:0];
    }
    if (![historyArray containsObject:searchBar.text]) {
        if (historyArray.count > 5) {
            [historyArray removeObjectAtIndex:0];
        }
        [historyArray addObject:searchBar.text];
        [kUSER_DEFAULT setObject:historyArray forKey:@"SearchHistory"];
        [self.historyView removeFromSuperview];
        self.historyView = nil;
        [self creatSearchHistoryView];
    }
    [self getGoodsListsBySearch:searchBar.text];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    return YES;
}






#pragma mark ------ UI 构建
//***  导航右边按钮  **/
- (UIButton *)set_rightButton{
    UIButton  *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
    rightBtn.titleLabel.font =kFont_15;
    //解决偏移问题:
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(-7,0,0, 0);
    //解决响应事件的触发范围:
    [rightBtn setEnlargeEdgeWithTop:0 right:0 bottom:0 left:0];
    return rightBtn;
}
////***  导航返回按钮  **/
//- (UIButton *)set_leftButton {
//    
//    UIButton  *leftBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
//    [leftBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
//    //解决偏移问题:
//    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(-7,0,0, 0);
//    //解决响应事件的触发范围:
//    [leftBtn setEnlargeEdgeWithTop:0 right:0 bottom:0 left:0];
//    return leftBtn;
//    
//}

////创建导航栏searchBar
- (UISearchBar *)customSearchBar {
    if (!_customSearchBar) {
        
        CGRect mainViewBounds = self.navigationController.view.bounds;
        CGFloat statusH = (kDevice_Is_iPhoneX) ? 44 : 24;
        CGFloat x = CGRectGetWidth(mainViewBounds)/2- ((CGRectGetWidth(mainViewBounds)-AdaptedWidth(40))/2)+AdaptedWidth(35);
        CGFloat y = CGRectGetMinY(mainViewBounds)+ statusH;
        CGFloat w = CGRectGetWidth(mainViewBounds)-AdaptedWidth(115);
        CGFloat h = (kDevice_Is_iPhoneX) ? 35 : 30 ;

        _customSearchBar = [[UISearchBar alloc] init];
        _customSearchBar.frame = CGRectMake(x, y, w, h);
        _customSearchBar.layer.masksToBounds = YES;
        _customSearchBar.layer.cornerRadius = 5.0f;
        _customSearchBar.placeholder = @" 搜索商品";
        //改变searchBar背景色
        UIView *firstSubView = _customSearchBar.subviews.firstObject;
        firstSubView.backgroundColor = RGBSigle(245);
        //移除原有背景view
        UIView *backgroundImageView = [firstSubView.subviews firstObject];
        [backgroundImageView removeFromSuperview];
        
        UITextField *searchField = [_customSearchBar valueForKey:@"searchField"];
        [_customSearchBar showsSearchResultsButton];
        if (searchField) {
            searchField.frame =CGRectMake(0, 0, _customSearchBar.mj_w, 30);
            [searchField setBackgroundColor:RGBSigle(245)];
            searchField.tintColor =MainColor;
            searchField.font = [UIFont systemFontOfSize:14];
            searchField.layer.cornerRadius = 5.0f;
            searchField.layer.masksToBounds = YES;
        }
        _customSearchBar.delegate = self;
        _customSearchBar.showsCancelButton = NO;
    }
    return _customSearchBar;
}

//创建搜索按钮view
- (void)creatSearchHistoryView {
    if (_historyView != nil) {
        _historyView = nil;
    }else {
        _historyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight-StatusBarAndNavigationBarHeight)];
        _historyView.backgroundColor = [UIColor whiteColor];
        
        KLSearchHeaderView *header = [[KLSearchHeaderView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, AdaptedHeight(40))];
        header.titleLab.text =@"热门搜索";
        header.delectBtn.hidden =YES;
        [_historyView addSubview:header];

       
        NSArray *hotArray = @[@"xcc",@"vfdfvfdbdfb",@"dfbdfbdfb",@"xcc"];
        CGFloat hotW = 13.5;//记录每一行已使用宽度
        CGFloat hotY = AdaptedHeight(50);
        for (int i = 0; i < hotArray.count; i ++) {
            UIButton *btn = [self loadButton:hotArray[i]];
            if (btn.mj_w + hotW + 13.5 > MainWidth) {
                hotW = 13.5;
                hotY = hotY + 28 + 10;
                btn.mj_x = hotW;
                btn.mj_y = hotY;
                hotW = btn.mj_x + btn.mj_w + 5;
            }else {
                btn.mj_x = hotW;
                btn.mj_y = hotY;
                hotW = btn.mj_x + btn.mj_w + 5;
            }
            if (btn.mj_w > MainWidth - 27) {
                btn.mj_w = MainWidth - 27;
            }
            [_historyView addSubview:btn];
        }
        CGFloat h =[UIView getBottomViewBottomFrom:self.historyView];
        
        
        
        
        KLSearchHeaderView *header2 = [[KLSearchHeaderView alloc]initWithFrame:CGRectMake(0, h + AdaptedHeight(10), MainWidth, AdaptedHeight(40))];
        header2.titleLab.text =@"最近搜索";
        klWeakSelf;
        header2.delectAllBlock = ^(UIButton * _Nonnull sender) {
            [weakSelf allClearBtnAction];
        };
        [_historyView addSubview:header2];
        
        NSArray *array = [kUSER_DEFAULT objectForKey:@"SearchHistory"];
        CGFloat width = 13.5;//记录每一行已使用宽度
        CGFloat y =  h + AdaptedHeight(55);
        for (int i = 0; i < array.count; i ++) {
            UIButton *btn = [self loadButton:array[i]];
            if (btn.mj_w + width + 13.5 > MainWidth) {
                width = 13.5;
                y = y + 28 + 10;
                btn.mj_x = width;
                btn.mj_y = y;
                width = btn.mj_x + btn.mj_w + 5;
            }else {
                btn.mj_x = width;
                btn.mj_y = y;
                width = btn.mj_x + btn.mj_w + 5;
            }
            if (btn.mj_w > MainWidth - 27) {
                btn.mj_w = MainWidth - 27;
            }
            [_historyView addSubview:btn];
        }
        [self.view addSubview:_historyView];
    }
}
//循环创建button
- (UIButton *)loadButton:(NSString *)text {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat w = [UILabel getWidthWithTitle:text font:[UIFont systemFontOfSize:13]];
    CGFloat width;
    if (w < 22) {
        width = 50.0f;
    }else {
        width = w + 28;
    }
    button.mj_w = width;
    button.mj_h = 28;
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:RGBSigle(102) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.backgroundColor = RGBSigle(245);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 14;
    [button addTarget:self action:@selector(searchHistoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}







/**
 * 清空搜索历史
 */
//- (void)deleteHistoryAction {
//    [self deleteSearchHistory];
//}
//#pragma mark -- 网络请求
//- (void)getSearchHistoryList {
//    NSDictionary *para = [NSDictionary dictionary];
//    if (self.shopID != nil) {
//        para = @{@"userAccessToken":[kUSER_DEFAULT objectForKey:@"userAccessToken"],
//                 @"size":@6,
//                 @"shopId":self.shopID
//                 };
//    }else {
//        para = @{@"userAccessToken":[kUSER_DEFAULT objectForKey:@"userAccessToken"],
//                 @"size":@6
//                 };
//    }
//
//
//    //    para = [NSString pramasList:para.mutableCopy];
//    //    [SVProgressHUD show];
//    //    [Networking postDataFromRequestWithURLString:[NSString stringWithFormat:@"%@%@", BASC_HOST, @"Api/Goods/getHistory"] parameters:para networkingBlock:^(id respond) {
//    //
//    //        if (respond) {
//    //            [SVProgressHUD dismiss];
//    //
//    //            if ([[respond valueForKey:@"status"] intValue] == 1) {
//    //
//    //
//    //                NSArray * array = [SearchModel mj_objectArrayWithKeyValuesArray:respond[@"data"]];
//    //                for (SearchModel * model in array) {
//    //
//    //                    [self.dataArray addObject:model];
//    //
//    //                    [BaseModel insertBySQLWithQueue:model];
//    //                }
//    //
//    //            }else {
//    //                [ZSKJCommonObject shwoHUD:[respond objectForKey:@"msg"] addView:self.view];
//    //            }
//    //            [self.tableView reloadData];
//    //            [self.tableView.mj_header endRefreshing];
//    //        }
//    //    }];
//}
///**
// * 清空搜索历史
// */
//- (void)deleteSearchHistory {
//    //    NSDictionary *para =@{@"userAccessToken":[[NSUserDefaults standardUserDefaults] objectForKey:@"userAccessToken"]};
//    //    para = [NSString pramasList:para.mutableCopy];
//    //    [SVProgressHUD show];
//    //    [Networking postDataFromRequestWithURLString:[BASC_HOST stringByAppendingString:@"Api/Goods/clearHistory"] parameters:para networkingBlock:^(id respond) {
//    //        [SVProgressHUD dismiss];
//    //        if (respond) {
//    //            if ([[respond objectForKey:@"status"] intValue] == 1) {
//    //                [ZSKJCommonObject shwoHUD:@"清除成功" addView:self.view];
//    //                [self.dataArray removeAllObjects];
//    //                [self.tableView reloadData];
//    //
//    //            }else {
//    //                [ZSKJCommonObject shwoHUD:[respond objectForKey:@"msg"] addView:self.view];
//    //            }
//    //            [self.tableView.mj_header endRefreshing];
//    //        }
//    //    }];
//}

@end
