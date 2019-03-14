//
//  KLChildsFlashController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/28.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLChildsFlashController.h"
#import "KLFlashManagerCell.h"
#import "KLFlashManagerHeaderView.h"
#import "UIViewController+KLGCDCountdown.h"
#import "KLGoodsDetailController.h"

@interface KLChildsFlashController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
//***  倒计时数据源  **/
@property (nonatomic, strong) NSMutableDictionary * dataDic;
//***  时间数据源  **/
@property (nonatomic, strong) NSArray             * timerArray;
//***  key标示数据源  **/
@property (nonatomic, strong) NSArray             * keyArray;

@property (nonatomic, strong) id timer;
@end

@implementation KLChildsFlashController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}


- (void)loadData {
  
    //***  添加通知  **/
    [self addObserverPostNotificationMethods];
    //***  添加倒计时  **/
    
    NSInteger timerSecond = 12000;
    
    if (self.index >= 2) {
        timerSecond = timerSecond + 3600 * 2 * (self.index-1);
    }
    NSString * timer = [NSString stringWithFormat:@"%ld",timerSecond];
    NSString * key = [NSString stringWithFormat:@"a%ld",timerSecond];

    [self getCountdownTimer:timer key:key];

    [self.view addSubview:self.tableView];
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
        
        KLFlashManagerHeaderView * headerView =(KLFlashManagerHeaderView *)[weakSelf.tableView headerViewForSection:0];
        headerView.countdownView.hourLabel.text   = str_hour;
        headerView.countdownView.minuteLabel.text = str_minute;
        headerView.countdownView.secondLabel.text = str_second;
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



- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight -AdaptedHeight(49) -StatusBarAndNavigationBarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStylePlain];
        _tableView.backgroundColor = SpacColor;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLFlashManagerCell class]);
        _tableView.mCustomFooterHeaderClass([KLFlashManagerHeaderView class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    KLFlashManagerCell *cell = kCellIdentifier(KLFlashManagerCell);
    cell.goodsImg      = @"goods_6";
    cell.goodsTitle    = @"DVI导航比乌尔禾覅维护覅额UI而非if是ifVB的福卡除非对方";
    cell.goodsLimited  = @"限量100件";
    cell.goodsFlash    = @"立即抢购";
    cell.goodsPrice    = @"199";
    cell.goodsOldPrice = @"288";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(153);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KLGoodsDetailController *vc =[[KLGoodsDetailController alloc]init];
    vc.detailType = 2;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AdaptedHeight(45);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    KLFlashManagerHeaderView *headerView  = kHeaderFooterIdentifier(KLFlashManagerHeaderView);
    headerView.title =[NSString stringWithFormat:@"%@,先下单先得哦",self.type];
    headerView.text =[NSString stringWithFormat:@"距本场%@",self.status];
    return headerView;
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footerView =[UIView new];
    return footerView;
}



@end
