//
//  KLMeViewController.m
//  mwstreet
//
//  Created by 科pro on 2018/12/19.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLMeViewController.h"
#import "KLMyCenterOrderCell.h"
#import "KLMyCenterOrderStatusCell.h"
#import "KLMyCenterFunctionCell.h"
#import "KLBMeHeaderView.h"

#import "KLMeBOrderManger.h"//订单管理
#import "KLMyCollectListController.h" //我的收藏
#import "KLAddressListController.h" //我的地址

@interface KLMeViewController ()
<
UINavigationControllerDelegate,
UIGestureRecognizerDelegate,
UITableViewDelegate,
UITableViewDataSource,
KLMyCenterOrderStatusCelldelegate
>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) KLBMeHeaderView * headerView;
@end

@implementation KLMeViewController

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
    [self.view addSubview:self.tableView];
}



//***  订单状态按钮点击响应  **/
- (void)didOrderStatusBtnChick:(UIButton *)sender{
   
    [self myOrdrViewController:sender.tag - 9];
    
}

//***  订单列表控制器  **/
- (void)myOrdrViewController:(NSInteger)indexPage {
    
    KLMeBOrderManger * vc = [[KLMeBOrderManger alloc]init];
    vc.indexPage = indexPage;
    [self.navigationController pushViewController:vc animated:YES];
   
    
}





#pragma mark ------ 视差滑动区头
- (KLBMeHeaderView *)headerView{
    if (!_headerView) {
        _headerView =[[KLBMeHeaderView alloc]initWithFrame:CGRectMake(0, 0, MainWidth,self.headerHeight)];
    }
    return  _headerView;
}

- (CGFloat)headerHeight{
    return AdaptedHeight(176 + StatusBarHeight);
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - TabbarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLMyCenterOrderCell class]);
        _tableView.mCustomClass([KLMyCenterOrderStatusCell class]);
        _tableView.mCustomClass([KLMyCenterFunctionCell class]);

    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        KLMyCenterOrderCell * cell =kCellIdentifier(KLMyCenterOrderCell);
        cell.textLabel.text =@"商城订单";
        cell.textLabel.textColor =RGBSigle(51);
        cell.textLabel.font =kFont_15;
        return cell;
        
    }else if (indexPath.row == 1) {
        
        KLMyCenterOrderStatusCell *cell = kCellIdentifier(KLMyCenterOrderStatusCell);
        cell.delegate = self;
        cell.type = 2;
        NSArray * titleArray =@[@"待付款",@"待发货",@"已发货",@"退货单"];
        [cell setDataArray:titleArray];
        return cell;
        
    }else {
        //@"icon_10",@"礼品兑换",
        
        KLMyCenterFunctionCell *cell = kCellIdentifier(KLMyCenterFunctionCell);
        NSArray * imgArray = @[@"xinshoucang",@"landizhiiii"];
        NSArray * titleArray =@[@"我的收藏",@"我的地址"];
        cell.line.hidden = YES;
        cell.imageView.image =[UIImage imageNamed:imgArray[indexPath.row-2]];
        cell.textLabel.text = titleArray[indexPath.row-2];
        cell.textLabel.textColor =TitleColor;
        cell.textLabel.font =kFont_14;
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row == 1) {
        return  AdaptedHeight(75);
    }
    return AdaptedHeight(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) { //全部订单
        
        [self myOrdrViewController:0];
        
    }else if (indexPath.row == 2){ //我的收藏
        
        KLMyCollectListController *vc =[[KLMyCollectListController alloc]init];
        vc.navTitle = @"我的收藏";
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 3){ //我的地址
        
        KLAddressListController *vc =[[KLAddressListController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}



// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //分割线两端封头
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])[cell setSeparatorInset:UIEdgeInsetsZero];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])[cell setLayoutMargins:UIEdgeInsetsZero];
}

#pragma mark - --- 视差滑动 delegate 视图委托 ---
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentInset.top + scrollView.contentOffset.y;
    CGFloat progress = offsetY / self.headerHeight;
    if (progress <= 0) {
        self.headerView.backImg.mj_y = offsetY;
        self.headerView.backImg.mj_h = self.headerHeight - offsetY;
        self.headerView.backImg.contentMode = UIViewContentModeScaleAspectFill;
    }
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
