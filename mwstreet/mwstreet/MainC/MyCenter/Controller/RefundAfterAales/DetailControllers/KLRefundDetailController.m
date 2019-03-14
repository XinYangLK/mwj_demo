//
//  KLRefundDetailController.m
//  mwstreet
//
//  Created by 科pro on 2019/3/4.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLRefundDetailController.h"
#import "KLMyOrderDetailStatusCell.h"
#import "KLRefundDetailCell.h"
#import "UITableView+FDTemplateLayoutCell.h" //cell 自动行高适配三方扩展


@interface KLRefundDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation KLRefundDetailController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"退款详情"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
//        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLMyOrderDetailStatusCell class]);
        _tableView.mCustomClass([KLMyOrderDetailMsgCell class]);
        _tableView.mCustomClass([KLRefundDetailCell class]);

    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return section == 0 ? 4 : 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        KLMyOrderDetailStatusCell *cell = kCellIdentifier(KLMyOrderDetailStatusCell);
        cell.titleLab.text =@"等待买家付款";
        cell.textLab.text =@"微信入账中";
        return cell;
        
    }else if (indexPath.section == 0 && indexPath.row > 0) {
        
        KLMyOrderDetailMsgCell * cell = kCellIdentifier(KLMyOrderDetailMsgCell);
        cell.titleLab.text = @[@"退款金额:",
                               @"退款账户:",
                               @"到账时间:"][indexPath.row-1];
        cell.msgLab.text = @[@"￥20",
                             @"微信零钱",
                             @"预计2019年2月26日前"][indexPath.row-1];
         return cell;
        
    }else{
        
        KLRefundDetailCell * cell = kCellIdentifier(KLRefundDetailCell);
        cell.titleLab.text =@[@"退款申请已提交",@"点评处理完成",@"微信入账"][indexPath.row];
        cell.content = self.dataSource[indexPath.row];
        cell.timeLab.text =@"2019-02-22  12:10:16";
        return cell;
        
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        return AdaptedHeight(55);
        
    }else if (indexPath.section == 0 && indexPath.row > 0) {
        
        return AdaptedHeight(48);
        
    }else {
        
        @weakify(self);
        float height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([KLRefundDetailCell class]) cacheByIndexPath:indexPath configuration:^(KLRefundDetailCell * cell) {
            @strongify(self)
            cell.content = self.dataSource[indexPath.row];
        }];
        return height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        //分割线两端封头
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
            [cell setSeparatorInset:UIEdgeInsetsMake(0, MainWidth, 0, 0)];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
            [cell setLayoutMargins:UIEdgeInsetsMake(0, MainWidth, 0, 0)];
        
    }else{
        //分割线两端封头
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
            [cell setSeparatorInset:UIEdgeInsetsMake(0, AdaptedWidth(34), 0, 0)];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
            [cell setLayoutMargins:UIEdgeInsetsMake(0, AdaptedWidth(34), 0, 0)];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? CGFLOAT_MIN : AdaptedHeight(35);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 0 ? AdaptedHeight(5) : CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
    if (!headerView) {
        headerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerCell"];
    }
    headerView.contentView.backgroundColor = [UIColor whiteColor];
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
   
    return section ==0 ? @"" : @"退款进度";
}



- (NSMutableArray *)dataSource {
    if (!_dataSource){
        _dataSource = [NSMutableArray arrayWithObjects:
                       @"你的退款申请已提交",
                       @"微信处理完成后，退款会在1-3个工作日内退回至您的微信账户",
                       @"微信正将 20.00 元钱入账您的微信账户，您可以打开微信钱包核实预计最晚2019年2月26日完成入账，具体入账进度请使用交易号 45628795461235478555  拨打微信客服 95017 查询",
                       nil];
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
