//
//  KLChildServiceOrderController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLChildServiceOrderController.h"
#import "KLServerOrderCell.h"
#import "KLMyOrderManagerHeaderView.h"
#import "KLServerOrderFooterView.h"

@interface KLChildServiceOrderController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation KLChildServiceOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - AdaptedHeight(40)- StatusBarAndNavigationBarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLServerOrderCell class]);
        _tableView.mCustomFooterHeaderClass([KLMyOrderManagerHeaderView class]);
        _tableView.mCustomFooterHeaderClass([KLServerOrderFooterView class]);
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 20;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KLServerOrderCell *cell = kCellIdentifier(KLServerOrderCell);
    cell.decLab.hidden = YES;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return AdaptedHeight(72);
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AdaptedHeight(40);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return AdaptedHeight(50);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    KLMyOrderManagerHeaderView *headerView  =kHeaderFooterIdentifier(KLMyOrderManagerHeaderView);
    headerView.storeName   = @"人文氛围和服务IE覅我我维尔费尔法人文氛围和服务IE覅我我维尔费尔法人文氛围和服务IE覅我我维尔费";
    headerView.orderStatus = @"卖家已发货";
    return headerView;
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    KLServerOrderFooterView *footerView  = kHeaderFooterIdentifier(KLServerOrderFooterView);

    if (self.typeId == 0) {
        if (section % 3 == 0) { //全部
            
            footerView.rightBtn.hidden = NO;
            footerView.leftBtn.hidden = NO;
            footerView.leftText   = @"删除订单";
            footerView.rightText  = @"去付款";
            
        }else if (section % 3 == 1) {
            
            footerView.leftBtn.hidden = NO;
            footerView.rightBtn.hidden = NO;
            footerView.rightText  = @"去使用";
            footerView.leftText   = @"退订";
            
        }else if (section % 3 == 2) {
            
            footerView.leftBtn.hidden = YES;
            footerView.rightBtn.hidden = NO;
            footerView.rightText  = @"再次购买";
        }
        
    }else if (self.typeId == 1) { //去付款
        
        footerView.rightBtn.hidden = NO;
        footerView.leftBtn.hidden = NO;
        footerView.leftText   = @"删除订单";
        footerView.rightText  = @"去付款";
        
    }else if (self.typeId == 2) { //去使用
        
        footerView.leftBtn.hidden = NO;
        footerView.rightBtn.hidden = NO;
        footerView.rightText  = @"去使用";
        footerView.leftText   = @"退订";
        
    }else if (self.typeId == 3) { //退款
        
        footerView.leftBtn.hidden = YES;
        footerView.rightBtn.hidden = NO;
        footerView.rightText  = @"再次购买";
        
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
