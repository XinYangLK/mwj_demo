//
//  KLStoreClassifyListController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/19.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreClassifyListController.h"

@interface KLStoreClassifyListController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation KLStoreClassifyListController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:[NSString stringWithFormat:@"%@分类",self.navTitle]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStylePlain];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([UITableViewCell class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = kCellIdentifier(UITableViewCell);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = kFont_14;
    cell.textLabel.textColor = TitleColor;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(49);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//***  数据字典初始化  **/
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray arrayWithObjects:@"全部商品",@"狗粮",@"驱虫",@"零食罐头",@"猫粮",@"磨牙洁齿",@"洗护消毒",@"全部商品",@"狗粮",@"驱虫",@"零食罐头",@"猫粮",@"磨牙洁齿",@"洗护消毒",@"全部商品",@"狗粮",@"驱虫",@"零食罐头",@"猫粮",@"磨牙洁齿",@"洗护消毒",@"全部商品",@"狗粮",@"驱虫",@"零食罐头",@"猫粮",@"磨牙洁齿",@"洗护消毒",@"全部商品",@"狗粮",@"驱虫",@"零食罐头",@"猫粮",@"磨牙洁齿",@"洗护消毒", nil];
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
