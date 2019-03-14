//
//  KLMyOrderDetailController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyOrderDetailController.h"
#import "KLMyOrderDetailStatusCell.h"
#import "KLPlaceOrderGoodsCell.h"
#import "KLStoreGoodsDescribeCell.h"
#import "KLStoreServiceDetailCell.h"
#import "KLPlaceOrderGoodsFooterView.h"
#import "KLPlaceOrderGoodsHeaderView.h"
#import "KLMyOrderDetailFooterView.h"

#import "KLMyOrderResultsStatusController.h"

@interface KLMyOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KLMyOrderDetailFooterView * footerView;

@end

@implementation KLMyOrderDetailController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"订单详情"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)footerViewChick:(UIButton *)sender {
    switch (sender.tag) {
        case 10:{
            if (self.typeId == 1) {
                
                KLLog(@"确认收货");
                
            }else if (self.typeId == 2){
                
                KLLog(@"去付款");
                
                KLMyOrderResultsStatusController *vc =[[KLMyOrderResultsStatusController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if (self.typeId == 3){
                
                KLLog(@"提醒发货");
                
            }else if (self.typeId == 4){
                
                KLLog(@"去评价");
            }
        }
            break;
            
        case 11:{
            if (self.typeId == 1) {
                
                KLLog(@"查看物流");
                
            }else if (self.typeId == 2){
                
                KLLog(@"删除订单");
                
            }
        }
            break;
        case 12:{
            if (self.typeId == 1) {
                
                 KLLog(@"申请退款");
            }
            
        }
            break;
            
        default:
            break;
    }
}




- (KLMyOrderDetailFooterView *)footerView {
    if (!_footerView){
        _footerView = [[KLMyOrderDetailFooterView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, AdaptedHeight(60)+34)];
        if (self.typeId == 1) {
            [_footerView.leftBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            [_footerView.centerBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            [_footerView.rightBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            
        }else if (self.typeId == 2){
            
            _footerView.leftBtn.hidden = YES;
            [_footerView.centerBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            [_footerView.rightBtn setTitle:@"去付款" forState:UIControlStateNormal];
            
        }else if (self.typeId == 3){
            
            _footerView.leftBtn.hidden = YES;
            _footerView.centerBtn.hidden = YES;
            [_footerView.rightBtn setTitle:@"提醒发货" forState:UIControlStateNormal];
            
        }else if (self.typeId == 4){
            _footerView.leftBtn.hidden = YES;
            _footerView.centerBtn.hidden = YES;
            [_footerView.rightBtn setTitle:@"去评价" forState:UIControlStateNormal];
            
        }
        @weakify(self)
        _footerView.bootomBlock = ^(UIButton * _Nonnull sender) {
            @strongify(self)
            [self footerViewChick:sender];
        };
    }
    return _footerView;
}


- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStylePlain];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[self footerView];
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.mCustomClass([KLMyOrderDetailStatusCell class]);
        _tableView.mCustomClass([KLMyOrderDetailAddressCell class]);
        _tableView.mCustomClass([KLPlaceOrderGoodsCell class]);
        _tableView.mCustomClass([KLStoreGoodsDescribeCell class]);
        _tableView.mCustomClass ([KLMyOrderDetailMsgCell class]);
        _tableView.mCustomFooterHeaderClass([KLPlaceOrderGoodsFooterView class]);
        _tableView.mCustomFooterHeaderClass([KLPlaceOrderGoodsHeaderView class]);
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 2;
        
    }else if (section == 1){
        
        return 1 + 3;
        
    }else {
        
        return 3;
    }
    
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
        
        
    }else if (indexPath.section == 1 && indexPath.row == 0){
        
        KLPlaceOrderGoodsCell * cell = kCellIdentifier(KLPlaceOrderGoodsCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imgName     = @"goods_3";
        cell.goodsName   = @"发顺丰四十我if汉文化服务一而后无法维护费IE回复IE和";
        cell.goodsPrice  = @"￥65.8";
        cell.goodsNumber = @"×99";
        return cell;
            
    }else if (indexPath.section == 1 && indexPath.row > 0){
            
        KLStoreGoodsDescribeCell * cell = kCellIdentifier(KLStoreGoodsDescribeCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLab.textColor = RGBSigle(51);
        cell.angleImg.hidden = YES;
        cell.title = @[@"商品金额",
                       @"运费",
                       @"优惠抵扣"][indexPath.row -1];
        
        cell.text = @[@"￥65.80",
                      @"￥0.00",
                      @"-￥10"][indexPath.row -1];
        return cell;
        
    }else {
        
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
        
    }else if (indexPath.section == 1 && indexPath.row == 0){
        
        return AdaptedHeight(93);
        
    }else{
        
        return AdaptedHeight(48);
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        
        return AdaptedHeight(50);
        
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
    
    
    if (section == 1) {
        
        KLPlaceOrderGoodsHeaderView * headerView = kHeaderFooterIdentifier(KLPlaceOrderGoodsHeaderView);
        headerView.headerTitle =@"派多格宠物店";
        
        return headerView;
    }
    
    UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
    if (!headerView) {
        headerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerCell"];
    }
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



// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        //分割线两端封头
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
            [cell setSeparatorInset:UIEdgeInsetsZero];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
            [cell setLayoutMargins:UIEdgeInsetsZero];
       
    }else{
        //分割线两端封头
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
            [cell setSeparatorInset:UIEdgeInsetsMake(0, MainWidth, 0, 0)];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
            [cell setLayoutMargins:UIEdgeInsetsMake(0, MainWidth, 0, 0)];
    }
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
