//
//  KLGoodsEvaluationListController.m
//  mwstreet
//
//  Created by 科pro on 2019/3/14.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLGoodsEvaluationListController.h"
#import "KLGoodsEvaluationListCell.h"
#import "KLPublishedEvaluationController.h"

@interface KLGoodsEvaluationListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation KLGoodsEvaluationListController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"商品评价"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight -StatusBarAndNavigationBarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.mCustomClass([KLGoodsEvaluationListCell class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KLGoodsEvaluationListCell *cell = kCellIdentifier(KLGoodsEvaluationListCell);
    cell.priceLab.text = @"￥9823.00";
    cell.imgView.image =[UIImage imageNamed:[NSString stringWithFormat:@"goods_%ld",indexPath.row + 1]];
    cell.goodsTitle = @"是房贷的覅是第二个黑纷纷日是房贷的覅是第二个黑纷纷日是房贷的覅是第二个黑纷纷日是房贷的覅是第二个黑纷纷日";
    cell.goodSpac =@"重量：5kg";
    cell.indexPath = indexPath;
    @weakify(self)//去评价
    cell.evaluationBlock = ^(UIButton * _Nonnull sender, NSIndexPath * _Nonnull cellPath) {
        @strongify(self)
        KLPublishedEvaluationController *vc =[[KLPublishedEvaluationController alloc]init];
        vc.index = cellPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return AdaptedHeight(110);
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
