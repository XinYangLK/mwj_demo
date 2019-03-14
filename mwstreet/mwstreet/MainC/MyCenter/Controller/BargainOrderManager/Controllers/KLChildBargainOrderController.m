//
//  KLChildBargainOrderController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/15.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLChildBargainOrderController.h"
#import "KLOrderTypeManagerCell.h"
#import "KLOrderTypeManagerFooterView.h"

@interface KLChildBargainOrderController ()
<
UITableViewDelegate,
UITableViewDataSource,
KLOrderTypeManagerFooterViewDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation KLChildBargainOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self refreshTableViewData];
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark - 去支付  delegate
- (void)didGoPayBtnChick:(KLOrderTypeManagerFooterView *)footerView Section:(NSInteger)section {
    
    NSLog(@"--------%ld",section);
    
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


//***  tableView UI  **/
- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat height = MainHeight - AdaptedHeight(44) - StatusBarAndNavigationBarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, height) style:UITableViewStylePlain];
        _tableView.backgroundColor = SpacColor;
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLOrderTypeManagerCell class]);
        _tableView.mCustomFooterHeaderClass([KLOrderTypeManagerFooterView class]);
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    KLOrderTypeManagerCell *cell = kCellIdentifier(KLOrderTypeManagerCell);
    cell.goodsImg   = [NSString stringWithFormat:@"goods_%ld",indexPath.row + 1];
    cell.goodsTitle = @"划分为合肥第五非法或违反我问服务费我i范围分为五";
    cell.goodsPrice = @"￥9823.00";
    cell.goodsDes   = @"1258热已参与砍价";
   
    
    if ([self.typeId isEqualToString:@"全部"]) {
        
        if (indexPath.section % 2 == 0) {
            cell.goodsStatus = @"砍价成功";
        }else{
            cell.goodsStatus = @"砍价失败";
        }
        
    }else if ([self.typeId isEqualToString:@"砍价成功"]) {
        
        cell.goodsStatus = @"砍价成功";
        
    }else if ([self.typeId isEqualToString:@"砍价失败"]) {
        
        cell.goodsStatus = @"砍价失败";
        
    }else if ([self.typeId isEqualToString:@"失效商品"]) {
        
        cell.goodsStatus = @"失效商品";
        
    }
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(113);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  
    return  AdaptedHeight(50);

}


//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    KLOrderTypeManagerFooterView *footerView  = kHeaderFooterIdentifier(KLOrderTypeManagerFooterView);
    

    if ([self.typeId isEqualToString:@"全部"]) {
        
        if (section % 2 == 0) {
            
            footerView.rightBtn.hidden =NO;
            footerView.leftBtn.hidden = YES;
            footerView.line.hidden =NO;
            footerView.desLab.hidden =NO;
            footerView.delegate = self;
            footerView.section  = section;
            footerView.rightText =@"去付款";
            
        }else {
            
            footerView.desLab.hidden = YES;
            footerView.rightBtn.hidden =NO;
            footerView.leftBtn.hidden = NO;
            footerView.line.hidden =NO;
            footerView.leftText =@"删除订单";
            footerView.rightText =@"重新砍";
        }
        
    }else if ([self.typeId isEqualToString:@"砍价成功"]) {
       
        footerView.rightBtn.hidden =NO;
        footerView.leftBtn.hidden = YES;
        footerView.line.hidden =NO;
        footerView.desLab.hidden =NO;
        footerView.delegate = self;
        footerView.section  = section;
        footerView.rightText =@"去付款";
        
    }else if ([self.typeId isEqualToString:@"砍价失败"]) {
        
        footerView.desLab.hidden = YES;
        footerView.rightBtn.hidden =NO;
        footerView.leftBtn.hidden = NO;
        footerView.line.hidden =NO;
        footerView.leftText =@"删除订单";
        footerView.rightText =@"重新砍";
        
    }else if ([self.typeId isEqualToString:@"失效商品"]) {
        
        footerView.desLab.hidden =YES;
        footerView.leftBtn.hidden = YES;
        footerView.rightBtn.hidden =NO;
        footerView.line.hidden =NO;
        footerView.rightText =@"删除订单";

        
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
