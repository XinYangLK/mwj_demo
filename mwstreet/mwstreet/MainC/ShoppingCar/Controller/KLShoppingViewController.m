//
//  KLShoppingViewController.m
//  mengWuStreet
//
//  Created by 科pro on 2018/12/15.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLShoppingViewController.h"
#import "KLShoppingCarBottomView.h" //底部编辑
#import "KLShoppingCarTableCell.h"  //购物车cell
#import "KLShoppingCarHeaderView.h" //购物车商店分区头
#import "KLPlaceOrderViewController.h" //订单结算
#import "KLNumEditAlertView.h"     //数量编辑弹窗
@interface KLShoppingViewController ()<
UITableViewDelegate,
UITableViewDataSource,
KLShoppingCarTableCellDelegate,
KLShoppingCarHeaderViewDelegate
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KLShoppingCarBottomView * bottomView;
@property (nonatomic, assign) BOOL eidtType;
@end

@implementation KLShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =RGBSigle(255);//COLOR(@"#F5F5F5");
    [self configerUI];
}

- (NSMutableAttributedString *)setTitle{
   return [self changeTitle:@"购物车"];
}


#pragma mark ------ 导航编辑按钮响应
- (void)right_button_event:(UIButton *)sender {
    sender.selected =!sender.selected;
    self.eidtType = sender.selected;
    if (sender.selected) {
        [sender setTitle:@"取消" forState:UIControlStateNormal];
        [self editBtn:@"删除" titleColor:TitleColor backColor:RGBSigle(255) borderWidth:1 borderColor:LineColor];
    }else{
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        [self editBtn:@"结算" titleColor:RGBSigle(255) backColor:RedColor borderWidth:0 borderColor:[UIColor clearColor]];
    }
}
//***  编辑操作执行 变化  **/
- (void)editBtn:(NSString *)title titleColor:(UIColor *)color backColor:(UIColor *)backColor borderWidth:(NSInteger)borderWidth borderColor:(UIColor *)borderColor {
    
    [self.bottomView.actionBtn setTitle:title forState:UIControlStateNormal];
    [self.bottomView.actionBtn setTitleColor:color forState:UIControlStateNormal];
    [self.bottomView.actionBtn setBackgroundImage:[UIImage imageWithColor:backColor] forState:UIControlStateNormal];
    [self.bottomView.actionBtn setLayerCornerRadius:AdaptedHeight(16) borderWidth:borderWidth borderColor:borderColor];
    
    CGFloat h = TabbarHeight + AdaptedHeight(53) + StatusBarAndNavigationBarHeight;
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomView.frame =CGRectMake(0, MainHeight, MainWidth,0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.bottomView.frame =CGRectMake(0, MainHeight - h, MainWidth, AdaptedHeight(53));
        }];
    }];
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



#pragma mark - ShoopingCartBottomViewDelegate

- (void)allGoodsIsSelected:(UIButton *)sender {
    KLLog(@"======");
}


