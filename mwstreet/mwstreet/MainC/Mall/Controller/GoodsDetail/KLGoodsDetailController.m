//
//  KLGoodsDetailController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/4.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLGoodsDetailController.h"
#import <WebKit/WebKit.h>
#import "KLDetailNavigationView.h"          //导航view
#import "KLMallBannerCell.h"                //轮播banner
#import "KLGoodsDetailTitleCell.h"          //商品名称价格cell
#import "XWDrawerAnimator.h"                //导航push动画
#import "UIViewController+XWTransition.h"
#import "KLGoodsSpecPopupController.h"      //商品规格筛选
#import "KLGoodsDetailCouponsCell.h"        //商品券
#import "KLGoodsDetailSecurityCell.h"       //商品保障
#import "KLGoodsDetailAddressOrSpecCell.h"  //地址及规格选择
#import "KLGoodsDetailEvaHeaderCell.h"      //评价头cell
#import "KLEvaluationListViewCell.h"        //评价列表cell
#import "KLGoodsDetailStoreCell.h"          //店铺描述详情
#import "KLEvaluationListModel.h"           // 评价列表 model
#import "KLGoodsDetailBottomView.h"         //底部按钮View
#import "KLEvaluationListController.h"      //评价列表
#import "UITableView+FDTemplateLayoutCell.h" //cell 自动行高适配三方扩展

#import "KLGoodsCouponPopupController.h" //优惠券

#import "KLGoodsDetailCountdownCell.h"   //倒计时cell
#import "UIViewController+KLGCDCountdown.h" //倒计时扩展
#import "KLSpellGroupGoodsDetailCell.h" //拼团列表 cell

#import "KLStoreDetailViewController.h" //门店详情

@interface KLGoodsDetailController ()<
UINavigationControllerDelegate,
UIGestureRecognizerDelegate,
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate,
KLGoodsDetailProtocol,
SDCycleScrollViewDelegate,
WKNavigationDelegate,
KLGoodsDetailBottomViewDelegate
>

//***  伪导航view  **/
@property (nonatomic, strong) KLDetailNavigationView * navigationView;
//***  tableView  **/
@property (nonatomic, strong) UITableView * tableView;
//***  商品详情web  **/
@property (nonatomic, strong) WKWebView *webView;
//***  底部view  **/
@property (nonatomic, strong) KLGoodsDetailBottomView *bottemView;
//***  数据源  **/
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) NSMutableArray * goodsBannerImgArray;
//***  记录滚动方向  **/
@property (nonatomic, assign) BOOL  isUpScroll;



@property (nonatomic, strong) id timer;

//***  倒计时数据源  **/
@property (nonatomic, strong) NSMutableDictionary * dataDic;

//***  时间数据源  **/
@property (nonatomic, strong) NSArray             * timerArray;
//***  key标示数据源  **/
@property (nonatomic, strong) NSArray             * keyArray;

@end

@implementation KLGoodsDetailController

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

#pragma mark - 自定义 delegate 方法
//***  导航d返回按钮响应  **/
- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * 商品详情导航view 商品，评价，详情 按钮响应
 * sender.tag ==>> 1~3;
 */
- (void)navigationViewBtnChick:(UIButton *)sender {
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:sender.tag - 1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}


//***  底部按钮响应 tag == 200 - 203 **/
- (void)didActionBtnChick:(UIButton *)sender{
    switch (sender.tag) {
        case 200:{//客服
            KLLog(@"客服");
        }
            break;
        case 201:{//收藏
            KLLog(@"收藏");
        }
            break;
        case 202:{//加入购物车
            
            
            KLGoodsSpecPopupController *vc =[[KLGoodsSpecPopupController alloc]init];
            [self pushSpecVC:vc];
            
        }
            break;
        case 203:{//立即购买
            
            KLGoodsSpecPopupController *vc =[[KLGoodsSpecPopupController alloc]init];
            [self pushSpecVC:vc];
            
        }
            break;
        default:
            break;
    }
}







#pragma mark - 创建 UI
//***  初始化  **/
- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor =BackgroundColor;
    [self configUI];
    [self loadingData];
    [self refreshTableViewData];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cocoachina.com"]]];
    
    if (self.detailType == 2) {//限时抢购
        [self loadData];
    }else if(self.detailType == 3){ //拼团购倒计时
        [self groupCoundownData];
    }
}


