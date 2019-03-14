//
//  KLMyDistributionFounderVC.m
//  mwstreet
//
//  Created by 科pro on 2019/2/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyDistributionFounderVC.h"
#import "KLMyDistributionFounderCell.h"

@interface KLMyDistributionFounderVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString * nameStr;
@property (nonatomic, strong) NSString * phoneStr;
@property (nonatomic, strong) NSString * sexStr;

@end

@implementation KLMyDistributionFounderVC
- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"成为创始人"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

#pragma mark - 获取输入文字 
- (void)getTextField:(NSString *)text tag:(NSInteger)tag {
    
    switch (tag) {
        case 10:
            self.nameStr = text;
            break;
        case 11:
            self.phoneStr = text;
            break;
       
        default:
            break;
    }
    
}

#pragma mark - 性别选择 tag 50-51
- (void)didSelectSexChange:(UIButton *)sender {
    
    self.sexStr = sender.titleLabel.text;

}
#pragma mark - 立即申请
- (void)didSelectApplyChick:(UIButton *)sender {
    
    
    KLLog(@"---%@--%@--%@",self.nameStr,self.phoneStr,self.sexStr);
    
}



- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight) style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLMyDistributionFounderCell class]);
        _tableView.mCustomClass([KLMyDistributionFouPriCell class]);
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row == 0) {
        
        KLMyDistributionFounderCell *cell = kCellIdentifier(KLMyDistributionFounderCell);
        cell.titleStr =@"正在审核中...";
        klWeakSelf;
        cell.textInputBlock = ^(NSString * _Nonnull text, NSInteger tag) {
            [weakSelf getTextField:text tag:tag];
        };
        cell.sexChangeCellBlock = ^(UIButton * _Nonnull button) {
            [weakSelf didSelectSexChange:button];
        };
        cell.applyBtnChick = ^(UIButton * _Nonnull button) {
            [weakSelf didSelectApplyChick:button];
        };
        return cell;
        
    }else {
        
        KLMyDistributionFouPriCell *cell = kCellIdentifier(KLMyDistributionFouPriCell);
        cell.imgV.image =[UIImage imageNamed:@[@"werty",@"tuijianchuangshiren"][indexPath.row -1]];
        cell.titleLab.text =@[@"推荐商家",@"推荐创始人"][indexPath.row -1];
        cell.textLab.text =@[@"商家产生的营业额，创始人可以分红",@"可以拿商家营业额的利润"][indexPath.row -1];
        return cell;
        
    }
    
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row == 0) {
        
        return AdaptedHeight(370);
        
    }else {
        
        return AdaptedHeight(66);
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
