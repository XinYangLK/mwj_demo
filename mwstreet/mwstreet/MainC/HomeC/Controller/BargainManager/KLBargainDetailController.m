//
//  KLBargainDetailController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBargainDetailController.h"
#import "KLBargainDetailCell.h"
#import "KLBargainTitleTableViewCell.h"
#import "KLBargainRecTableViewCell.h"
#import "UIViewController+KLGCDCountdown.h"

@interface KLBargainDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView         * tableView;
//***  朋友砍价列表数据源  **/
@property (nonatomic, strong) NSMutableArray      * dataArray;
//***  倒计时数据源  **/
@property (nonatomic, strong) NSMutableDictionary * dataDic;
//***  时间数据源  **/
@property (nonatomic, strong) NSArray             * timerArray;
//***  key标示数据源  **/
@property (nonatomic, strong) NSArray             * keyArray;

@property (nonatomic, strong) id timer;
@end

@implementation KLBargainDetailController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"砍价详情"];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    dispatch_cancel(self.timer);
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    //    测试倒计时同步准确性
    self.timerArray = @[@"12000"];
    self.keyArray = @[@"a"];
    _dataDic = @{}.mutableCopy;
    
    //***  添加通知  **/
    [self addObserverPostNotificationMethods];
    //***  添加倒计时  **/
    [self getCountdownTimerArray:self.timerArray keyArray:self.keyArray];
    
    [self.view addSubview:self.tableView];

}


#pragma mark - 倒计时操作
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
- (void)getCountdownTimerArray:(NSArray *)timerArray keyArray:(NSArray *)keyArray {
    klWeakSelf;
    [UIViewController getTimeWithArr:timerArray and:keyArray timerBlock:^(id  _Nonnull timer) {
      
        weakSelf.timer = timer;
   
    } countdownOverBlock:^(NSString * _Nonnull dicKey) {
        
        [weakSelf.dataDic setObject:@"停止砍价"  forKey:dicKey];
        [weakSelf.tableView reloadData];
    
    } countdownOngoingBlock:^(NSString * _Nonnull timeOut, NSString * _Nonnull dicKey) {
        
        NSString *strTime = [NSString stringWithFormat:@"砍价倒计时：%@",[NSString getMMSSFromSS:timeOut]];
        [weakSelf.dataDic setObject:strTime forKey:dicKey];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0]; //刷新第0段第0行
        KLBargainDetailCell *cell = [weakSelf.tableView cellForRowAtIndexPath:indexPath];
        cell.cellID = keyArray[indexPath.row];
        cell.timerLab.text = [self.dataDic objectForKey:cell.cellID];
        
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
    KLLog(@"--000-");
    self.timerArray = @[@"12"];
    self.keyArray = @[@"a"];
    _dataDic = @{}.mutableCopy;
    
    [self getCountdownTimerArray:self.timerArray keyArray:self.keyArray];
    
}




- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight -StatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLBargainDetailCell class]);
        _tableView.mCustomClass([KLBargainTitleTableViewCell class]);
        _tableView.mCustomClass([KLBargainRecTableViewCell class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row ==0) {
        KLBargainDetailCell *cell =kCellIdentifier(KLBargainDetailCell);
        
        cell.bargainGoodsView.accoutName  =@"我胡菲菲";
        cell.bargainGoodsView.goodsTitle  =@"范围汇额度为单位吴大伟定位定位女王hi服务和封测别分发的Fiume";
        cell.bargainGoodsView.goodsPrice  =@"190";
        cell.bargainGoodsView.describeStr =@"2154人已砍价成功";
        
        CGFloat RatioNumber = (MainWidth-AdaptedWidth(66)-2)/100;
        [cell didPagessViewAnimationDelay:2 Ratio:50 *RatioNumber];
        cell.headerView.showLable.attributedFormatBlock = ^NSAttributedString* (CGFloat value){
            NSAttributedString * attributedString =[NSMutableAttributedString getAttributedString:[NSString stringWithFormat:@"已砍价￥%.1lf",value] handleString:@"已砍价" handleStrFont:SYSTEMFONT(8) handleStrColor:[UIColor whiteColor]];
            return attributedString;
        };
        cell.headerView.priceStr       = @"￥190";
        cell.headerView.targetPriceStr = @"￥190";
        [cell.headerView.showLable countFrom:0 to:800 withDuration:2];
        
        return cell;
        
    }else if(indexPath.row == 1){
        KLBargainTitleTableViewCell *cell =kCellIdentifier(KLBargainTitleTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        KLBargainRecTableViewCell *cell = kCellIdentifier(KLBargainRecTableViewCell);
        cell.title    = self.dataArray[indexPath.row -2];
        cell.price    = @"￥9823.00";
        cell.goodsDes = @"98201人参与砍价";
        cell.btnTitle = @"砍价9折购";
        cell.imgView  = [NSString stringWithFormat:@"goods_%ld",indexPath.row+1];

        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return AdaptedHeight(669);
        
    }else if(indexPath.row == 1){
        
        return AdaptedHeight(61);
        
    }else{
        
       return AdaptedHeight(152);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //分割线两端封头
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])[cell setSeparatorInset:UIEdgeInsetsZero];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])[cell setLayoutMargins:UIEdgeInsetsZero];
}






//***  数据字典初始化  **/
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray arrayWithObjects:@"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u", @"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过人托管人托管人通过人托管人托管人通过人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u", @"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u",@"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u", nil];
    }
    return _dataArray;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//- (void)applicationDidEnterBackground:(UIApplication *)application {
//
//    UIApplication * app = [UIApplication sharedApplication];
//    __block  UIBackgroundTaskIdentifier bgTask;
//    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (bgTask != UIBackgroundTaskInvalid)
//            {
//                bgTask = UIBackgroundTaskInvalid;
//            }
//        });
//    }];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (bgTask != UIBackgroundTaskInvalid)
//            {
//                bgTask = UIBackgroundTaskInvalid;
//            }
//        });
//    });
//}

@end