#pragma mark - 加载评价数据
- (void)loadingData {
    
    NSArray *imageArray = @[@"https://img.chuizhicai.com/product/20170525/dfa33deb-a228-4a96-bc14-879079497995.jpg?x-oss-process=image/resize,m_mfit,h_400,w_400",@"https://img.chuizhicai.com/product/20170421/e91186ef-2e9a-4118-8fb9-ddc887a6c6fc.jpg?x-oss-process=image/resize,m_mfit,h_400,w_400",@"https://img.chuizhicai.com/ad/20170927/d16b8eb5-f0a2-419d-bde7-8afedc14fa73.jpg",@"https://img.chuizhicai.com/product/20170616/6f989f6e-15bc-4a5f-9c0d-548f265e24bc.jpg?x-oss-process=image/resize,m_mfit,h_400,w_400",@"https://img.chuizhicai.com/product/20170704/93a18f6c-bef0-45e7-a22d-7fbe4605e07a.jpg?x-oss-process=image/resize,m_mfit,h_400,w_400"];
    
    for (int i = 0; i < 2; i++) {
        
        KLEvaluationListModel *modal = [[KLEvaluationListModel alloc]init];
        modal.iconImage = @"http://q.qlogo.cn/qqapp/1106276139/D1A908A09FE81C02D31FD0EA242397F5/100";
        modal.iconName  = @"朋友圈啊";
        modal.timer     = @"2018-12-15 ";
        modal.scoreNum  = @"8.3";
        
        int number =1 + arc4random_uniform(2);
        NSMutableArray *imagesArray = [NSMutableArray array];
        NSString *string = [NSString string];
        for (int i = 0; i < number; i++) {
            int pictureCount = (int)imageArray.count;
            int picture = arc4random_uniform(pictureCount);
            NSString * string2  = @"斗鱼,主要是指归属于鲈形目、攀鲈亚目、丝足鲈科、斗鱼亚科的小型鱼类,与其他鱼类相似,主要以鳃呼吸";
            string = [string stringByAppendingString:string2];
            [imagesArray addObject:imageArray[picture]];
        }
        modal.content = string;
        modal.images = imagesArray;
        
        [self.dataSource addObject:modal];
    }
    
    [self.tableView reloadData];
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
        
        [weakSelf.tableView reloadData];
        
    } countdownOngoingBlock:^(NSString * _Nonnull timeOut, NSString * _Nonnull dicKey) {
        
        NSInteger seconds = [timeOut integerValue];
        //format of hour
        NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
        //format of minute
        NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
        //format of second
        NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
        NSIndexPath * indexPath =[NSIndexPath indexPathForRow:1 inSection:0];
        KLGoodsDetailCountdownCell * cell =(KLGoodsDetailCountdownCell *)[weakSelf.tableView cellForRowAtIndexPath:indexPath];
        cell.countdownView.hourLabel.text   = str_hour;
        cell.countdownView.minuteLabel.text = str_minute;
        cell.countdownView.secondLabel.text = str_second;
    }];
    
}
//***  进入后台状态--保存当前计时器值  **/
- (void)applicationWillResignActiveNotification{
    dispatch_cancel(self.timer);
    klWeakSelf;
    [self.keyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        KLLog(@"444====%@",[weakSelf.dataDic objectForKey:weakSelf.keyArray[idx]]);
    }];
}
//***  进入前台状态--计算当前计时器值 重新赋值计时器  **/
- (void)appDidBecomeActiveNotification {
    
    [self getCountdownTimer:@"12" key:@"a"];
    
}






#pragma mark - 拼团购倒计时
- (void)groupCoundownData {
    
    //    测试倒计时同步准确性
    _timerArray = @[@"3",@"820",@"360",
                   @"12000",@"40000",@"120",
                   @"120",@"1020",@"60",@"120"];
    
    _keyArray = @[@"a",@"b",@"c",
                   @"d",@"e",@"f",
                   @"g",@"h",@"i",@"j"];
    _dataDic = @{}.mutableCopy;
    
    [self getTimeStrWith:_timerArray and:_keyArray];
    
}

