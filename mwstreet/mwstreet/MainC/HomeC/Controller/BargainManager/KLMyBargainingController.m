//
//  KLMyBargainingController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/14.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyBargainingController.h"
#import "KLMyBargainingCell.h"
#import "KLBargainDetailController.h"
@interface KLMyBargainingController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation KLMyBargainingController


- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"我的砍价"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar navBarBottomLineHidden:NO];
    [self.view addSubview:self.tableView];
    [self refreshTableViewData];
    [self.tableView.mj_header beginRefreshing];
}


//***  刷新-加载  **/
-(void)refreshTableViewData{
    
    klWeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        //网络刷新请求
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
    self.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        //网络请求
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}



- (UITableView *)tableView{
    if (!_tableView) {
//        CGFloat pushTypeH = MainHeight - StatusBarAndNavigationBarHeight;
//        CGFloat height = (self.pushType == 2 ?  pushTypeH : (pushTypeH - TabbarHeight));
        
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight - AdaptedHeight(40);

        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStylePlain];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLMyBargainingCell class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KLMyBargainingCell *cell = kCellIdentifier(KLMyBargainingCell);
    cell.goodsTitle =@"而恢复ifhefeud发而是菜市场打卡深V打开你的";
    cell.goodsNumDes =@"1258热已参与砍价";
    cell.goodsPriceDes =@"还差 88.68元";
    cell.goodsImg = [NSString stringWithFormat:@"goods_%ld",indexPath.row+1];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(125);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KLBargainDetailController *vc =[[KLBargainDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
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
