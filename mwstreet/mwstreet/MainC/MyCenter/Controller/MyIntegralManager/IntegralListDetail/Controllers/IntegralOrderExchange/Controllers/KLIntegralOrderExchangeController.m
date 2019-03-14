//
//  KLIntegralOrderExchangeController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLIntegralOrderExchangeController.h"
#import "KLOrderAddressCell.h"//地址
#import "KLIntegralGoodsListCell.h"
#import "KLPlaceOrderGoodsFooterView.h"
#import "KLIntegralOrderBootomView.h"
#import "KLIntegralOrderDetailController.h" //订单详情
@interface KLIntegralOrderExchangeController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KLIntegralOrderBootomView *bootomView;
@end

@implementation KLIntegralOrderExchangeController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"商品兑换"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self bootomView];
}
- (KLIntegralOrderBootomView *)bootomView {
    if (!_bootomView){
        _bootomView = [[KLIntegralOrderBootomView alloc]init];
        @weakify(self)
        _bootomView.confirmBlock = ^(UIButton * _Nonnull sender) {
            @strongify(self)
            KLIntegralOrderDetailController *vc =[[KLIntegralOrderDetailController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        _bootomView.titleLab.attributedText = [NSMutableAttributedString getAttributedString:@"共一件商品   合计：100 萌豆" handleString:@"100" handleStrFont:kFont_14 handleStrColor:RedColor];
        [self.view addSubview:_bootomView];
        [_bootomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset = 0;
            make.height.offset = TabbarSafeBottomMargin + AdaptedHeight(49);
        }];
    }
    return _bootomView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h= MainHeight - TabbarSafeBottomMargin -StatusBarAndNavigationBarHeight -AdaptedHeight(49);
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView =[UIView new];
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.mCustomClass([KLOrderAddressCell class]);
        _tableView.mCustomClass([KLIntegralGoodsListCell class]);
        _tableView.mCustomFooterHeaderClass([KLPlaceOrderGoodsFooterView class]);
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0 ){
        KLOrderAddressCell *cell = kCellIdentifier(KLOrderAddressCell);
        cell.nameLab.text    = @"积分北京覅人     1198347677";
        cell.statusLab.text  = @"默认";
        cell.addressLab.text = @"上海市静安区共和新路3668弄125号";
        return cell;
    }else {
        
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
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 ){
        return AdaptedHeight(88);
    }else{
        return AdaptedHeight(125);
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 ) {
        
        return CGFLOAT_MIN;
        
    }else{
        
        return AdaptedHeight(20);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0 ) {
        
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