- (void)getTimeStrWith:(NSArray *)timerArray and:(NSArray *)keyArray {
    
    klWeakSelf;
    [UIViewController getTimeWithArr:timerArray and:keyArray timerBlock:^(id  _Nonnull timer) {
        
        weakSelf.timer = timer;
        
    } countdownOverBlock:^(NSString * _Nonnull dicKey) {
        
        [weakSelf.dataDic setObject:@"拼单已结束"  forKey:dicKey];
        [weakSelf.tableView reloadData];
        
    } countdownOngoingBlock:^(NSString * _Nonnull timeOut, NSString * _Nonnull dicKey) {
        
        NSString *strTime = [NSString stringWithFormat:@"剩余：%@",[NSString getMMSSFromSS:timeOut]];
        [weakSelf.dataDic setObject:strTime forKey:dicKey];

        
        NSMutableArray * dicTimeArray = [NSMutableArray array];
        [weakSelf.dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [dicTimeArray addObject:[NSString stringWithFormat:@"%@-%@",key,obj]];
        }];
        //对数组进行排序
        NSArray *result = [dicTimeArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2]; //升序
        }];
        //***  排序后获取对应时间  **/
        NSMutableArray * timeArray = [NSMutableArray array];
        [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray * timeArr = [obj componentsSeparatedByString:@"-"];
            [timeArray addObject:[timeArr lastObject]];
        }];
    
        NSIndexPath * indexPath =[NSIndexPath indexPathForRow:2 inSection:0];
        KLSpellGroupGoodsDetailCell * cell =(KLSpellGroupGoodsDetailCell *)[weakSelf.tableView cellForRowAtIndexPath:indexPath];
        cell.dataAry   = timeArray;
       
    }];
    
}






//***  配置UI 布局  **/
- (void)configUI {
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.bottemView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset =0;
        make.top.offset = StatusBarAndNavigationBarHeight+1;
        make.bottom.offset = - TabbarHeight;
    }];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset = 0;
        make.height.offset = StatusBarAndNavigationBarHeight;
    }];
    
    [self.bottemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset = 0;
        make.height.offset = TabbarHeight;
    }];
}

//***  加载web  **/
- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectZero];
        _webView.navigationDelegate = self;
        _webView.scrollView.scrollEnabled = YES;
    }
    return _webView;
}

//***  导航 lazy-view  **/
- (KLDetailNavigationView *)navigationView {
    if (!_navigationView){
        _navigationView = [[KLDetailNavigationView alloc]init];
        _navigationView.backgroundColor =[UIColor whiteColor];
        _navigationView.delegate =self;
    }
    return _navigationView;
}
//***  底部view  **/
- (KLGoodsDetailBottomView *)bottemView {
    if (!_bottemView){
        _bottemView = [[KLGoodsDetailBottomView alloc]init];
        _bottemView.delegate = self;
        if (self.detailType == 3) {
            [_bottemView.addShopCarBtn setTitle:@"拼单购\n(￥88)" forState:UIControlStateNormal];
            _bottemView.addShopCarBtn.titleLabel.numberOfLines = 0;
            [_bottemView.placeOrderBtn setTitle:@"单人购\n(￥188)" forState:UIControlStateNormal];
            _bottemView.placeOrderBtn.titleLabel.numberOfLines = 0;
        }
        
    }
    return _bottemView;
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
}

