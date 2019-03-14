//
//  KLAddressEditController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/21.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLAddressEditController.h"
#import "KLAddressEditCell.h"
#import "KLTableFooterView.h"

@interface KLAddressEditController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KLTableFooterView *footerView;
@end

@implementation KLAddressEditController

- (NSMutableAttributedString *)setTitle {
    NSString * navTitle = self.pushType==1?@"新增":@"编辑";
    return [self changeTitle:[NSString stringWithFormat:@"%@收货地址",navTitle]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
}

#pragma mark - 设置默认开关响应
- (void)switchSex:(LQXSwitch *)swit{
    
    KLLog(@"------%d",swit.isOn);
}
//***  保存  **/
- (void)saveChick:(UIButton *)sender {
    
}


#pragma mark - lazy UI
- (KLTableFooterView *)footerView {
    
    if (!_footerView){
        _footerView = [[KLTableFooterView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, AdaptedHeight(80)+34)];
        _footerView.line.hidden = YES;
        [_footerView.footerBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_footerView.footerBtn addTarget:self action:@selector(saveChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h =MainHeight -StatusBarAndNavigationBarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStylePlain];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[self footerView];
        _tableView.mCustomClass([KLAddressEditCell class]);
        _tableView.mCustomClass([KLAddressChangeCell class]);
        _tableView.mCustomClass([KLAddressSwitchCell class]);

    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        
        KLAddressChangeCell * cell = kCellIdentifier(KLAddressChangeCell);
        cell.textLab.text =@"请选择地区";
        return cell;
        
    }else if (indexPath.row == 4){
        
        KLAddressSwitchCell *cell = kCellIdentifier(KLAddressSwitchCell);
//        cell.switc.on = YES;
        [cell.switc addTarget:self action:@selector(switchSex:) forControlEvents:UIControlEventValueChanged];
        return cell;
        
    }else {
        
        KLAddressEditCell *cell = kCellIdentifier(KLAddressEditCell);
        if (indexPath.row == 3) {
            cell.titleLab.text =@"详细地址";
            cell.inputField.placeholder =@"请输入详细地址";
        }else{
            cell.titleLab.text = @[@"收件人",@"手机号"][indexPath.row];
            cell.inputField.placeholder =@[@"请输入收件人",@"请输入手机号"][indexPath.row];
        }
       
        return cell;
        
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(56);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
