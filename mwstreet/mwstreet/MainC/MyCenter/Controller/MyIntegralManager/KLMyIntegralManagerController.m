//
//  KLMyIntegralManagerController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/18.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyIntegralManagerController.h"
#import "KLMyIntegralManagerCell.h"
#import "KLIntegralListController.h"       //萌豆明细列表
#import "KLIntegralGoodsListController.h"  //萌豆商品列表

@interface KLMyIntegralManagerController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation KLMyIntegralManagerController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"萌豆"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

//***  萌豆规则  **/
- (void)right_button_event:(UIButton *)sender {
 
    KLLog(@"===萌豆规则====");
}


#pragma mark ------ lazy UI
//***  导航右边按钮  **/
- (UIButton *)set_rightButton{
    UIButton  *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightBtn setTitle:@"萌豆规则" forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = kFont_15;
    return rightBtn;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight) style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([UITableViewCell class]);
        _tableView.mCustomClass([KLMyIntegralManagerCell class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        KLMyIntegralManagerCell *cell =kCellIdentifier(KLMyIntegralManagerCell);
        cell.number = @"1888";
        return cell;
        
    }else {
        
        UITableViewCell *cell =kCellIdentifier(UITableViewCell);
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = RGBSigle(51);
        cell.textLabel.font =kFont_15;
        cell.textLabel.text =@[@"萌豆兑换礼品",@"查看萌豆明细"][indexPath.row-1];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return AdaptedHeight(101);
    }else {
       return AdaptedHeight(52);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row ==1) { //萌豆兑换礼品
       
        KLIntegralGoodsListController *vc =[[KLIntegralGoodsListController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    }else if(indexPath.row == 2){ //萌豆积分明细
        KLIntegralListController *vc =[[KLIntegralListController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    }
}

// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //分割线两端封头
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])[cell setSeparatorInset:UIEdgeInsetsZero];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])[cell setLayoutMargins:UIEdgeInsetsZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc]init];
    return headerView;
}
//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footerView = [[UIView alloc]init];
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