//***  tableView lazy--UI  **/
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.mCustomClass([UITableViewCell class]);
        _tableView.mCustomClass([KLMallBannerCell class]);
        _tableView.mCustomClass([KLGoodsDetailTitleCell class]);
        _tableView.mCustomClass([KLGoodsDetailCouponsCell class]);
        _tableView.mCustomClass([KLGoodsDetailSecurityCell class]);
        _tableView.mCustomClass([KLGoodsDetailAddressOrSpecCell class]);
        _tableView.mCustomClass([KLGoodsDetailEvaHeaderCell class]);
        _tableView.mCustomClass([KLEvaluationListViewCell class]);
        _tableView.mCustomClass([KLGoodsDetailStoreCell class]);
        
        if (self.detailType == 2) {//限时抢购
            _tableView.mCustomClass([KLGoodsDetailCountdownCell class]);
        }else if (self.detailType == 3){// 拼团商品详情
            _tableView.mCustomClass([KLSpellGroupGoodsDetailCell class]);
        }
    }
    return _tableView;
}
#pragma mark - 常规商品详情
- (UITableViewCell *)goodsDetail:(UITableView *)tableView CellIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row == 0) {
        
        KLMallBannerCell * cell = kCellIdentifier(KLMallBannerCell);
        cell.carouselView.imageURLStringsGroup = self.goodsBannerImgArray;
        cell.carouselView.delegate =self;
        return cell;
        
    }else if(indexPath.row == 1){
        
        KLGoodsDetailTitleCell * cell =kCellIdentifier(KLGoodsDetailTitleCell);
        cell.goodsTitle.text = @"快宠泰迪幼犬狗粮贵宾吉娃娃中小型犬5kg美毛去泪腺通用型10斤";
        cell.goodsPrice.text = @"￥658.9";
        cell.oldPrice.text   = @"￥958.99";
        cell.decLab.text     = @"19883人已购";
        return cell;
        
    }else if(indexPath.row == 2){
        
        KLGoodsDetailCouponsCell * cell =kCellIdentifier(KLGoodsDetailCouponsCell);
        cell.couponImgArray =@[@"满199减20",@"满399减80"];
        return cell;
        
        
    }else if(indexPath.row == 3 || indexPath.row == 4){
        
        KLGoodsDetailAddressOrSpecCell * cell =kCellIdentifier(KLGoodsDetailAddressOrSpecCell);
        cell.titleLab.text = @[@"送至:",@"已选:"][indexPath.row - 3];
        cell.textLab.text = @[@"上海  上海市 静安区",@"已选重量5Kg"][indexPath.row - 3];
        return cell;
        
    }else{
        
        KLGoodsDetailSecurityCell * cell =kCellIdentifier(KLGoodsDetailSecurityCell);
        cell.securityBtnArray =@[@"正品保障",@"9.9元包邮",@"7天无忧退换"];
        return cell;
    }
}


#pragma mark - 拼团商品详情
- (UITableViewCell *)spellGroupGoodsDetail:(UITableView *)tableView CellIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        KLMallBannerCell * cell = kCellIdentifier(KLMallBannerCell);
        cell.carouselView.imageURLStringsGroup = self.goodsBannerImgArray;
        cell.carouselView.delegate =self;
        return cell;
        
    }else if (indexPath.row == 1){
        
        KLGoodsDetailTitleCell * cell =kCellIdentifier(KLGoodsDetailTitleCell);
        cell.goodsTitle.text = @"快宠泰迪幼犬狗粮贵宾吉娃娃中小型犬5kg美毛去泪腺通用型10斤";
        cell.goodsPrice.text = @"￥658.9";
        cell.oldPrice.text   = @"￥958.99";
        cell.decLab.text     = @"19883人已购";
        return cell;
        
    }else if (indexPath.row == 2){
        
        KLSpellGroupGoodsDetailCell * cell = kCellIdentifier(KLSpellGroupGoodsDetailCell);
        cell.titleLab.text =@"20人正在开团";
        cell.joinGroundBlock = ^(UIButton * _Nonnull sender, NSIndexPath * _Nonnull indexPath) {
            
            KLLog(@"-------%ld",indexPath.row);
            
        };
        return cell;
        
    }else if (indexPath.row == 3 || indexPath.row == 4){
        
        KLGoodsDetailAddressOrSpecCell * cell =kCellIdentifier(KLGoodsDetailAddressOrSpecCell);
        cell.titleLab.text = @[@"送至:",@"已选:"][indexPath.row - 3];
        cell.textLab.text  = @[@"上海  上海市 静安区",@"已选重量5Kg"][indexPath.row - 3];
        return cell;
        
    }else{
        
        KLGoodsDetailSecurityCell * cell =kCellIdentifier(KLGoodsDetailSecurityCell);
        cell.securityBtnArray =@[@"正品保障",@"9.9元包邮",@"7天无忧退换"];
        return cell;
        
    }
}


