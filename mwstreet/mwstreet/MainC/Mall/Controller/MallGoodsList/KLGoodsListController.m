//
//  KLGoodsListController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/4.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLGoodsListController.h"
#import "KLNavigationSearchBtn.h"     //伪导航
#import "UIButton+EnlargeTouchArea.h" //导航按钮点击区域设置
#import "KLMallCollectionViewCell.h"  //商品 item
#import "KLMenuChangeView.h"          //菜单
//#import "KLMenuView.h"              //弹出视图
#import "KLFilterMenuView.h"          //弹出帅选视图

@interface KLGoodsListController ()<
UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate,
UICollectionViewDataSource,
KLMenuChangeViewDelegate
>
@property (nonatomic, strong) KLNavigationSearchBtn * searchBtn; //导航搜索按钮
@property (nonatomic, strong) UICollectionView * collectionView; //列表
@property (nonatomic, strong) NSMutableArray   * dataArray; //商品列表数据
@property (nonatomic, strong) KLMenuChangeView * menuView;  //菜单按钮
@property (nonatomic, strong) KLFilterMenuView * filterMenu;//筛选菜单
@property (nonatomic, assign) BOOL               showType; //判断是否显示菜单

@end

@implementation KLGoodsListController
//***  每次离开移除导航上搜索框 并置空，防止导航titleView保留影响上下级导航界面 **/
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBtn removeFromSuperview];
    self.searchBtn = nil;
}
//*** 由于前级界面导航代理隐藏显示原因--> 需在该界面视图view开始布局时(晚于 viewWillAppear)加载导航搜索框  **/
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //***  放在 viewWillAppear 里加载然后前置 会出现闪现情况 **/
    [self.navigationController.view addSubview:self.searchBtn];
}
//***  视图加载完成 将导航搜索框前置  **/
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.view addSubview:self.searchBtn];
    //    [self.navigationController.view bringSubviewToFront:self.searchBtn];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    KLLog(@"------%@",self.navTitle);
    
    [self configerUI];
}

- (void)configerUI {
    
    [self.navigationController.view addSubview:self.searchBtn];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.menuView];
    
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset =0;
        make.height.offset =AdaptedHeight(44)+1;
    }];
//    [self refreshTableViewData];
}

//***  搜索按钮点击事件  **/
- (void)searchBtnChick:(KLNavigationSearchBtn *)sender {
    
     KLLog(@"搜索按钮点击");
}

//***  导航购物车按钮响应  **/
- (void)right_button_event:(UIButton *)sender {
    self.tabBarController.selectedIndex = 3;
    KLLog(@"购物车");
}
//***  导航返回按钮响应  **/
- (void)left_button_event:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (KLMenuChangeView *)menuView {
    if (!_menuView){
        _menuView = [[KLMenuChangeView alloc]init];
        _menuView.delegate = self;
        _menuView.menuArray = @[@"默认",@"销量",@"价格",@"筛选"];
    }
    return _menuView;
}



- (void)didChange:(KLMenuChangeView *)changeView actionBtnChick:(UIButton *)sender {
    
    if (sender.tag == 103) {
        if (self.showType) {
            
            [self.filterMenu fadeOut];
            self.filterMenu =nil;
            self.showType = NO;
            
        }else{
            
            self.filterMenu =nil;
            if (self.filterMenu) {
                [self filterMenu];
            }
        }
    }else{
        
        if (self.showType) {
            self.showType = NO;
            [self.filterMenu fadeOut];
        }
    }
}


- (KLFilterMenuView *)filterMenu {
    if (!_filterMenu){
        CGFloat y = AdaptedHeight(44) + 1;
        CGFloat h = MainHeight - y;
        klWeakSelf;
        _filterMenu = [[KLFilterMenuView alloc]initWithFrame:CGRectMake(0, y , MainWidth, h)];
        _filterMenu.block = ^(NSString * _Nonnull chooseContent, NSMutableArray * _Nonnull chooseArr) {
            KLLog(@"chooseArr = %@",chooseArr);
        };
        _filterMenu.showBlock = ^(BOOL show) {
            weakSelf.showType = show;
        };
        [_filterMenu showInView:self.view animated:YES];
    }
    return _filterMenu;
}









#pragma mark ------ UI 构建
//***  导航右边按钮  **/
- (UIButton *)set_rightButton{
    UIButton  *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightBtn setImage:[UIImage imageNamed:@"gouwuche"] forState:UIControlStateNormal];
    //解决偏移问题:
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(-7,0,0, 0);
    //解决响应事件的触发范围:
    [rightBtn setEnlargeEdgeWithTop:0 right:0 bottom:0 left:0];
    return rightBtn;
}
//***  导航返回按钮  **/
- (UIButton *)set_leftButton {
    
    UIButton  *leftBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    //解决偏移问题:
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(-7,0,0, 0);
    //解决响应事件的触发范围:
    [leftBtn setEnlargeEdgeWithTop:0 right:0 bottom:0 left:0];
    return leftBtn;
    
}

