//
//  KLBHomeViewController.m
//  mwstreet
//
//  Created by 科pro on 2018/12/19.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLBHomeViewController.h"
#import "KLAppDelegate.h"
#import "KLMallBannerCell.h"
#import "KLMallClassifyCell.h"
#import "KLMallCollectionTableCell.h"
#import "KLNavigationSearchBtn.h"
#import "KLSearchViewController.h"
#import "KLBHomeHeaderFooterView.h"

#import "KLBGoodsDetailManager.h"
#import "KLBMallGoodsListController.h"//商品列表

@interface KLBHomeViewController ()
<UITableViewDelegate,
UITableViewDataSource,
KLMallCollectionTableDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *dicH;
@property (nonatomic, strong) NSArray *dataAry;
@property (nonatomic, strong) NSArray * btnTitleArray;
@property (nonatomic, strong) KLNavigationSearchBtn *searchBtn; //导航搜索按钮

@end

@implementation KLBHomeViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBtn removeFromSuperview];
    _searchBtn = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.view addSubview:self.searchBtn];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatLetfBackBtn];
    [self.view addSubview:self.tableView];
}

//***  分类点击事件  **/
- (void)didClassifyBtnChick:(UIButton *)sender{
//    switch (sender.tag) {
//        case 10:
//        case 11:
//        case 12:
//        case 13:
//        case 14:
//        case 15:
//        case 16:{
//
//
//        }
//            break;
//        case 17:{
////            KLLivingClassifyController *vc =[[KLLivingClassifyController alloc]init];
////            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//
//        default:
//            break;
//    }
    
    
    KLBMallGoodsListController *vc =[[KLBMallGoodsListController alloc]init];
    vc.navTitle =sender.titleLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
   
    KLLog(@"sender.tag==%ld",sender.tag);

}

//***  搜索响应  **/
- (void)searchBtnChick:(KLNavigationSearchBtn *)sender{
    
//    KLLog(@"搜索响应");
    KLSearchViewController *vc = [[KLSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//***  导航购物车按钮响应  **/
- (void)right_button_event:(UIButton *)sender {
    
    self.tabBarController.selectedIndex = 2;
//    KLLog(@"购物车");
}

//***  导航右边按钮  **/
- (UIButton *)set_rightButton{
    UIButton  *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightBtn setImage:[UIImage imageNamed:@"gouwuche"] forState:UIControlStateNormal];
    //解决偏移问题:
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(-7,0,0, 0);
    return rightBtn;
}


//***  导航返回按钮响应  **/
- (void)left_click:(UIButton *)sender {
    KLAppDelegate *appdelegate = (id)[UIApplication sharedApplication].delegate;
    [appdelegate.window setRootViewController:appdelegate.tabbarC];
    [UIView pushOrPopAnimationType:kCATransitionFromLeft view:appdelegate.window];
}


//***  创建导航右边按钮  **/
- (void)creatLetfBackBtn{
    
    UIButton *leftbutton = [self set_leftButton];
    [leftbutton addTarget:self action:@selector(left_click:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = item;
}

//***  导航返回按钮  **/
- (UIButton *)set_leftButton {
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(-7, -18, 0, 0);
    leftBtn.tintColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    
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



- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight - TabbarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.mCustomClass([KLMallBannerCell class]);
        _tableView.mCustomClass([KLMallClassifyCell class]);
        _tableView.mCustomClass([KLMallCollectionTableCell class]);
        _tableView.mCustomFooterHeaderClass([KLBHomeHeaderFooterView class]);
    }
    return _tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return section == 0 ? 2 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        KLMallBannerCell * cell =kCellIdentifier(KLMallBannerCell);
        cell.carouselView.imageURLStringsGroup = @[@"banner_2",@"banner",@"dianmian"];
        return cell;
        
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        
        KLMallClassifyCell * cell =kCellIdentifier(KLMallClassifyCell);
        @weakify(self);
        cell.classifyBlock = ^(UIButton * _Nonnull sender) {
            @strongify(self)
            [self didClassifyBtnChick:sender];
        };
        [cell setMallArray:self.btnTitleArray];
        return cell;
       
    }else {
        
        KLMallCollectionTableCell *cell = kCellIdentifier(KLMallCollectionTableCell);
        cell.delegate  = self;
        cell.indexPath = indexPath;
        cell.btnHidden = YES;
        cell.oldPriceHidden = NO;
        cell.dataAry   = self.dataAry[indexPath.row];
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        return AdaptedHeight(129);
        
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        
        return AdaptedHeight(158);
        
    }else {
        
        if (self.dicH[indexPath]) {
            NSNumber *num = self.dicH[indexPath];
            return [num floatValue];
        } else {
            return AdaptedHeight(251);
        }
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return section == 1 ? AdaptedHeight(97) : CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  
    if (section == 1) {
        
        KLBHomeHeaderFooterView * headerView = kHeaderFooterIdentifier(KLBHomeHeaderFooterView);
        [headerView setDataArray:@[@"狗用",@"猫用",@"小宠",@"水族"]];
       
        @weakify(self)
        headerView.titleBlock = ^(UIButton * _Nonnull sender) {
            @strongify(self)
            
            NSIndexPath*indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationNone];
           
        };
        return headerView;
    }
    UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
    if (!headerView) {
        headerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerCell"];
    }
    return headerView;
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *footerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerCell"];
    if (!footerView) {
        footerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"footerCell"];
    }
    return footerView;
}



#pragma mark ====== RootTableCellDelegate ======
- (void)updateTableViewCellHeight:(KLMallCollectionTableCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath {
    if (![self.dicH[indexPath] isEqualToNumber:@(height)]) {
        self.dicH[indexPath] = @(height);
        [self.tableView reloadData];
    }
}

//点击UICollectionViewCell的代理方法
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content {
    
    //    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //    [alertView show];
    KLBGoodsDetailManager *vc =[[KLBGoodsDetailManager alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

    
}


- (void)didAddCarSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KLLog(@"indexPath.item == %ld",indexPath.item);
}


- (NSMutableDictionary *)dicH {
    if (!_dicH) {
        _dicH = [[NSMutableDictionary alloc] init];
    }
    return _dicH;
}

- (NSArray *)dataAry {
    if (!_dataAry){
        _dataAry = @[@[@"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u", @"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过人托管人托管人通过人托管人托管人通过人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u", @"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u",@"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u"]];
    }
    return _dataAry;
}

- (NSArray *)btnTitleArray {
    
    if (!_btnTitleArray){
        _btnTitleArray = @[@"主粮",@"零食",@"日用",@"洗护",@"医疗",@"服饰",@"玩具",@"窝垫"];
    }
    return _btnTitleArray;
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