#pragma mark - 限时抢购商品详情
- (UITableViewCell *)countdownGoodsDetail:(UITableView *)tableView CellIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        KLMallBannerCell * cell = kCellIdentifier(KLMallBannerCell);
        cell.carouselView.imageURLStringsGroup = self.goodsBannerImgArray;
        cell.carouselView.delegate =self;
        return cell;
        
    }else if (indexPath.row == 1){
        
        KLGoodsDetailCountdownCell *cell =kCellIdentifier(KLGoodsDetailCountdownCell);
        
        return cell;
        
    }else if (indexPath.row == 2){
        
        KLGoodsDetailTitleCell * cell =kCellIdentifier(KLGoodsDetailTitleCell);
        cell.goodsTitle.text = @"快宠泰迪幼犬狗粮贵宾吉娃娃中小型犬5kg美毛去泪腺通用型10斤";
        cell.goodsPrice.text = @"￥658.9";
        cell.oldPrice.text   = @"￥958.99";
        cell.decLab.text     = @"19883人已购";
        return cell;
        
    }else if (indexPath.row == 3){
        
        KLGoodsDetailCouponsCell * cell =kCellIdentifier(KLGoodsDetailCouponsCell);
        cell.couponImgArray =@[@"满199减20",@"满399减80"];
        return cell;
        
    }else if (indexPath.row == 4 || indexPath.row == 5){
        
        KLGoodsDetailAddressOrSpecCell * cell =kCellIdentifier(KLGoodsDetailAddressOrSpecCell);
        cell.titleLab.text = @[@"送至:",@"已选:"][indexPath.row - 4];
        cell.textLab.text = @[@"上海  上海市 静安区",@"已选重量5Kg"][indexPath.row - 4];
        return cell;
        
    }else{
        
        KLGoodsDetailSecurityCell * cell =kCellIdentifier(KLGoodsDetailSecurityCell);
        cell.securityBtnArray =@[@"正品保障",@"9.9元包邮",@"7天无忧退换"];
        return cell;
        
    }
}



