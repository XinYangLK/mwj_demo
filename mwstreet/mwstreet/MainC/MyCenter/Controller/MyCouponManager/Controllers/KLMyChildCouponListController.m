//
//  KLMyChildCouponListController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/11.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyChildCouponListController.h"
#import "KLMyCouponListCell.h"
#import "KLMyCouponHeaderView.h"

@interface KLMyChildCouponListController ()<
UITableViewDelegate,
UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation KLMyChildCouponListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - AdaptedHeight(40)- StatusBarAndNavigationBarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth,h) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mCustomClass([KLMyCouponListCell class]);
        if (self.typeId == 0) {
            _tableView.mCustomFooterHeaderClass([KLMyCouponHeaderView class]);
        }
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KLMyCouponListCell *cell = kCellIdentifier(KLMyCouponListCell);
    cell.priceLab.attributedText =[NSMutableAttributedString getAttributedString:@"￥30" handleString:@"￥" handleStrFont:AdaptedBOLDSYSFontSize(21) handleStrColor:[UIColor whiteColor]];
    if (self.typeId == 0) {
        
        [cell.useCouponBtn setTitle:@"立即使用" forState:UIControlStateNormal];
        cell.limitLab.text = @"限平台部分商家使用";
        cell.totalLab.text = @"满199使用";
        cell.timeLab.text  = @"2018.12.19-2018.12.22";
        cell.indexPath = indexPath;
        cell.useCouponBlock = ^(UIButton * _Nonnull sender, NSIndexPath * _Nonnull indexPath) {
            
            KLLog(@"------%ld",indexPath.row);
        };
        
        
    }else {
        
        cell.bigImgView.image =[UIImage imageNamed:@"bnrtg"];
        cell.smallImgView.image =[UIImage imageNamed:@"egtr"];
        [cell.useCouponBtn setTitle:@"已失效" forState:UIControlStateNormal];
        [cell.useCouponBtn setTitleColor:TextColor forState:UIControlStateNormal];
        cell.limitLab.text = @"限平台部分商家使用";
        cell.totalLab.text = @"满199使用";
        cell.timeLab.text  = @"2018.12.19-2018.12.22";
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(110);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.typeId == 0 ? AdaptedHeight(70) : CGFLOAT_MIN;
    
//    if (self.typeId == 0) {
//        return AdaptedHeight(70);
//    }else {
//        return CGFLOAT_MIN;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.typeId == 0) {
        KLMyCouponHeaderView *headerView  = kHeaderFooterIdentifier(KLMyCouponHeaderView);
        headerView.exchangeBlock = ^(UIButton * _Nonnull sender) {
            KLLog(@"-------兑换-----");
        };
        return headerView;
    }else {
        UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
        if (!headerView) {
            headerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerCell"];
        }
        return headerView;
    }
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *footerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerCell"];
    if (!footerView) {
        footerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"footerCell"];
    }
    return footerView;
}



@end
