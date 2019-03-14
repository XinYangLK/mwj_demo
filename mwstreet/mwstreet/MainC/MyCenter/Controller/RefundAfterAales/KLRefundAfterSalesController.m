//
//  KLRefundAfterSalesController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLRefundAfterSalesController.h"
#import "KLMyOrderManagerHeaderView.h"
#import "KLMyOrderManagerFooterView.h"
#import "KLMyCollectListCell.h"

#import "KLRefundDetailController.h"//售后详情

@interface KLRefundAfterSalesController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation KLRefundAfterSalesController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"退款/售后"];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLMyCollectListCell class]);
        _tableView.mCustomFooterHeaderClass([KLMyOrderManagerFooterView class]);
        _tableView.mCustomFooterHeaderClass([KLMyOrderManagerHeaderView class]);
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arc4random()%3 + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KLMyCollectListCell *cell = kCellIdentifier(KLMyCollectListCell);
    cell.findBtn.hidden = YES;
    cell.goodsPrice = @"￥9823.00";
    cell.goodsImg   = [NSString stringWithFormat:@"goods_%ld",indexPath.row + 1];
    cell.goodsTitle = @"是房贷的覅是第二个黑纷纷日是房贷的覅是第二个黑纷纷日是房贷的覅是第二个黑纷纷日是房";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return AdaptedHeight(100);

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KLRefundDetailController *vc =[[KLRefundDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AdaptedHeight(52);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return AdaptedHeight(70);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    KLMyOrderManagerHeaderView *headerView  =kHeaderFooterIdentifier(KLMyOrderManagerHeaderView);
    headerView.storeName   = @"人文氛围和服务IE覅我我维尔费尔法人文";
    headerView.orderTime   = @"2019-09-26";
    headerView.orderStatus = @"退款成功";
    return headerView;
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    KLMyOrderManagerFooterView *footerView  = kHeaderFooterIdentifier(KLMyOrderManagerFooterView);
    footerView.totalDes   = @"共1件商品  合计：￥95（免运费）";
    footerView.centerBtn.hidden = NO;
    footerView.rightBtn.hidden = NO;
    footerView.leftBtn.hidden = YES;
    footerView.rightText  = @"查看详情";
    footerView.centerText = @"联系客服";
    
    return footerView;
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