#pragma mark - tableView -->>>  delegate ,datasoure
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if (section == 0) {
        if (self.detailType == 2) { //限时抢购
            return 7;
        }
        return 6;
        
    }else if (section ==1){
        
        return self.dataSource.count + 2;
        
    }else {
        
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && self.detailType == 0){
        
        //***  常规商品详情  **/
       return [self goodsDetail:tableView CellIndexPath:indexPath];
        
    }else if (indexPath.section == 0 && self.detailType == 2) {
        
        //***  限时抢购商品详情  **/
       return [self countdownGoodsDetail:tableView CellIndexPath:indexPath];
    
    }else if (indexPath.section == 0 && self.detailType == 3) {
        
        //***  拼团商品详情  **/
       return [self spellGroupGoodsDetail:tableView CellIndexPath:indexPath];
        
    }else if(indexPath.section == 1 && indexPath.row == 0){
        
        KLGoodsDetailEvaHeaderCell * cell =kCellIdentifier(KLGoodsDetailEvaHeaderCell);
        cell.titleLab.text =@"宠友评价（99+）";
        cell.evaRatioLab.attributedText =[NSMutableAttributedString getAttributedString:@"好评率：92%" handleString:@"92%" handleStrFont:kFont_14 handleStrColor:RedColor];
        return cell;
        
        
    }else if(indexPath.section == 1 && (indexPath.row <= self.dataSource.count && indexPath.row >0)){
        
        KLEvaluationListViewCell * cell = kCellIdentifier(KLEvaluationListViewCell);
        cell.evaluationListModel = self.dataSource[indexPath.row - 1];
        cell.praiseBtn.hidden    = YES;
        cell.msgBtn.hidden       = YES;
        cell.indexPath           = indexPath;
        @weakify(self)
        cell.goodsImagesBlock = ^(UIButton * _Nonnull sender, NSMutableArray * _Nonnull imgArray, NSIndexPath * _Nonnull indexPath) {
            @strongify(self)
            [self lookImageArray:imgArray index:sender.tag-120 type:1] ;
            KLLog(@"-----%ld------%@ ---- %ld",sender.tag,imgArray,indexPath.row);
        };
        return cell;
        
    }else if(indexPath.section == 1 && indexPath.row == self.dataSource.count + 1) {
        
        UITableViewCell *cell = kCellIdentifier(UITableViewCell);
        cell.textLabel.text =@"查看全部";
        cell.textLabel.font =kFont_14;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = TitleColor;
        return cell;
        
    }else if(indexPath.section == 2 && indexPath.row == 0){
        
        KLGoodsDetailStoreCell *cell = kCellIdentifier(KLGoodsDetailStoreCell);
        cell.storeName.text =@"花花鸟宠物用品专营店";
        cell.storeImg.image =[UIImage imageNamed:@"icon_15"];
        cell.storeDecArray = @[@"20000",@"10",@"7000"];
        @weakify(self)
        cell.enterStoreBlock = ^(UIButton * _Nonnull sender) {
            @strongify(self)
            KLStoreDetailViewController *vc =[[KLStoreDetailViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        return cell;
        
    }else{
        
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell.contentView addSubview:_webView];
            /* 忽略点击效果 */
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0 && self.detailType != 2){ //***  常规商品详情  **/
        
        if (indexPath.row == 0) {
            
            return AdaptedHeight(375);
            
        }else if (indexPath.row == 1) {
            
            return AdaptedHeight(98);
            
        }else if (indexPath.row == 2) {
            
            //***  拼团商品详情  **/
            return  self.detailType == 3 ? AdaptedHeight(200) : AdaptedHeight(44);
            
        }else if (indexPath.row == 3 || indexPath.row == 4) {
            
            return AdaptedHeight(49);
            
        }else{
            
            return AdaptedHeight(55);
            
        }
    }else if (indexPath.section == 0 && self.detailType == 2) { //***  限时抢购商品详情  **/
        
        if (indexPath.row == 0) {
            
            return AdaptedHeight(375);
            
        }else if (indexPath.row == 1) {
            
            return AdaptedHeight(41);
            
        }else if (indexPath.row == 2) {
            
            return AdaptedHeight(98);
            
        }else if (indexPath.row == 3) {
            
            return AdaptedHeight(44);
            
        }else if (indexPath.row == 4 || indexPath.row == 5) {
            
            return AdaptedHeight(49);
            
        }else{
            
            return AdaptedHeight(55);
            
        }
        
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        
        return AdaptedHeight(44);
        
    }else if (indexPath.section == 1 && (indexPath.row <= self.dataSource.count && indexPath.row >0)) {

        klWeakSelf;
        float height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([KLEvaluationListViewCell class]) cacheByIndexPath:indexPath configuration:^(KLEvaluationListViewCell * cell) {
            cell.evaluationListModel = weakSelf.dataSource[indexPath.row-1];
        }];

        return height;
        
        
    }else if (indexPath.section == 1 && indexPath.row == self.dataSource.count+1) {
        
        return AdaptedHeight(44);
        
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        
        return AdaptedHeight(100);
        
    }else{
        
        return self.webView.frame.size.height+5;;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0 && self.detailType == 0){ //***  限时抢购商品详情  **/
        
        if (indexPath.row == 2) {
            KLGoodsCouponPopupController *vc = [[KLGoodsCouponPopupController alloc]init];
            UIWindow *widow = [UIApplication sharedApplication].keyWindow;
            widow.backgroundColor = [UIColor blackColor];
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            [self setUpAlterViewControllerWith:vc WithDistance:MainHeight * 0.5  WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:NO WithFlipEnable:YES];
            
        }else if (indexPath.row == 4){
            //***  规格选择弹出层  **/
            KLGoodsSpecPopupController *vc =[[KLGoodsSpecPopupController alloc]init];
            [self pushSpecVC:vc];
        }
        
    }else if(indexPath.section == 0 && self.detailType == 2){ //***  限时抢购商品详情  **/
        
        if (indexPath.row == 3) {
            KLGoodsCouponPopupController *vc = [[KLGoodsCouponPopupController alloc]init];
            UIWindow *widow = [UIApplication sharedApplication].keyWindow;
            widow.backgroundColor = [UIColor blackColor];
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            [self setUpAlterViewControllerWith:vc WithDistance:MainHeight * 0.5  WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:NO WithFlipEnable:YES];
            
        }else if (indexPath.row == 5){
            //***  规格选择弹出层  **/
            KLGoodsSpecPopupController *vc =[[KLGoodsSpecPopupController alloc]init];
            [self pushSpecVC:vc];
        }
        
    }else if (indexPath.section == 0 && self.detailType == 3) {//***  拼团商品详情  **/
        
         if (indexPath.row == 4){
             //***  规格选择弹出层  **/
             KLGoodsSpecPopupController *vc =[[KLGoodsSpecPopupController alloc]init];
             [self pushSpecVC:vc];
         }
       
        
    }else if(indexPath.section == 1 && (indexPath.row == 0 || indexPath.row == self.dataSource.count + 1)){
        
        KLEvaluationListController *vc =[[KLEvaluationListController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 1 ? AdaptedHeight(5) : 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 1 ? AdaptedHeight(5) : 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
    if (!headerView) {
        headerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerCell"];
    }
    headerView.contentView.backgroundColor =RGBSigle(238);;
    return headerView;
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *footerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerCell"];
    if (!footerView) {
        footerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"footerCell"];
    }
    footerView.contentView.backgroundColor =RGBSigle(238);;
    return footerView;
}

// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && (indexPath.row < self.dataSource.count && indexPath.row >0)) {
        //分割线两端封头
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
            [cell setSeparatorInset:UIEdgeInsetsMake(0, AdaptedWidth(62), 0, 0)];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
            [cell setLayoutMargins:UIEdgeInsetsMake(0, AdaptedWidth(62), 0, 0)];
    }else{
        //分割线两端封头
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
            [cell setSeparatorInset:UIEdgeInsetsZero];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
            [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//***  下拉滚动切换顶部标题  **/
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section{
    
//     KLLog(@"=====AAAA %ld",section);
    if(!_isUpScroll && (self.tableView.dragging || self.tableView.decelerating)){
        //最上面组头（不一定是第一个组头，指最近刚被顶出去的组头）又被拉回来
        
        [UIView animateWithDuration:0.4 animations:^{
           if (section == 1) {
                self.navigationView.line.centerX = self.navigationView.leftBtn.centerX;
            }else if (section == 2){
                self.navigationView.line.centerX = self.navigationView.centerBtn.centerX;
            }
        }];
    }
}
//***  上拉滚动切换顶部标题  **/
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
//     KLLog(@"=====bbbb %ld",section);
    if((self.tableView.dragging || self.tableView.decelerating)&& _isUpScroll){
        //最上面的组头被顶出去
        [UIView animateWithDuration:0.4 animations:^{
            if (section == 0) {
                self.navigationView.line.centerX = self.navigationView.leftBtn.centerX;
            }else if (section == 1) {
                self.navigationView.line.centerX = self.navigationView.centerBtn.centerX;
            }else if (section == 2){
                self.navigationView.line.centerX = self.navigationView.rightBtn.centerX;
            }
        }];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
   
    [UIView animateWithDuration:0.4 animations:^{
        if (section == 0) {
            self.navigationView.line.centerX = self.navigationView.leftBtn.centerX;
        }else if (section == 1) {
            self.navigationView.line.centerX = self.navigationView.centerBtn.centerX;
        }else if (section == 2){
            self.navigationView.line.centerX = self.navigationView.rightBtn.centerX;
        }
    }];
}

#pragma mark - 滑动表 scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static CGFloat lastOffsetY = 0;
    _isUpScroll = lastOffsetY < scrollView.contentOffset.y;
    lastOffsetY = scrollView.contentOffset.y;
}



#pragma mark - webviewdelegate
// 页面加载完成之后调用 此方法会调用多次
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    __block CGFloat webViewHeight;
    //获取内容实际高度（像素）@"document.getElementById(\"content\").offsetHeight;"
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result,NSError * _Nullable error) {
        // 此处js字符串采用scrollHeight而不是offsetHeight是因为后者并获取不到高度，看参考资料说是对于加载html字符串的情况下使用后者可以(@"document.getElementById(\"content\").offsetHeight;")，但如果是和我一样直接加载原站内容使用前者更合适
        //获取页面高度，并重置webview的frame
        webViewHeight = [result doubleValue];
        webView.height = webViewHeight;
        
        self.webView.frame = CGRectMake(0,0, MainWidth, webView.top + webViewHeight + 10);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath * insdexPath =[NSIndexPath indexPathForRow:1 inSection:2];
            [self.tableView reloadRowsAtIndexPaths:@[insdexPath] withRowAnimation:UITableViewRowAnimationNone];
        });
    }];
}


