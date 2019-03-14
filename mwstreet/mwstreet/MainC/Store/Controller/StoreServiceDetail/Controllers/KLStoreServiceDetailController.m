//
//  KLStoreServiceDetailController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/31.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreServiceDetailController.h"
#import "KLStoreServiceDetailCell.h"
#import "UITableView+FDTemplateLayoutCell.h" //cell 自动行高适配三方扩展
#import "KLStoreServiceCell.h"
#import "KLStoreDetailHeaderView.h"

@interface KLStoreServiceDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation KLStoreServiceDetailController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"服务详情"];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];

}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight-StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLStoreServiceDetailCell class]);
        _tableView.mCustomClass([KLStoreServiceCell class]);
        
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return section == 0 ? 1 : 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0) {
        KLStoreServiceCell *cell = kCellIdentifier(KLStoreServiceCell);
        
        return cell;
    }
    KLStoreServiceDetailCell *cell = kCellIdentifier(KLStoreServiceDetailCell);
    
    cell.title = @[@"支持退款：",
                   @"有效期：",
                   @"使用时间：",
                   @"预约提醒：",
                   @"规则提醒："
                   ][indexPath.row];
    cell.text = @[@"在有效期内支持随时退款",
                  @"2019-01-01至2020-01-01",
                  @"07:00-21:00",
                  @"请务必 提前一天与商家预约",
                  @"本服务券限狗狗使用，详情请咨询商家；本次服务不可与店内其他优惠券同时使用"
                  ][indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return AdaptedHeight(72);
        
    }else {
        
        float height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([KLStoreServiceDetailCell class]) cacheByIndexPath:indexPath configuration:^(KLStoreServiceDetailCell * cell) {
            cell.text = @[@"在有效期内支持随时退款",
                          @"2019-01-01至2020-01-01",
                          @"07:00-21:00",
                          @"请务必 提前一天与商家预约",
                          @"本服务券限狗狗使用，详情请咨询商家；本次服务不可与店内其他优惠券同时使用"
                          ][indexPath.row];
        }];
        return  (height <= AdaptedHeight(35)) ? AdaptedHeight(35) : height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? CGFLOAT_MIN :AdaptedHeight(40);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 0 ? AdaptedHeight(5) : CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    KLStoreDetailHeaderView *headerView = [KLStoreDetailHeaderView initWith:tableView title:@"购买须知" moreHidden:YES lineHidden:NO];
    
    return headerView;
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
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
