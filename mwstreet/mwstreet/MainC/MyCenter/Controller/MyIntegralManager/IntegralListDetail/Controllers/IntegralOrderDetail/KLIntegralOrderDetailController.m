//
//  KLIntegralOrderDetailController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLIntegralOrderDetailController.h"
#import "KLMyOrderDetailStatusCell.h"
#import "KLPlaceOrderGoodsFooterView.h"
#import "KLIntegralGoodsListCell.h"


@interface KLIntegralOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation KLIntegralOrderDetailController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"兑换详情"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h =MainHeight -StatusBarAndNavigationBarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView =[UIView new];
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.mCustomClass([KLMyOrderDetailStatusCell class]);
        _tableView.mCustomClass([KLMyOrderDetailAddressCell class]);
        _tableView.mCustomClass([KLMyOrderDetailMsgCell class]);
        _tableView.mCustomClass([KLIntegralGoodsListCell class]);
        _tableView.mCustomFooterHeaderClass([KLPlaceOrderGoodsFooterView class]);
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 2;
    }else if (section == 1){
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0 ) {
        
        KLMyOrderDetailStatusCell *cell = kCellIdentifier(KLMyOrderDetailStatusCell);
        cell.titleLab.text =@"等待买家付款";
        cell.textLab.text =@"30分钟后系统自动取消";
        return cell;
        
    }else if (indexPath.section == 0 && indexPath.row ==1) {
        
        KLMyOrderDetailAddressCell * cell = kCellIdentifier(KLMyOrderDetailAddressCell);
        cell.nameLab.text = @"收货人：王敏君   18595426879";
        cell.addressLab.text =@"上海市静安区共和新路3668弄125号";
        return cell;
        
        
    }else if (indexPath.section == 1 ){
        
        KLIntegralGoodsListCell *cell = kCellIdentifier(KLIntegralGoodsListCell);
        if (indexPath.row %2 == 0) {
            cell.ImgV.image =[UIImage imageNamed:@"pic_ppp1"];
        }else {
            cell.ImgV.image =[UIImage imageNamed:@"pic_ppp2"];
        }
        cell.line.hidden   = NO;
        cell.indexPath     = indexPath;
        cell.titleLab.text = @"实木木马红木胡桃木";
        cell.textLab.text  = @"所需萌豆：";
        cell.numLab.text   = @"1314";
        cell.exchangeBtn.hidden =YES;
        return cell;
    
        
    }else{
        
        KLMyOrderDetailMsgCell * cell = kCellIdentifier(KLMyOrderDetailMsgCell);
        cell.titleLab.text = @[@"订单号:",
                               @"下单时间:",
                               @"订单备注:"][indexPath.row];
        
        cell.msgLab.text = @[@"201920001565359",
                             @"2019-01-15",
                             @"无备注"][indexPath.row];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        return AdaptedHeight(55);
        
    }else if (indexPath.section == 0 && indexPath.row == 1){
        
        return AdaptedHeight(83);
        
    }else if (indexPath.section == 1 ){
        
        return AdaptedHeight(125);
        
    }else{
        
        return AdaptedHeight(48);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        
        return AdaptedHeight(20);
        
    }else{
        
        return CGFLOAT_MIN;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   
    if (section == 0 || section ==1) {
        
        return AdaptedHeight(5);
        
    }else{
        
        return CGFLOAT_MIN;
    }
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
   
    if (section == 0) {

        KLPlaceOrderGoodsFooterView * footerView  = kHeaderFooterIdentifier(KLPlaceOrderGoodsFooterView);
        
        return footerView;
    }
    UITableViewHeaderFooterView *footerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerCell"];
    if (!footerView) {
        footerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"footerCell"];
    }
    footerView.contentView.backgroundColor = SpacColor;
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
