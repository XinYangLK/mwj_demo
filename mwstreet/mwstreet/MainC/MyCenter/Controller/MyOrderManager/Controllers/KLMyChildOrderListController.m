//
//  KLMyChildOrderListController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/11.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyChildOrderListController.h"
#import "KLMyOrderManagerHeaderView.h"
#import "KLMyOrderManagerFooterView.h"
#import "KLMyCollectListCell.h"
#import "KLMyOrderDetailController.h" //订单详情
#import "KLMyOrderApplyForARefundVC.h"//申请售后
#import "KLGoodsEvaluationListController.h" //评价商品列表
@interface KLMyChildOrderListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation KLMyChildOrderListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self refreshTableViewData];
    
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


- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - AdaptedHeight(40)- StatusBarAndNavigationBarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = SpacColor;
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate   = self;
        _tableView.dataSource = self;
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
    
    return arc4random()%2 + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KLMyCollectListCell *cell = kCellIdentifier(KLMyCollectListCell);
    cell.findBtn.hidden = YES;
    cell.goodsPrice = @"￥9823.00";
    cell.goodsImg   = [NSString stringWithFormat:@"goods_%ld",indexPath.row + 1];
    cell.goodsTitle = @"是房贷的覅是第二个黑纷纷日是房贷的覅是第二个黑纷纷";
    cell.goodSpac =@"规格：10Kg";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return AdaptedHeight(100);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KLMyOrderDetailController *vc =[[KLMyOrderDetailController alloc]init];
    if ([self.typeId isEqualToString:@"全部"]) {
        if (indexPath.section % 4 == 0) {
            vc.typeId = 1;
        }else if (indexPath.section % 4 == 1) {
            vc.typeId = 2;
        }else if (indexPath.section % 4 == 2) {
            vc.typeId = 3;
        }else if (indexPath.section % 4 == 3) {
            vc.typeId = 4;
        }
    }else if ([self.typeId isEqualToString:@"待付款"]) {
        vc.typeId = 2;
    }else if ([self.typeId isEqualToString:@"待发货"]) {
        vc.typeId = 3;
    }else if ([self.typeId isEqualToString:@"待收货"]) {
        vc.typeId = 1;
    }else if ([self.typeId isEqualToString:@"待评价"]) {
        vc.typeId = 4;
    }   
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
    headerView.storeName   = @"人文氛围和服务IE覅我我维尔费尔法人文氛围和服务IE覅我我维尔费尔法人文氛围和服务IE覅我我维尔费";
    headerView.orderTime   = @"2019-09-26";
    headerView.orderStatus = @"卖家已发货";
    return headerView;
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
  
    KLMyOrderManagerFooterView *footerView  = kHeaderFooterIdentifier(KLMyOrderManagerFooterView);
    footerView.totalDes   = @"共1件商品  合计：￥95（免运费）";
    footerView.section = section;
    @weakify(self)
    if ([self.typeId isEqualToString:@"全部"]) {
        if (section % 4 == 0) {
            
            footerView.centerBtn.hidden = NO;
            footerView.rightBtn.hidden = NO;
            footerView.leftBtn.hidden = NO;
            footerView.rightText  = @"确认收货";
            footerView.leftText   = @"申请退款";
            footerView.centerText = @"查看物流";
            
            footerView.sectionBtnBlock = ^(UIButton * _Nonnull sender, NSInteger sention) {
                @strongify(self)
                if (sender.tag == 300) {
                    KLMyOrderApplyForARefundVC *vc =[[KLMyOrderApplyForARefundVC alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            };
            
        }else if (section % 4 == 1) {
            
            footerView.leftBtn.hidden = YES;
            footerView.centerBtn.hidden = NO;
            footerView.rightBtn.hidden = NO;
            footerView.centerText = @"删除订单";
            footerView.rightText  = @"去付款";
            
        }else if (section % 4 == 2) {
            
            footerView.leftBtn.hidden = YES;
            footerView.centerBtn.hidden = NO;
            footerView.rightBtn.hidden = NO;
            footerView.centerText = @"申请退款";
            footerView.rightText  = @"提醒发货";
            footerView.sectionBtnBlock = ^(UIButton * _Nonnull sender, NSInteger sention) {
                @strongify(self)
                if (sender.tag == 200) {
                    KLMyOrderApplyForARefundVC *vc =[[KLMyOrderApplyForARefundVC alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            };
            
        }else if (section % 4 == 3) {
            
            footerView.leftBtn.hidden = YES;
            footerView.centerBtn.hidden = YES;
            footerView.rightBtn.hidden = NO;
            footerView.rightText  = @"去评价";
            
        }
        
    }else if ([self.typeId isEqualToString:@"待付款"]) {
        
        footerView.leftBtn.hidden = YES;
        footerView.centerBtn.hidden = NO;
        footerView.rightBtn.hidden = NO;
        footerView.centerText = @"删除订单";
        footerView.rightText  = @"去付款";

    }else if ([self.typeId isEqualToString:@"待发货"]) {
        
        footerView.leftBtn.hidden = YES;
        footerView.centerBtn.hidden = NO;
        footerView.rightBtn.hidden = NO;
        footerView.centerText = @"申请退款";
        footerView.rightText  = @"提醒发货";
        footerView.sectionBtnBlock = ^(UIButton * _Nonnull sender, NSInteger sention) {
            @strongify(self)
            if (sender.tag == 200) {
                KLMyOrderApplyForARefundVC *vc =[[KLMyOrderApplyForARefundVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        
    }else if ([self.typeId isEqualToString:@"待收货"]) {
        
        footerView.centerBtn.hidden = NO;
        footerView.rightBtn.hidden = NO;
        footerView.leftBtn.hidden = NO;
        footerView.rightText  = @"确认收货";
        footerView.centerText = @"查看物流";
        footerView.leftText   = @"申请退款";

        footerView.sectionBtnBlock = ^(UIButton * _Nonnull sender, NSInteger sention) {
            @strongify(self)
            if (sender.tag == 300) {
                KLMyOrderApplyForARefundVC *vc =[[KLMyOrderApplyForARefundVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        
    }else if ([self.typeId isEqualToString:@"待评价"]) {
        
        footerView.leftBtn.hidden = YES;
        footerView.centerBtn.hidden = YES;
        footerView.rightBtn.hidden = NO;
        footerView.rightText  = @"去评价";
        footerView.sectionBtnBlock = ^(UIButton * _Nonnull sender, NSInteger sention) {
            @strongify(self)
            if (sender.tag == 100) {
                KLGoodsEvaluationListController *vc =[[KLGoodsEvaluationListController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        
    }
    
   
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
