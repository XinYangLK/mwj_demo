//
//  KLStoreServerOrderController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreServerOrderController.h"
#import "KLStoreDetailHeaderView.h"
#import "KLStoreServreOrderCell.h"  //服务验证cell
#import "KLServerOrderCell.h"       //服务项目cell
#import "KLStoreServerBootomView.h" //底部栏



@interface KLStoreServerOrderController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) KLStoreServerBootomView * bootomView;

@end

@implementation KLStoreServerOrderController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"确定订单"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self bootomView];
}


- (KLStoreServerBootomView *)bootomView {
    if (!_bootomView){
        _bootomView = [[KLStoreServerBootomView alloc]init];
        _bootomView.titleLab.attributedText = [NSMutableAttributedString getAttributedString:@"待支付 ￥30" handleString:@"￥30" handleStrFont:kFont_15 handleStrColor:RedColor];
        _bootomView.confirmBlock = ^(UIButton * _Nonnull sender) {
            
            KLLog(@"-----w确定 提交");
            
        };
        [self.view addSubview:_bootomView];
        [_bootomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset = 0;
            make.height.offset = TabbarHeight;
        }];
    }
    return _bootomView;
}



- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight - TabbarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLServerOrderCell class]);
        _tableView.mCustomFooterHeaderClass([KLStoreDetailHeaderView class]);
        _tableView.mCustomClass([KLStoreServreOrderCell class]);
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        KLStoreServreOrderCell * cell =kCellIdentifier(KLStoreServreOrderCell);
        cell.titleLab.text =@"将凭证码发送至";
        cell.textLab.text =@"18532456987";
        return cell;
        
    }else {
        
        KLServerOrderCell *cell = kCellIdentifier(KLServerOrderCell);
        
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return AdaptedHeight(48);
    }
    
    return AdaptedHeight(72);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? CGFLOAT_MIN : AdaptedHeight(40);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 0 ? AdaptedHeight(5) : CGFLOAT_MIN;
}





- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
        if (!headerView) {
            headerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerCell"];
        }
        return headerView;
    }
    
    KLStoreDetailHeaderView *headerView = [KLStoreDetailHeaderView initWith:tableView title:@"派多格宠物生活馆" moreHidden:YES lineHidden:NO];
    headerView.titleLab.textColor = TextColor;
    
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
