//
//  KLChildsViewController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLChildsViewController.h"
#import "KLTodaySpecialCell.h"
#import "KLGoodsDetailController.h"
@interface KLChildsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation KLChildsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight - 44;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStylePlain];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = SpacColor;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLTodaySpecialCell class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KLTodaySpecialCell *cell = kCellIdentifier(KLTodaySpecialCell);
    NSString * imgName =[NSString stringWithFormat:@"goods_%u",1+arc4random()%7];
    cell.goodsImg.image =[UIImage imageNamed:imgName];
    cell.goodsPrice.text    = @"￥188";
    cell.goodsOldPrice.text = @"￥388";
    cell.goodsName.text     = @"很舒服is随时随地啊飞士大夫很舒服is随时随地啊飞士大夫";
    cell.goodsSoldNum.text  = @"已售203件";
    [cell.addBtn setImage:[UIImage imageNamed:@"gouwuche_h"] forState:UIControlStateNormal];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(152);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KLGoodsDetailController *vc =[[KLGoodsDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //分割线两端封头
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])[cell setSeparatorInset:UIEdgeInsetsZero];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])[cell setLayoutMargins:UIEdgeInsetsZero];
}


@end
