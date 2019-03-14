//
//  KLHomeTable.m
//  mwstreet
//
//  Created by 科pro on 2018/12/18.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLHomeTableView.h"


@implementation KLHomeTableView

//***  单例加载  **/
+ (instancetype)shareTable{
    static KLHomeTableView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[KLHomeTableView alloc] init];
    });
    return  shareInstance;
}

//***  初始化  **/
- (instancetype)init {
    self = [super init];
    if(self){
        [self configUI];
    }
    return self;
}


- (void)configUI {
    [self creatTableUI];
    [self configNavigationUI];
}
//***  加载navigationView  **/
- (void)configNavigationUI{
    
    [self addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset =0;
        make.height.offset = StatusBarAndNavigationBarHeight;
    }];
}
//***  加载tableView  **/
- (void)creatTableUI{
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = StatusBarAndNavigationBarHeight;
        make.left.right.bottom.offset =0;
    }];
}

//***  导航 View  **/
- (KLNavigationSearchView *)navigationView {
    
    if (!_navigationView){
        _navigationView = [KLNavigationSearchView creatNavigationView];
    }
    return _navigationView;
}

//***  tableView  UI--- Lazy  **/
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.tableFooterView =[UIView new];
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


@end
