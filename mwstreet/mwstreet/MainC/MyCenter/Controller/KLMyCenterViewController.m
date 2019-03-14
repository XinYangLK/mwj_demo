//
//  KLMyCenterViewController.m
//  mengWuStreet
//
//  Created by 科pro on 2018/12/15.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLMyCenterViewController.h"
#import "KLMyCenterOrderCell.h"        //全部订单cell
#import "KLMyCenterOrderStatusCell.h"  //订单状态 cell
#import "KLMyCenterFunctionCell.h"     //功能模块cell
#import "KLMyOrderManagerController.h" //订单列表管理
#import "KLMyCouponManagerController.h"//优惠券列表管理
#import "KLSettingViewController.h"    //设置管理
#import "KLMyCollectListController.h"  //我的收藏
#import "KLServiceOrderManager.h"      //服务订单
#import "KLBargainOrderManagerController.h"  //我的砍价
#import "KLSpellGroupOrderMangerController.h"//我的拼团
#import "KLHeaderScaleView.h"                //导航头
#import "KLLoginRegisterManager.h"           //登录注册
#import "KLMyIntegralManagerController.h"    //积分管理

#import "KLMyDistributionApplyVC.h"          //分销申请
#import "KLMyDistributionCenterVC.h"         //分销中心
#import "KLRefundAfterSalesController.h"     //退款售后

#import "KLAppDelegate.h"

@interface KLMyCenterViewController ()<
UINavigationControllerDelegate,
UIGestureRecognizerDelegate,
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate,
KLMyCenterOrderStatusCelldelegate,
KLHeaderScaleViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
//***  导航左边按钮  **/
@property (nonatomic, strong) UIButton    * leftBtn;
//***  导航右边按钮  **/
@property (nonatomic, strong) UIButton    * rightBtn;
//***  导航标题  **/
@property (nonatomic, strong) UILabel * navTitle;
@end

@implementation KLMyCenterViewController


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
    [self configerUI];

}


#pragma mark - 自定义 delegate && 方法响应

