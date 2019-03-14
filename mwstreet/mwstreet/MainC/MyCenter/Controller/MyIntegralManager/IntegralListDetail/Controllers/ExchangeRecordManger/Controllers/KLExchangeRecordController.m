//
//  KLExchangeRecordController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLExchangeRecordController.h"
#import "KLIntegralGoodsListCell.h"

@interface KLExchangeRecordController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation KLExchangeRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}


#pragma mark - lazy UI

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight -AdaptedHeight(40) ;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLIntegralGoodsListCell class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KLIntegralGoodsListCell *cell = kCellIdentifier(KLIntegralGoodsListCell);
    if (indexPath.row %2 == 0) {
        cell.ImgV.image =[UIImage imageNamed:@"pic_ppp1"];
    }else {
        cell.ImgV.image =[UIImage imageNamed:@"pic_ppp2"];
    }
    cell.indexPath     = indexPath;
    cell.titleLab.text = @"实木木马红木胡桃木";
    cell.textLab.text  = @"所需萌豆：";
    cell.numLab.text   = @"1314";
    cell.exchangeBtn.hidden =YES;
   
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(125);
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
