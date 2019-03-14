//
//  KLSettingViewController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/11.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLSettingViewController.h"
#import "KLTableFooterView.h"
#import "KLLoginRegisterManager.h"
#import "KLAccoutEditController.h"     //个人资料编辑
#import "KLMyPetListController.h"      //宠物资料
#import "KLAddressListController.h"    //地址列表
#import "KLChangePasswordController.h" //修改密码
@interface KLSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KLTableFooterView *footerView;
@end

@implementation KLSettingViewController
- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"设置"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar navBarBottomLineHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

//***  退出登录  **/
- (void)signOutChick:(UIButton *)sender {
    
    KLLoginRegisterManager *vc =[[KLLoginRegisterManager alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



#pragma mark - lazy UI
- (KLTableFooterView *)footerView {
    
    if (!_footerView){
        _footerView = [[KLTableFooterView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, AdaptedHeight(80)+34)];
        _footerView.line.hidden = NO;
        [_footerView.footerBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_footerView.footerBtn addTarget:self action:@selector(signOutChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight) style:UITableViewStylePlain];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[self footerView];
        _tableView.mCustomClass([UITableViewCell class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =kCellIdentifier(UITableViewCell);
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = RGBSigle(51);
    cell.textLabel.font =kFont_15;
    cell.textLabel.text =@[@"个人资料",@"宠物资料",@"收货地址",@"修改登录密码"][indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(56);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) { //个人资料
        KLAccoutEditController *vc =[[KLAccoutEditController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){ //宠物资料
        KLMyPetListController *vc =[[KLMyPetListController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){ //收货地址
        KLAddressListController *vc =[[KLAddressListController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){ //账号与安全
        KLChangePasswordController *vc =[[KLChangePasswordController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
        
//        KLAccountManagerController *vc =[[KLAccountManagerController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else if (indexPath.row == 4){ //自定义分享语
//        KLShareEditController *vc =[[KLShareEditController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }

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