//***  订单状态按钮点击响应  **/
- (void)didOrderStatusBtnChick:(UIButton *)sender{
    if (sender.tag == 14) { //退款售后
        KLRefundAfterSalesController *vc =[[KLRefundAfterSalesController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{ //订单列表
        [self myOrdrViewController:sender.tag - 9];
    }
    
}
//***  订单列表控制器  **/
- (void)myOrdrViewController:(NSInteger)indexPage {
    
    KLMyOrderManagerController *vc =[[KLMyOrderManagerController alloc]init];
    vc.indexPage = indexPage;
    [self.navigationController pushViewController:vc animated:YES];
}

//***  导航设置按钮响应  **/
- (void)navigationBtnChick:(UIButton *)sender {
    switch (sender.tag) {
        case 227://消息
        {
            KLSettingViewController *vc =[[KLSettingViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 228://设置
        {
            KLSettingViewController *vc =[[KLSettingViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}
//***  表头按钮点击事件 tag == 230 - 232 **/
- (void)didHeaderBtnChick:(NSInteger)tag{
    switch (tag) {
        case 229://登录
        {
            KLLoginRegisterManager *vc =[[KLLoginRegisterManager alloc]init];
            vc.indexPage =1;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 230://萌豆
        {
            KLMyIntegralManagerController *vc =[[KLMyIntegralManagerController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 231:{//收藏夹
            KLMyCollectListController *vc =[[KLMyCollectListController alloc]init];
            vc.navTitle = @"收藏夹";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 232:{//优惠券
            
            KLMyCouponManagerController *vc =[[KLMyCouponManagerController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - cell 点击事件响应
- (void)didTableView:(UITableView *)tableview selectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section ==0 && indexPath.row == 0) {
        //***  订单列表控制器  **/
        [self myOrdrViewController:0];
    }else if (indexPath.section ==1){
        
        if (indexPath.row == 0) {// 服务订单
            
            KLServiceOrderManager *vc =[[KLServiceOrderManager alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 1){// 我的拼团
            
            KLSpellGroupOrderMangerController *vc =[[KLSpellGroupOrderMangerController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 2){// 我的砍价
            
            KLBargainOrderManagerController * vc =[[KLBargainOrderManagerController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 3){// 门店管理
            
            
        }else if (indexPath.row == 4){// 集采中心
            
            KLAppDelegate *appdelegate = (id)[UIApplication sharedApplication].delegate;
            [appdelegate.window setRootViewController:appdelegate.tabbarB];
            [UIView pushOrPopAnimationType:kCATransitionFromRight view:appdelegate.window];
            
            
        }else if (indexPath.row == 5){// 分销系统
            
            KLMyDistributionApplyVC *vc =[[KLMyDistributionApplyVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
            
            //            KLMyDistributionCenterVC *vc =[[KLMyDistributionCenterVC alloc]init];
            //            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}



#pragma mark - lazy -UI
- (void)configerUI {
    
    [self.view addSubview:self.tableView];
    
    CGFloat hY = (AdaptedHeight(52)-23) + StatusBarAndNavigationBarHeight + AdaptedHeight(173);
    KLHeaderScaleView * headerView= [[KLHeaderScaleView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, hY) title:nil telPhone:@"132****3192"];
    headerView.delegate = self;
    headerView.scrollView = self.tableView;
    [self.view addSubview:headerView];
    
    
    [self.view addSubview:self.leftBtn];
    [self.view addSubview:self.rightBtn];
    [self navTitle];

    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedHeight(15);
        make.height.width.offset =AdaptedHeight(22);
        make.top.offset = StatusBarHeight + 11;
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset =AdaptedHeight(-15);
        make.height.width.offset =AdaptedHeight(22);
        make.top.offset = StatusBarHeight + 11;
    }];
    
}

- (UILabel *)navTitle {
    if (!_navTitle){
        _navTitle = [UILabel zj_labelWithFontSize:17
                                            lines:1
                                             text:@"个人中心"
                                        textColor:[UIColor clearColor]
                                        superView:self.view
                                      constraints:^(MASConstraintMaker *make) {
                                          make.centerX.offset = 15;
                                          make.height.offset =AdaptedHeight(20);
                                          make.width.offset =AdaptedWidth(90);
                                          make.top.offset = StatusBarHeight + 11;
                                      }];
        _navTitle.backgroundColor =[UIColor clearColor];
        _navTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _navTitle;
}

//***  导航左边边按钮  **/
- (UIButton *)leftBtn {
    if (!_leftBtn){
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[UIImage imageNamed:@"xinxi"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(navigationBtnChick:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.tag = 228;
    }
    return _leftBtn;
}
//***  导航右边按钮  **/
- (UIButton *)rightBtn {
    
    if (!_rightBtn){
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(navigationBtnChick:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.tag = 227;
    }
    return _rightBtn;
    
}

//***  表  **/
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight-TabbarHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = SpacColor;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mCustomClass([UITableViewCell class]);
        _tableView.mCustomClass([KLMyCenterOrderCell class]);
        _tableView.mCustomClass([KLMyCenterOrderStatusCell class]);
        _tableView.mCustomClass([KLMyCenterFunctionCell class]);
    }
    return _tableView;
}

#pragma mark - tableView  delegate---datasouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return section == 0 ? 2 : 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            KLMyCenterOrderCell * cell =kCellIdentifier(KLMyCenterOrderCell);
            cell.textLabel.text =@"商城订单";
            cell.textLabel.textColor =RGBSigle(51);
            cell.textLabel.font =kFont_15;
            return cell;
            
        }else{
            
            KLMyCenterOrderStatusCell *cell = kCellIdentifier(KLMyCenterOrderStatusCell);
            cell.delegate = self;
            NSArray * titleArray =@[@"待付款",@"待发货",@"待收货",@"待评价",@"退款/售后"];
            [cell setDataArray:titleArray];
            return cell;
        }
    }else {
        //@"icon_10",@"礼品兑换",
        
        KLMyCenterFunctionCell *cell = kCellIdentifier(KLMyCenterFunctionCell);
        NSArray * imgArray = @[@"icon_6",@"icon_7",@"icon_9",@"icon_11",@"icon_12",@"icon_13"];
        NSArray * titleArray =@[@"服务订单",@"拼团订单",@"砍价订单",@"门店管理",@"集采中心",@"分销系统"];
        cell.imageView.image =[UIImage imageNamed:imgArray[indexPath.row]];
        cell.textLabel.text = titleArray[indexPath.row];
        cell.textLabel.textColor =TitleColor;
        cell.textLabel.font = kFont_14;
        return cell;
    }
    
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0 && indexPath.row ==1) {
        return AdaptedHeight(75);
    }else if(indexPath.section ==0 && indexPath.row ==0){
        return AdaptedHeight(35);
    }else{
        return AdaptedHeight(50);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self didTableView:tableView selectRowAtIndexPath:indexPath];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return section == 0 ? AdaptedHeight(10):CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 0 ? AdaptedHeight(10):AdaptedHeight(150);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
    if (!headerView) {
        headerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerCell"];
    }
    headerView.contentView.backgroundColor =[UIColor whiteColor];

    return headerView;
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *footerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerCell"];
    if (!footerView) {
        footerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"footerCell"];
    }
    footerView.contentView.backgroundColor = SpacColor;
    return footerView;
}

#pragma mark ------ 滑动表 scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat top = scrollView.contentInset.top;
    
    CGFloat y =  scrollView.contentOffset.y;
    
    CGFloat offsetY = top + y;
    
    CGFloat progressChange = offsetY /190.00;
    

    if (progressChange <= 0) {

        _navTitle.textColor = [UIColor clearColor];
        
    }else{
        
        _navTitle.textColor = WhiteAlphaColor(progressChange);
    }
    
}




#pragma mark - 视差滑动 delegate 视图委托 --
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    CGFloat offsetY = scrollView.contentInset.top + scrollView.contentOffset.y;
//    CGFloat progress = offsetY / self.headerHeight;
//
//    if (progress <= 0) {
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//        self.tableHeaderView.backImg.mj_y = offsetY;
//        self.tableHeaderView.backImg.mj_h = self.headerHeight - offsetY;
////        self.navTitle.textColor =[UIColor clearColor];
//    }else{
////        self.navTitle.textColor =RGBA(255,255,255, progress);
//    }

//    float a = 0.0;
//    float x = AdaptedWidth(24);
//    if (offsetY >= 0 && offsetY <= 160) {
//        _topImageView.transform = CGAffineTransformMakeScale(1 - offsetY/300, 1 - offsetY/300);
//    }
//    else if (offsetY > 160) {
//        a = - ((offsetY - 160)> AdaptedHeight(9) ? AdaptedHeight(9) : (offsetY - 160));
//        x = AdaptedHeight(10);
//        _topImageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
//    }else if (offsetY <= 0) {
//        a = a - offsetY;
//        _topImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
//    }
//
//    CGRect frame = _topImageView.frame;
//    frame.origin.y = AdaptedHeight(18) + a;
//    frame.origin.x = x;
//    self.topImageView.frame = frame;
//}



@end