#pragma mark - 轮播图点击事件delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    [self lookImageArray:self.goodsBannerImgArray index:index type:2] ;
}



//*** 将图片数组加入图片浏览器  **/
- (void)lookImageArray:(NSMutableArray *)imageArray index:(NSInteger)index type:(NSInteger)type{
    NSMutableArray *items = @[].mutableCopy;
    for (int i = 0; i < imageArray.count; i++) {
        NSString *urlStr = [imageArray[i] stringByReplacingOccurrencesOfString:@"bmiddle" withString:@"large"];
        KSPhotoItem  * item;
        if (type == 1) {
            item = [KSPhotoItem itemWithSourceView:nil imageUrl:[NSURL URLWithString:urlStr]];
        }else{
            item =[KSPhotoItem itemWithSourceView:nil image:[UIImage imageNamed:urlStr]];
        }
        [items addObject:item];
    }
    [self ks_photoBrowser:items index:index];
}
#pragma mark - 加载图片浏览器
- (void)ks_photoBrowser:(NSMutableArray *)itemsArray index:(NSInteger)index{
    
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:itemsArray selectedIndex:index];
    browser.dismissalStyle = KSPhotoBrowserInteractiveDismissalStyleRotation;
    browser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlur;
    browser.loadingStyle = KSPhotoBrowserImageLoadingStyleIndeterminate;
    browser.pageindicatorStyle = KSPhotoBrowserPageIndicatorStyleDot;
    browser.bounces = YES;
    [browser showFromViewController:self];
}


