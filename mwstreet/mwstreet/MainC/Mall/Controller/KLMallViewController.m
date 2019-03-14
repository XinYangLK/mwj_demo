//
//  KLMallViewController.m
//  mengWuStreet
//
//  Created by 科pro on 2018/12/17.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLMallViewController.h"
#import "KLNavigationSearchBtn.h"       //伪导航
#import "UIButton+EnlargeTouchArea.h"   //导航按钮点击区域设置
#import "KLMallBannerCell.h"            //轮播图 banner
#import "KLMallClassifyCell.h"          //分类cell
#import "KLMallActivityCell.h"          //活动cell
#import "KLSeckillingAreaCell.h"        //每日抢购cell
#import "KLSpellDealsAreaCell.h"        //新品热卖cell
#import "KLMallAdvertisingCell.h"       //广告图cell
#import "KLMallCollectionTableCell.h"   //商品列表cell
#import "KLGoodsListController.h"       //商品检索列表
#import "KLSearchViewController.h"      //搜索界面
#import "KLLivingClassifyController.h"  //活体分类搜寻
#import "KLGoodsDetailController.h"     //商品详情
#import "KLPackageMailListController.h" //商品列表

@interface KLMallViewController ()<
UITableViewDelegate,
UITableViewDataSource,
KLMallCollectionTableDelegate>

@property (nonatomic, strong) NSArray *dataAry;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *dicH;

@property (nonatomic, strong) KLNavigationSearchBtn *searchBtn; //导航搜索按钮
@property (nonatomic, strong) NSArray *btnTitleArray;
@end

@implementation KLMallViewController