//全选
//- (void)allGoodsIsSelected:(BOOL)selccted withButton:(UIButton *)btn {
//    //修改数据源数据，刷新列表
////    for (ShopModel *shopModel in self.dataSource) {
////        shopModel.isSelected = selccted;
////        for (GoodsModel *goodsModel in shopModel.goods) {
////            goodsModel.isSelected = selccted;
////        }
////    }
//    [self.tableView reloadData];
//}
//结算
- (void)paySelectedGoods:(UIButton *)btn {
    
    if (self.eidtType) {
       NSLog(@"删除，选中的商品有：\n ");
    }else{
       NSLog(@"结算，选中的商品有：\n ");
        KLPlaceOrderViewController *vc =[[KLPlaceOrderViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
//    for (GoodsModel *goods in self.selectedShop) {
//        NSLog(@"%@ \n",goods.goodsName);
//    }
}
#pragma mark - ShoppingCartSectionHeaderViewDelegate
- (void)hearderView:(KLShoppingCarHeaderView *)headerView isSelected:(BOOL)isSelected section:(NSInteger)section
{
    //刷新选中的section数据
//    ShopModel *shopModel = self.dataSource[section];
//    shopModel.isSelected = isSelected;
//    for (GoodsModel *goodsModel in shopModel.goods) {
//        goodsModel.isSelected = isSelected;
//    }
    
    //#warning 数据源多的时候，刷新section时，页面会出现bug
    //    NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:section];
    //    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadData];
}
#pragma mark - ShoppingCartCellDelegate

- (void)selectCell:(KLShoppingCarTableCell *)cell selected:(BOOL)isSelected indexPath:(NSIndexPath *)indexPath {
    NSLog(@"section:%ld row:%ld isSelected:%d",indexPath.section,indexPath.row,isSelected);
    //更新选中cell的section下的数据
    //    ShopModel *shopModel = self.dataSource[indexPath.section];
    //    GoodsModel *goodsModel = shopModel.goods[indexPath.row];
    //    goodsModel.isSelected = isSelected;
    //判断整个section是不是全被选中
    //    BOOL sectionSelected = YES;
    //    for (GoodsModel *goodsModel in shopModel.goods) {
    //        if (!goodsModel.isSelected) {
    //            sectionSelected = NO;
    //        }
    //    }
    //    shopModel.isSelected = sectionSelected;
    //    NSLog(@"all section selected:%d",sectionSelected);
    
    //#warning 数据源多的时候，刷新section时，页面会出现bug
    //    NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:indexPath.section];
    //    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadData];
}



//#pragma mark - 自定义
//- (void)caculatePrice:(GoodsModel *)goodsModel{
//    @synchronized (self.selectedShop)
//    {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            if (goodsModel.isSelected) {
//                if (![self.selectedShop containsObject:goodsModel]) {
//                    [self.selectedShop addObject:goodsModel];
//                }
//            }
//            else {
//                if ([self.selectedShop containsObject:goodsModel]) {
//                    [self.selectedShop removeObject:goodsModel];
//                }
//            }
//
//            NSDecimalNumber *allPriceDecimal = [NSDecimalNumber zero];
//            for (GoodsModel *goods in self.selectedShop) {
//                NSString *price = goods.price;
//                NSDecimalNumber *decimalPrice = [NSDecimalNumber decimalNumberWithString:price];
//                allPriceDecimal = [allPriceDecimal decimalNumberByAdding:decimalPrice];
//            }
//            NSString *allPriceStr = [allPriceDecimal stringValue];
//            NSLog(@"总价：%@",allPriceStr);
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if ([allPriceStr floatValue]>0) {
//                    [self.bottomView setPayEnable:YES];
//                    self.bottomView.allPriceLabel.text = [NSString stringWithFormat:@"总价：%@",[allPriceDecimal stringValue]];
//                } else {
//                    [self.bottomView setPayEnable:NO];
//                    self.bottomView.allPriceLabel.text = @"总价：";
//                }
//            });
//        });
//    }
//}




#pragma mark ------ 构建 UI
- (void)configerUI {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
}
//***  导航右边按钮  **/
- (UIButton *)set_rightButton{
    UIButton  *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitleColor:TitleColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font =kFont_14;
    return rightBtn;
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
        CGFloat h = MainHeight-StatusBarAndNavigationBarHeight - TabbarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth,  - AdaptedHeight(50))];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.mCustomClass([KLShoppingCarTableCell class]);
        _tableView.mCustomFooterHeaderClass([KLShoppingCarHeaderView class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KLShoppingCarTableCell *cell =kCellIdentifier(KLShoppingCarTableCell);
    cell.indexPath = indexPath;
   
    klWeakSelf;
    cell.cellNumBlock = ^(UILabel * _Nonnull numLab,NSIndexPath * _Nonnull indexPath) {
        [weakSelf didGoodsNumber:numLab cellIndexPath:indexPath];
    };
    
//    ShopModel *shopModel = self.dataSource[indexPath.section];
//    GoodsModel *goodsModel = shopModel.goods[indexPath.row];
//    [cell setInfo:goodsModel];
    
    //计算并刷新价格、刷新结算按钮状态
//    [self caculatePrice:goodsModel];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(135);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AdaptedHeight(25);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    KLShoppingCarHeaderView *headerView  = kHeaderFooterIdentifier(KLShoppingCarHeaderView)
    headerView.section = section;
//    ShopModel *shopModel = self.dataSource[section];
//    [hearderView setInfo:shopModel];
//    //判断是否全选
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        BOOL allSelected = YES;
//        for (ShopModel *shopModel in self.dataSource) {
//            if (!shopModel.isSelected) {
//                allSelected = NO;
//            }
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.bottomView setIsClick:allSelected];
//        });
//    });
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



// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //分割线两端封头
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])[cell setSeparatorInset:UIEdgeInsetsZero];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])[cell setLayoutMargins:UIEdgeInsetsZero];
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
