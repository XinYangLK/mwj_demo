//
//  KLGoodsCouponPopupController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/11.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLGoodsCouponPopupController.h"
#import "KLMyCouponListCell.h"

@interface KLGoodsCouponPopupController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation KLGoodsCouponPopupController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleLab];
    [self.view addSubview:self.tableView];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFont:AdaptedBOLDSYSFontSize(15)
                                        lines:1
                                         text:@"优惠券"
                                    textColor:RGBSigle(51)
                                    superView:self.view
                                  constraints:^(MASConstraintMaker *make) {
                                      make.left.right.offset = 0;
                                      make.top.offset =AdaptedHeight(18);
                                      make.height.offset =AdaptedHeight(15);
                                  }];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, AdaptedHeight(55), MainWidth, MainHeight*0.5 -AdaptedHeight(55)) style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString * identifier = [NSString stringWithFormat:@"%@-%ld",indexPath,indexPath.row];
    KLMyCouponListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[KLMyCouponListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.priceLab.attributedText =[NSMutableAttributedString getAttributedString:@"￥30" handleString:@"￥" handleStrFont:AdaptedBOLDSYSFontSize(21) handleStrColor:[UIColor whiteColor]];
    if (![cell.useCouponBtn.titleLabel.text isEqualToString:@"已领取"]) {
        [cell.useCouponBtn setTitle:@"立即领取" forState:UIControlStateNormal];
    }
    cell.limitLab.text = @"限平台部分商家使用";
    cell.totalLab.text = @"满199使用";
    cell.timeLab.text  = @"2018.12.19-2018.12.22";
    cell.indexPath     = indexPath;
    __weak __typeof(&*cell) weakCell = cell;
    cell.useCouponBlock = ^(UIButton * _Nonnull sender, NSIndexPath * _Nonnull indexPath) {
        
        weakCell.bigImgView.image =[UIImage imageNamed:@"bnrtg"];
        weakCell.smallImgView.image =[UIImage imageNamed:@"egtr"];
        [sender setTitle:@"已领取" forState:UIControlStateNormal];
        [sender setTitleColor:TextColor forState:UIControlStateNormal];
        KLLog(@"--立即领取----%ld",indexPath.row);
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
