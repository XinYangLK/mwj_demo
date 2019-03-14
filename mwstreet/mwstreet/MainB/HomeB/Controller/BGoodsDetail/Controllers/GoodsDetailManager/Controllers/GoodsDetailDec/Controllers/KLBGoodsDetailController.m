//
//  KLBGoodsDetailController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/27.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBGoodsDetailController.h"
#import "KLBGoodsAttributeCell.h"
#import "UITableView+FDTemplateLayoutCell.h" //cell 自动行高适配三方扩展

@interface KLBGoodsDetailController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation KLBGoodsDetailController

//***  数据字典初始化  **/
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray arrayWithObjects:@"生产许可证编号",@"厂名",@"厂家地址",@"联系方式",@"配料",@"筛选方法",@"保质期",@"食品添加剂",@"含量",@"产地",@"种类",@"品牌",@"规格", nil];
    }
    return _dataArray;
}
//***  数据字典初始化  **/
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource =[NSMutableArray arrayWithObjects:@"320123456789523202",@"厂名",@"上海市静安区共和新路4536弄120号上海市静安区共和新路4536弄120号",@"0371-659898",@"牛奶、牛奶、牛奶、牛奶、",@"阴凉干燥无污染处贮存",@"24个月",@"无",@"1000g",@"中国",@"狗粮",@"皇家",@"5000g-10000g", nil];
    }
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight -StatusBarAndNavigationBarHeight -AdaptedHeight(40);
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLBGoodsAttributeCell class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KLBGoodsAttributeCell *cell = kCellIdentifier(KLBGoodsAttributeCell);
    cell.titleLab.text =self.dataArray[indexPath.row];
    cell.textMsg =self.dataSource[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify(self);
    float height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([KLBGoodsAttributeCell class]) cacheByIndexPath:indexPath configuration:^(KLBGoodsAttributeCell * cell) {
        @strongify(self)
        cell.textMsg = self.dataSource[indexPath.row];
    }];
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AdaptedHeight(10);
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
