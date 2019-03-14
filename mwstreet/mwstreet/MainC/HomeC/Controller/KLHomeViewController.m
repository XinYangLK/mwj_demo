//
//  KLHomeViewController.m
//  mengWuStreet
//
//  Created by 科pro on 2018/12/15.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLHomeViewController.h"
#import "KLHomeTableView.h"         //首页列表
#import "KLAppDelegate.h"           //获取 AppDelegate
#import "KLCarouselBannerCell.h"    //轮播图banner cell
#import "KLClassifyTableViewCell.h" //分类items  Cell
#import "KLAdvertisingBannerCell.h" //广告轮播，滚动头条 cell
#import "KLActivityAreaCell.h"      //活动特价专区 cell
#import "KLSeckillingAreaCell.h"    //滚动秒杀商品 cell
#import "KLSpellDealsAreaCell.h"    //拼团活动专区 cell
#import "KLStoreListCell.h"         //r推荐商店列表 cell
#import "KLCountDownManager.h"      //倒计时单例类
#import "KLCountdownModel.h"        //倒计时 model
#import "KLCityListLocController.h" //选择定位城市列表
#import "KLStoreDetailViewController.h" //门店详情页
#import "KLMJRefreshDelegate.h"     //自定义刷新header，加载footer -- delegate
#import "UIScrollView+KLRefresh.h"  //自定义刷新header
#import "KLMyPetViewController.h"   //我的爱宠 (编辑)
#import "KLMyPetListController.h"   //我的爱宠 (列表)
#import "KLPackageMailListController.h" //9.9包邮
#import "KLTodaySpecialManager.h"       //今日特价
#import "KLBargainManagerController.h"  //砍价
#import "KLSpellGroupListController.h"  //拼团购商品列表
#import "KLGoodsDetailController.h"     //商品详情
#import "KLFlashManagerController.h"    //限时抢购
#import "UIViewController+KLGCDCountdown.h" //倒计时
#import "KLClassifyStoreListController.h"   //门店列表

@interface KLHomeViewController ()<
UINavigationControllerDelegate,
UIGestureRecognizerDelegate,
UISearchBarDelegate,
UITableViewDataSource,
UITableViewDelegate,
UIScrollViewDelegate,
SDCycleScrollViewDelegate,
SGAdvertScrollViewDelegate,
KLHomeProtocol,
KLCarouselBannerCellDelegate,
KLActivityAreaCellDelegate
>
@property (nonatomic, strong) KLHomeTableView        * homeTableView;  //表View
@property (nonatomic, strong) NSMutableArray         * dataArray;      //数据源
@property (nonatomic, strong) NSArray                * btnTitleArray;  //分类item
@property (nonatomic, strong) NSArray                * dataSource;
@property (nonatomic, strong) id                       timer;

@end

@implementation KLHomeViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    //加载倒计时数据
    [self loadData];
    //创建界面
    [self creatUI];
}

- (void)loadData {
    //***  添加通知  **/
    [self addObserverPostNotificationMethods];
    //***  添加倒计时  **/
    NSInteger timerSecond = 12000;
   
    NSString * timer = [NSString stringWithFormat:@"%ld",timerSecond];
    NSString * key = [NSString stringWithFormat:@"a%ld",timerSecond];
    
    [self getCountdownTimer:timer key:key];
    
}

//***  添加前后台监听通知  **/
- (void)addObserverPostNotificationMethods {
    //程序进入前台通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidBecomeActiveNotification)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    //程序进入选择状态通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActiveNotification)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
}
//***  释放通知  **/
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


