//
//  KLMyDistributionProAssistantVC.m
//  mwstreet
//
//  Created by 科pro on 2019/2/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyDistributionProAssistantVC.h"
#import "KLMyDistributionAssistantCell.h"
@interface KLMyDistributionProAssistantVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation KLMyDistributionProAssistantVC

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"推广小助手"];
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
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLMyDistributionAssistantCell class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    KLMyDistributionAssistantCell *cell = kCellIdentifier(KLMyDistributionAssistantCell);
   
    cell.cellTextBlock = ^(NSString * _Nonnull text, NSInteger tag) {
       
        KLLog(@"-textField---%@----%ld",text,tag);
    };
    cell.cellBtnBlock = ^(UIButton * _Nonnull sender) {
      
        KLLog(@"--btn--%@----%ld",sender.titleLabel.text,sender.tag);
    };
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(260);
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