//***  自定义导航伪搜索框  **/
- (KLNavigationSearchBtn *)searchBtn {
    if (!_searchBtn){
        CGRect mainViewBounds = self.navigationController.view.bounds;
        _searchBtn = [[KLNavigationSearchBtn alloc]init];
        
        CGFloat statusH = (kDevice_Is_iPhoneX) ? 44 : 24;
        CGFloat x = CGRectGetWidth(mainViewBounds)/2- ((CGRectGetWidth(mainViewBounds)-AdaptedWidth(40))/2)+AdaptedWidth(35);
        CGFloat y = CGRectGetMinY(mainViewBounds)+ statusH;
        CGFloat w = CGRectGetWidth(mainViewBounds)-AdaptedWidth(115);
        CGFloat h = (kDevice_Is_iPhoneX) ? 35 : 30 ;
        _searchBtn.frame = CGRectMake(x, y, w, h);
        _searchBtn.searchLab.text =@"野兽派";
        [_searchBtn addTarget:self action:@selector(searchBtnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

//***  商品列表初始化  **/
- (UICollectionView *)collectionView {
    
    if (!_collectionView){
      
        CGFloat spaceW = AdaptedWidth(10);
        CGFloat spaceH = AdaptedHeight(10);
        CGFloat width = (MainWidth- spaceW * 3 -AdaptedWidth(2)) / 2;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(width, AdaptedHeight(251));
        layout.sectionInset = UIEdgeInsetsMake(spaceH, spaceW, spaceH, spaceW);
        
        CGFloat h = AdaptedHeight(44)+1;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, h ,MainWidth, MainHeight- h - StatusBarAndNavigationBarHeight) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[KLMallCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([KLMallCollectionViewCell class])];
    }
    return _collectionView;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

//item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KLMallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KLMallCollectionViewCell class]) forIndexPath:indexPath];
    cell.goodName =self.dataArray[indexPath.row];
    return cell;
    
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    GoodsListData *goodsModel = self.dataArray[indexPath.item];
    //    GoodsDetailVC *vc =[[GoodsDetailVC alloc]init];
    //    vc.couponID =goodsModel.couponId;
    //    vc.numID = [NSString stringWithFormat:@"%ld",(long)goodsModel.numiid];
    //    [self.navigationController pushViewController:vc animated:YES];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize size = CGSizeZero;
    if (section == 0) {
        size = CGSizeMake(MainWidth, 34);
    }
    return size;
}



//***  数据字典初始化  **/
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray arrayWithObjects:@"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u", @"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过人托管人托管人通过人托管人托管人通过人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u", @"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u",@"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u", nil];
    }
    return _dataArray;
}




////设置每个item的尺寸
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(MainScreen_width/2-3, AdaptedHeight(270));
//
//}



////设置每个item的UIEdgeInsets
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(6, 0, 6, 0);
//
//}

////设置每个item水平间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 3;
//}
//
////设置每个item垂直间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 6;
//
//}


//- (KLMenuView *)menu {
//    if (!_menu){
//        NSArray *dataArray = @[@"新秀丽vwdwd",@"瑞士swewe",@"泰迪cswqvs",@"牧羊犬一iwo",@"铺地往死出生",@"和大赛sdcdfc",@"是多少分上架写kkk",@"新秀丽vwdwd1",@"瑞士swewe1",@"泰迪cswqvs1",@"牧羊犬一iwo1",@"铺地往死出生1",@"和大赛sdcdfc1",@"是多少分上架写kkk1"];
//        CGFloat y = AdaptedHeight(44)+1;
//
//        klWeakSelf;
//        _menu = [[KLMenuView alloc]initWithFrame:CGRectMake(0, y , MainHeight, MainHeight- y) dataArray:dataArray];
//        _menu.chooseContent = self.markChangeText;
//
//        _menu.block = ^(NSString * _Nonnull chooseContent, NSIndexPath * _Nonnull indexPath) {
//            weakSelf.markChangeText = chooseContent;
//
//            UIButton  * button = [weakSelf.menuView viewWithTag:100];
//            [button setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
//
//        };
//        _menu.showBlock = ^(BOOL showStatus) {
//            if (showStatus) {
//            }
//        };
//
//        [_menu showInView:self.view animated:YES];
//    }
//    return _menu;
//}



//if (sender.tag < 100) {
//
//    [self.menu removeFromSuperview];
//    self.menu =nil;
//    if (self.menu) {
//        [self menu];
//    }
//}else{
//    klWeakSelf;
//    self.menu.alpha = 0.0;
//    [UIView animateWithDuration:.25 animations:^{
//        weakSelf.menu.collectionView.frame = CGRectMake(0, 0, MainWidth, 0);
//    }completion:^(BOOL finished) {
//        if (finished){
//            [weakSelf.menu removeFromSuperview];
//            weakSelf.menu = nil;
//        }
//    }];
//}



@end