//***  倒计时  **/
- (void)getCountdownTimer:(NSString *)timer key:(NSString *)key {
    klWeakSelf;
    [UIViewController getTimeWithStr:timer and:key timerBlock:^(id  _Nonnull timer) {
        
        weakSelf.timer = timer;
        
    } countdownOverBlock:^(NSString * _Nonnull dicKey) {
        
        [weakSelf.homeTableView.tableView reloadData];
        
    } countdownOngoingBlock:^(NSString * _Nonnull timeOut, NSString * _Nonnull dicKey) {
        
        NSInteger seconds = [timeOut integerValue];
        //format of hour
        NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
        //format of minute
        NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
        //format of second
        NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0]; //刷新第0段第0行
        KLActivityAreaCell *cell = [weakSelf.homeTableView.tableView cellForRowAtIndexPath:indexPath];
        cell.countdownView.hourLabel.text   = str_hour;
        cell.countdownView.minuteLabel.text = str_minute;
        cell.countdownView.secondLabel.text = str_second;
    }];
    
}
//***  进入后台状态--保存当前计时器值  **/
- (void)applicationWillResignActiveNotification{
    dispatch_cancel(self.timer);
//    klWeakSelf;
//    [self.keyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        KLLog(@"444====%@",[weakSelf.dataDic objectForKey:weakSelf.keyArray[idx]]);
//    }];
}
//***  进入前台状态--计算当前计时器值 重新赋值计时器  **/
- (void)appDidBecomeActiveNotification {
    
//    [self getCountdownTimer:@"12" key:@"a"];
    
}