#pragma mark - 弹出-<规格/优惠券>-选择
- (void)pushSpecVC:(UIViewController *)vc{
    //***  规格选择弹出层  **/
    ///读取数据
    NSString * path = [[NSBundle mainBundle]pathForResource:@"dataSource" ofType:@"txt"];
    NSString * string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    vc = [[KLGoodsSpecPopupController alloc]initWithDic:obj[@"result"]];
    UIWindow *widow = [UIApplication sharedApplication].keyWindow;
    widow.backgroundColor = [UIColor blackColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setUpAlterViewControllerWith:vc WithDistance:MainHeight * 0.5  WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:NO WithFlipEnable:YES];
}

#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance WithDirection:(XWDrawerAnimatorDirection)vcDirection WithParallaxEnable:(BOOL)parallaxEnable WithFlipEnable:(BOOL)flipEnable {
    [self dismissViewControllerAnimated:YES completion:nil]; //以防有控制未退出
    XWDrawerAnimatorDirection direction = vcDirection;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.scaleRatio =0.9;
    animator.parallaxEnable = parallaxEnable;
    animator.flipEnable = flipEnable;
    animator.toDuration = 0.5;
    animator.backDuration = 0.5;
    animator.needInteractiveTimer = YES;
    [self xw_presentViewController:vc withAnimator:animator];
    __weak typeof(self)weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
}
#pragma 退出界面
- (void)selfAlterViewback {
    [self dismissViewControllerAnimated:YES completion:^{
        UIWindow *widow = [UIApplication sharedApplication].keyWindow;
        widow.backgroundColor = [UIColor whiteColor];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }];
}


#pragma mark - 数据源

- (NSMutableArray *)goodsBannerImgArray {
    if (!_goodsBannerImgArray){
        _goodsBannerImgArray = [NSMutableArray arrayWithObjects:@"1_sdgvxc",@"2_sdgvxc",@"3_sdgvxc", nil];
    }
    return _goodsBannerImgArray;
}


- (NSMutableArray *)dataSource
{
    if(!_dataSource){
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}


//#pragma mark - 图片浏览器点击delegate
//- (void)ks_photoBrowser:(KSPhotoBrowser *)browser didSelectItem:(KSPhotoItem *)item atIndex:(NSUInteger)index{
//    KLLog(@"========%ld",index);
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