//***  每次离开移除导航上搜索框 并置空，防止导航titleView保留影响上下级导航界面 **/
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBtn removeFromSuperview];
    self.searchBtn = nil;
}
//*** 由于前级界面导航代理隐藏显示原因--> 需在该界面视图view开始布局时(晚于 viewWillAppear)加载导航搜索框  **/

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.view addSubview:self.searchBtn];
}

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

    self.dataAry = @[
                     @[@"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u", @"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过人托管人托管人通过人托管人托管人通过人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u", @"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u",@"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u"]];
    [self configerUI];

}
//***  分类按钮点击事件  **/
- (void)didClassifyBtnChick:(UIButton *)sender{
    switch (sender.tag) {
        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
        case 15:
        case 16:{
            
            KLGoodsListController *vc =[[KLGoodsListController alloc]init];
            vc.navTitle =sender.titleLabel.text;
            [self.navigationController pushViewController:vc animated:YES];
        }
            KLLog(@"sender.tag==%ld",sender.tag);
            break;
        case 17:{
            KLLivingClassifyController *vc =[[KLLivingClassifyController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

//***  搜索响应  **/
- (void)searchBtnChick:(KLNavigationSearchBtn *)sender{
    
    KLLog(@"搜索响应");
    KLSearchViewController *vc = [[KLSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//***  导航购物车按钮响应  **/
- (void)right_button_event:(UIButton *)sender {
    self.tabBarController.selectedIndex = 3;
    KLLog(@"购物车");
}

//***  活动 -- 宠友推荐，特享优惠，有宠定制 **/
- (void)didActiveChick:(KLMallActivityBtn *)sender {
    NSString * navTitle;
    switch (sender.tag) {
        case 1000://宠友推荐
            navTitle = @"宠友推荐";
            break;
        case 1001://特享优惠
            navTitle = @"特享优惠";
            break;
        case 1002://有宠定制
            navTitle = @"有宠定制";
            break;
            
        default:
            break;
    }
    [self didPushGoodsListController:navTitle];
}

//***  商品详情  **/
- (void)didPushGoodsDetailController:(NSInteger)tag cellIndex:(NSInteger)row {
    KLLog(@"======商品 %ld===%ld",tag,row);

    KLGoodsDetailController *vc =[[KLGoodsDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//***  商品列表  **/
- (void)didPushGoodsListController:(NSString *)navTitle {
    
    KLPackageMailListController *vc =[[KLPackageMailListController alloc]init];
    vc.navTitle = navTitle;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark ------ UI 构建

- (void)configerUI {
    [self.navigationController.view addSubview:self.searchBtn];
    [self.view addSubview:self.tableView];
    [self refreshTableViewData];
}

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

//***  自定义导航伪搜索框  **/
- (KLNavigationSearchBtn *)searchBtn {
    if (!_searchBtn){
        CGRect mainViewBounds = self.navigationController.view.bounds;
        _searchBtn = [[KLNavigationSearchBtn alloc]init];
        
        CGFloat statusH = (kDevice_Is_iPhoneX) ? 44 : 24;
        CGFloat x = CGRectGetWidth(mainViewBounds)/2- ((CGRectGetWidth(mainViewBounds)-AdaptedWidth(40))/2);
        CGFloat y = CGRectGetMinY(mainViewBounds)+ statusH;
        CGFloat w = CGRectGetWidth(mainViewBounds)-AdaptedWidth(80);
        CGFloat h = (kDevice_Is_iPhoneX) ? 35 : 30 ;
        _searchBtn.frame = CGRectMake(x, y, w, h);
        _searchBtn.searchLab.text =@"野兽派";
        [_searchBtn addTarget:self action:@selector(searchBtnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}
//***  刷新-加载  **/
-(void)refreshTableViewData{
    
    klWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        //网络刷新请求
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
    self.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        //网络请求
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

//***  lazy  tableView **/
- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight- StatusBarAndNavigationBarHeight - TabbarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStylePlain];
        _tableView.backgroundColor =[UIColor whiteColor];
        //数据超过屏幕时才允许滑动
        _tableView.alwaysBounceVertical = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[UIView new];
        _tableView.mCustomClass([UITableViewCell class]);
        _tableView.mCustomClass([KLMallBannerCell class]);
        _tableView.mCustomClass([KLMallClassifyCell class]);
        _tableView.mCustomClass([KLMallActivityCell class]);
//        _tableView.mCustomClass([KLSeckillingAreaCell class]);
        _tableView.mCustomClass([KLSpellDealsAreaCell class]);
        _tableView.mCustomClass([KLMallAdvertisingCell class]);
        _tableView.mCustomClass([KLMallCollectionTableCell class]);

    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        KLMallBannerCell * cell =kCellIdentifier(KLMallBannerCell);
        cell.carouselView.imageURLStringsGroup = @[@"banner_2",@"banner",@"dianmian"];
        return cell;
        
    }else if(indexPath.row == 1){
        
        KLMallClassifyCell * cell =kCellIdentifier(KLMallClassifyCell);
        klWeakSelf;
        cell.classifyBlock = ^(UIButton * _Nonnull sender) {
            [weakSelf didClassifyBtnChick:sender];
        };
        [cell setMallArray:self.btnTitleArray];
        return cell;
        
    }else if(indexPath.row == 2){
        
        KLMallActivityCell * cell =kCellIdentifier(KLMallActivityCell);
        cell.recommendBtn.titleLab.text  = @"宠友推荐";
        cell.favourableBtn.titleLab.text = @"特享优惠";
        cell.makeBtn.titleLab.text       = @"有宠定制";
        cell.recommendBtn.decLab.text    = @"精品好货";
        cell.favourableBtn.decLab.text   = @"满100减10元";
        cell.makeBtn.decLab.text         = @"每天快乐相伴";
        cell.recommendBtn.goodsImg.image =[UIImage imageNamed:@"pic_1-1"];
        cell.favourableBtn.goodsImg.image =[UIImage imageNamed:@"pic_3"];
        cell.makeBtn.goodsImg.image =[UIImage imageNamed:@"pic_3-1"];
        @weakify(self)
        cell.activeBlock = ^(KLMallActivityBtn * _Nonnull sender) {
            @strongify(self)
            [self didActiveChick:sender];
        };

        return cell;
    }else if(indexPath.row == 3){//每日抢购 cell
        
        NSString *title      = @"每日疯抢";
        NSString *text       = @"距本场结束还剩";
        NSArray  *goodsArray = @[@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2"];
        KLSeckillingAreaCell * cell = [KLSeckillingAreaCell initWith:tableView title:title text:text goodsArray:goodsArray hidden:NO];
        cell.indexPath = indexPath;
        @weakify(self)
        cell.cellMoreBlock = ^(UIButton * _Nonnull button, NSIndexPath * _Nonnull indexPath) {
           @strongify(self)
            [self didPushGoodsListController:@"每日疯抢"];
        };
        cell.goodsBlock = ^(UIButton * _Nonnull button, NSIndexPath * _Nonnull indexPath) {
            @strongify(self)
            [self didPushGoodsDetailController:button.tag cellIndex:indexPath.row];
        };
        
        return cell;
        
    }else if(indexPath.row == 4){ //新品热卖 cell
        
        NSString *title      = @"新品热卖";
        NSString *text       = @"每周好货新品推荐";
        NSArray  *goodsArray = @[@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2"];
        KLSeckillingAreaCell * cell = [KLSeckillingAreaCell initWith:tableView title:title text:text goodsArray:goodsArray hidden:YES];
        cell.indexPath = indexPath;
        @weakify(self)
        cell.cellMoreBlock = ^(UIButton * _Nonnull button, NSIndexPath * _Nonnull indexPath) {
           @strongify(self)
             [self didPushGoodsListController:@"新品热卖"];
        };
        cell.goodsBlock = ^(UIButton * _Nonnull button, NSIndexPath * _Nonnull indexPath) {
            @strongify(self)
            [self didPushGoodsDetailController:button.tag cellIndex:indexPath.row];
        };
        
        return cell;
        
    }else if(indexPath.row == 5){ //新品热卖 cell
        
        KLMallAdvertisingCell *cell =kCellIdentifier(KLMallAdvertisingCell);
        cell.AdImg.image =[UIImage imageNamed:@"Ad_2"];
        return cell;
        
    } else {
        
        KLMallCollectionTableCell *cell = kCellIdentifier(KLMallCollectionTableCell);
        cell.delegate = self;
        cell.indexPath = indexPath;
        cell.dataAry = self.dataAry[indexPath.row-6];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return AdaptedHeight(129);
    }else if(indexPath.row == 1){
        return AdaptedHeight(158);
    }else if(indexPath.row == 2){
        return AdaptedHeight(241);
    }else if (indexPath.row == 3){ //每日抢购 cell
        return AdaptedHeight(220);
    }else if (indexPath.row == 4){ //新品热卖 cell
        return AdaptedHeight(220);
    }else if (indexPath.row == 5){ //新品热卖 cell
        return AdaptedHeight(46);
    }else{
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


#pragma mark ====== RootTableCellDelegate ======
- (void)updateTableViewCellHeight:(KLMallCollectionTableCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath {
    if (![self.dicH[indexPath] isEqualToNumber:@(height)]) {
        self.dicH[indexPath] = @(height);
        [self.tableView reloadData];
    }
}

//点击UICollectionViewCell的代理方法
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content {
   
    [self didPushGoodsDetailController:0 cellIndex:indexPath.row];
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alertView show];
}

- (void)didAddCarSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 
    KLLog(@"indexPath.item == %ld",indexPath.item);
}



#pragma mark ------ 数据源

- (NSArray *)btnTitleArray {
    
    if (!_btnTitleArray){
        _btnTitleArray = @[@"主粮",@"零食",@"日用",@"洗护",@"医疗",@"服饰",@"玩具",@"分类"];
    }
    return _btnTitleArray;
}



- (NSMutableDictionary *)dicH {
    if (!_dicH) {
        _dicH = [[NSMutableDictionary alloc] init];
    }
    return _dicH;
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