#pragma mark ------ 自定义 delegate >>> KLHomeProtocol
//***  分类items 点击回调  **/
- (void)didClickBtn:(UIButton *)button indexPath:(NSIndexPath *)indexPath {
   
    KLClassifyStoreListController *vc =[[KLClassifyStoreListController alloc]init];
    vc.navTitle = button.titleLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
    
    KLLog(@"=======%ld====%ld==",button.tag,indexPath.row);

}
//***  活动模块点击事件 tag 53 - 56  **/
- (void)didActivityBtnChick:(UIButton *)sender {
    switch (sender.tag) {
        case 53:{//限时抢购
            KLFlashManagerController *vc =[[KLFlashManagerController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 54:{//今日特价
            KLTodaySpecialManager *vc =[[KLTodaySpecialManager alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 55:{//砍价
            KLBargainManagerController *vc =[[KLBargainManagerController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 56:{//9.9包邮
            KLPackageMailListController *vc =[[KLPackageMailListController alloc]init];
            vc.navTitle =@"9.9包邮";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}
//***  新品推荐更多 / 拼团更多 点击事件 **/
- (void)didMoreNewButtonChick:(UIButton *)sender index:(NSInteger)indexRow {
    
    if (indexRow == 4) {//新品推荐更多
        
        KLPackageMailListController *vc =[[KLPackageMailListController alloc]init];
        vc.navTitle =@"新品推荐";
        [self.navigationController pushViewController:vc animated:YES];

    }else{ //拼团更多
        
        KLSpellGroupListController *vc =[[KLSpellGroupListController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

//***   新品推荐 / 拼团 滚动商品点击事件   **/
- (void)didScrollviewGoodsChick:(UIButton *)sender  index:(NSInteger)indexRow {
    
    if (indexRow == 4) {//新品推荐滚动商品
        
        KLGoodsDetailController *vc =[[KLGoodsDetailController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{ //拼团滚动商品
        
        KLGoodsDetailController *vc =[[KLGoodsDetailController alloc]init];
        vc.detailType = 3;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



#pragma mark ------ 定位 城市选择
- (void)loctionCityBtn:(UIButton *)sender {
    
    KLCityListLocController *vc =[[KLCityListLocController alloc]init];
    vc.selectLocBlock = ^(NSString * _Nonnull city) {
        [sender setTitle:city forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark ------ 我的宠物
- (void)tapBtnChick {
    
    KLMyPetListController *vc =[[KLMyPetListController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
//    KLMyPetViewController *vc =[[KLMyPetViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark ------ lazy UI
//***  创建UI  **/
- (void)creatUI{

    [self.view addSubview:self.homeTableView];
    [self refreshTableViewData];
    [self.homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

//***  列表View  **/
- (KLHomeTableView *)homeTableView {
    if (!_homeTableView){
        _homeTableView = [KLHomeTableView shareTable];
        _homeTableView.tableView.delegate =self;
        _homeTableView.tableView.dataSource =self;
        _homeTableView.navigationView.delegate = self;
        _homeTableView.navigationView.searchView.delegate = self;
        _homeTableView.navigationView.shadowLine.hidden = YES;
        _homeTableView.tableView.mCustomClass([UITableViewCell class]);
        _homeTableView.tableView.mCustomClass([KLCarouselBannerCell class]);
        _homeTableView.tableView.mCustomClass([KLClassifyTableViewCell class]);
        _homeTableView.tableView.mCustomClass([KLAdvertisingBannerCell class]);
        _homeTableView.tableView.mCustomClass([KLActivityAreaCell class]);
        _homeTableView.tableView.mCustomClass([KLStoreListCell class]);
    }
    return _homeTableView;
}

//***  刷新-加载  **/
-(void)refreshTableViewData{
    
    klWeakSelf;
    self.homeTableView.tableView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        //网络刷新请求
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.homeTableView.tableView endHeaderRefresh];
        });
    }];
    self.homeTableView.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        //网络请求
        [weakSelf.homeTableView.tableView endFooterRefresh];
    }];
}


#pragma mark ------ 表单tableView ----->>  UITableViewDataSource, UITableViewDelegate  **/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    klWeakSelf;

    
    if (indexPath.row == 0) { //轮播图banner cell

        KLCarouselBannerCell * cell = kCellIdentifier(KLCarouselBannerCell);
        cell.delegate =self;
        cell.imageArr =@[@"banner_2",@"banner",@"dianmian"];
        return cell;

    }else if(indexPath.row == 1){ //分类items  Cell

        KLClassifyTableViewCell * cell = kCellIdentifier(KLClassifyTableViewCell);
        cell.delegate  = self;
        cell.indexPath = indexPath;
        [cell setBtnArray:self.btnTitleArray];
        return cell;

    }else if(indexPath.row == 2){ //广告轮播，滚动头条 cell

        KLAdvertisingBannerCell * cell = kCellIdentifier(KLAdvertisingBannerCell);
        cell.adCarouselView.imageURLStringsGroup = @[@"pic_AD",@"pic_AD"];
        cell.adCarouselView.delegate = self;
        cell.adScrollView.titles = @[@"反被分为充分维尔覅而非",@" 二哥热熔封丰富分分诶饿",@"日本人肉分杰尔夫IE热热饭耳热二分法IE费诶饿飞蛾额而发儿非人非诶"];
        cell.adScrollView.delegate = self;
        return cell;

    }else if(indexPath.row == 3){ //活动特价专区 cell

        KLActivityAreaCell * cell = kCellIdentifier(KLActivityAreaCell);
        cell.delegate = self;

        return cell;

    }else if(indexPath.row == 4){ //滚动新品推荐商品 cell
        NSString *title      = @"新品推荐";
        NSString *text       = @"更多好的商品都在这里";
        NSArray  *goodsArray = @[@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2"];
        
        KLSeckillingAreaCell * cell = [KLSeckillingAreaCell initWith:tableView title:title text:text goodsArray:goodsArray hidden:YES];
        cell.indexPath = indexPath;
        
        cell.cellMoreBlock = ^(UIButton * _Nonnull button, NSIndexPath * _Nonnull indexPath) {
            [weakSelf didMoreNewButtonChick:button index:indexPath.row];
        };
        cell.goodsBlock = ^(UIButton * _Nonnull button, NSIndexPath * _Nonnull indexPath) {
            [weakSelf didScrollviewGoodsChick:button index:indexPath.row];
        };
        
        return cell;

    }else if(indexPath.row == 5){ //拼团活动专区 cell
        
        NSString *title      = @"拼团购";
        NSString *text       = @"低价拼 好货";
        NSArray  *goodsArray = @[@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2"];
        KLSpellDealsAreaCell * cell = [KLSpellDealsAreaCell initWith:tableView title:title text:text goodsArray:goodsArray hidden:YES];
        cell.indexPath = indexPath;
        
        cell.cellMoreBlock = ^(UIButton * _Nonnull button, NSIndexPath * _Nonnull indexPath) {
            [weakSelf didMoreNewButtonChick:button index:indexPath.row];
        };
        cell.goodsBlock = ^(UIButton * _Nonnull button, NSIndexPath * _Nonnull indexPath) {
            [weakSelf didScrollviewGoodsChick:button index:indexPath.row];
        };
        return cell;
        
    }else if(indexPath.row == 6){ //拼团活动专区 cell
        
        UITableViewCell * cell = kCellIdentifier(UITableViewCell);
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"推荐商家";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = AdaptedSYSFontSize(20);
        cell.textLabel.textColor = RGBSigle(27);
        return cell;
        
    }else  {
        
        KLStoreListCell * cell =kCellIdentifier(KLStoreListCell);
        cell.goodsImg.image   = [UIImage imageNamed:@"dianmian"];
        cell.titleLab.text    = @"狗粮王菲菲慰问和复位范文芳微服务额废物和";
        cell.distanceLab.text = @"999千米";
        cell.addressLab.text  = @"上海市静安区的定位ID我才问问是weUI是底层DVD";
        
        return cell;
    }
}



//***  cell 点击事件  **/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row > 6){
        
        KLStoreDetailViewController *vc =[[KLStoreDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}
//***  cell 高度  **/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (indexPath.row == 0) {    //banner cell
        
        return AdaptedHeight(184);
        
    }else if(indexPath.row == 1){ //分类 cell
        
        int index = ceil((float)self.btnTitleArray.count/4);
        
        CGFloat height = (MainWidth-50)/4 + AdaptedHeight(10);
        
        return index !=0 ? index * height : 0;
        
    }else if (indexPath.row == 2){ //广告
        
        return AdaptedHeight(120);
        
    }else if (indexPath.row == 3){ //活动 cell
       
        return AdaptedHeight(230);
        
    }else if (indexPath.row == 4){ //秒杀 cell
       
        return AdaptedHeight(220);
        
    }else if (indexPath.row == 5){ //拼团 cell
        
        return AdaptedHeight(220);
        
    }else if (indexPath.row == 6){ // 商城头 cell
        
        return AdaptedHeight(44);
        
    }else{                        // 店铺 cell
        
        return AdaptedHeight(135);
        
    }
    
}


#pragma mark ------  轮播图 banner delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    switch (cycleScrollView.tag) {
        case 20:{
            KLLog(@"+++++++++++===%ld===",index);

        }
            break;
        case 21:{
            KLLog(@"==============%ld===",index);
        }
            break;
            
        default:
            break;
    }
}


#pragma mark ------  纵向公告头条 -点击广告消息回调
- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index {
    
    KLLog(@"==============%ld===",index);

}



#pragma mark ------ 滑动表 scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
    CGFloat top = scrollView.contentInset.top;
    
    CGFloat y =  scrollView.contentOffset.y;
    
    CGFloat offsetY = top + y;
    
    CGFloat progressChange = offsetY /190.00;
    
    if (progressChange <= 0) {
        self.homeTableView.navigationView.shadowLine.hidden = YES;
    }else{
        self.homeTableView.navigationView.shadowLine.hidden = NO;
    }
}


#pragma mark ------ 搜索框searchBar  delegate 响应
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    NSLog(@"111111");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"2222");
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    
    NSLog(@"textDidChange %@",searchText);
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    searchBar.showsCancelButton = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    
}




#pragma mark ------ 数据源

- (NSArray *)btnTitleArray {
    
    if (!_btnTitleArray){
        
        _btnTitleArray = @[@"食品",@"美容",@"居家",@"医疗保健",@"寄养",@"活体",@"医院",@"培训学校"];
    }
    return _btnTitleArray;
}
//***  数据字典初始化  **/
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray =[NSMutableArray arrayWithObjects:@"1",@"32",@"32",@"32",@"32",@"32",@"32",@"32",@"32",@"32",@"32",@"32",@"32",@"32",@"32",@"32",@"35", nil];
    }
    return _dataArray;
}


- (NSArray *)dataSource {
    if (_dataSource == nil) {
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSInteger i=0; i<50; i++) {
            // 模拟从服务器取得数据 -- 例如:服务器返回的数据为剩余时间数
            NSInteger count = arc4random_uniform(10000+1); //生成0-1万之间的随机正整数
            KLCountdownModel *model = [[KLCountdownModel alloc]init];
            model.applyRemainTime = [NSString stringWithFormat: @"%zd", count];
            [arrM addObject:model];
        }
        _dataSource = arrM.copy;
    }
    return _dataSource;
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
