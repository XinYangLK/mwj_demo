//
//  KLStockBillViewController.m
//  mwstreet
//
//  Created by 科pro on 2018/12/19.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLStockBillViewController.h"
#import "KLStockBillViewCell.h"
#import "KLNumEditAlertView.h"
#import "KLShoppingCarBottomView.h"

@interface KLStockBillViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) KLShoppingCarBottomView * bottomView;


@end

@implementation KLStockBillViewController

- (NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"进货单"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
}



#pragma mark - 弹窗调整商品数量
- (void)didGoodsNumber:(UILabel *)numLabel cellIndexPath:(NSIndexPath *)indexPath {
    
    KLNumEditAlertView * alertView =[[KLNumEditAlertView alloc]initWithFrame:CGRectZero count:numLabel.text];
    [alertView showAnimated:YES];
    alertView.numBlock = ^(NSString * _Nonnull number) {
        numLabel.text = number;
        KLLog(@"====== %@",number);
    };
}
//***  全选  **/
- (void)allGoodsIsSelected:(UIButton *)sender {
    KLLog(@"全选");
}


//***  结算  **/
- (void)paySelectedGoods:(UIButton *)btn {
    
    KLLog(@"结算");
//    KLPlaceOrderViewController *vc =[[KLPlaceOrderViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    //    for (GoodsModel *goods in self.selectedShop) {
    //        NSLog(@"%@ \n",goods.goodsName);
    //    }
}


//***  购物车底部信息View  **/
- (KLShoppingCarBottomView *)bottomView {
    if (!_bottomView){
        CGFloat h = TabbarHeight + AdaptedHeight(49) + StatusBarAndNavigationBarHeight;
        _bottomView = [[KLShoppingCarBottomView alloc]initWithFrame:CGRectMake(0, MainHeight - h, MainWidth, AdaptedHeight(49))];
        [_bottomView.selectImgBtn addTarget:self action:@selector(allGoodsIsSelected:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.actionBtn addTarget:self action:@selector(paySelectedGoods:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}


- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight - TabbarHeight - AdaptedHeight(49);
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLStockBillViewCell class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KLStockBillViewCell *cell = kCellIdentifier(KLStockBillViewCell);
    cell.indexPath     = indexPath;
    cell.goodsTitle    = self.dataArray[indexPath.row];
    cell.specLab.text  = @"规格：5kg";
    cell.priceLab.text = @"￥65.00/袋";
    cell.stockLab.text = @"仅剩60袋";
    @weakify(self)
    cell.numberBlock = ^(UILabel * _Nonnull numLab, NSIndexPath * _Nonnull indexPath) {
        @strongify(self)
        [self didGoodsNumber:numLab cellIndexPath:indexPath];
    };
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(140);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
    if (!headerView) {
        headerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerCell"];
    }
    return headerView;
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *footerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerCell"];
    if (!footerView) {
        footerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"footerCell"];
    }
    return footerView;
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"移除进货单";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex:[indexPath row]];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]                     withRowAnimation:UITableViewRowAnimationAutomatic]; //删除对应数据的cell
    }
}

//***  数据字典初始化  **/
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray arrayWithObjects:@"耐吉斯SOLUTION 比利时版 鸡肉三文鱼配方玩赏犬粮 3磅/1.36kg",@"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u", @"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过人托管人托管人通过人托管人托管人通过人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u", @"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u",@"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u", nil];
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

@end
