//
//  KLMyPetListController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyPetListController.h"
#import "KLMyPetListCell.h"
#import "KLTableFooterView.h" //表尾按钮
#import "KLMyPetViewController.h"

@interface KLMyPetListController ()<
UITableViewDelegate,
UITableViewDataSource,
KLMyPetListCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KLTableFooterView * footerView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation KLMyPetListController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"我的爱宠"];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
}



//***  导航编辑按钮响应  **/
- (void)right_button_event:(UIButton *)sender {
    
    sender.selected =!sender.selected;
    
    NSString * rightTitle = sender.selected ? @"取消" : @"编辑";
    [sender setTitle:rightTitle forState:UIControlStateNormal];

    [self.tableView setEditing:sender.selected];
}

//***  cell 编辑按钮响应  **/
- (void)didEidtBtnActionChick:(KLMyPetListCell *)cell {
    
    KLMyPetViewController *vc =[[KLMyPetViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
    

//***  添加爱宠 按钮响应  **/
- (void)addPetBtnChick:(UIButton *)sender {
    KLLog(@"添加爱宠");
    KLMyPetViewController *vc =[[KLMyPetViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark ------ lazy UI
//***  导航右边按钮  **/
- (UIButton *)set_rightButton{
    UIButton  *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGBSigle(51) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = kFont_15;
    //解决偏移问题:
    //解决响应事件的触发范围:
    return rightBtn;
}


- (KLTableFooterView *)footerView {
 
    if (!_footerView){
        _footerView = [[KLTableFooterView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, AdaptedHeight(80)+34)];
        [_footerView.footerBtn setTitle:@"添加爱宠" forState:UIControlStateNormal];
        [_footerView.footerBtn addTarget:self action:@selector(addPetBtnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStylePlain];
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
//        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView = [self footerView];
        _tableView.mCustomClass([KLMyPetListCell class]);
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KLMyPetListCell *cell =kCellIdentifier(KLMyPetListCell);
    cell.delegate =self;
    cell.imgView.image =[UIImage imageNamed:@"tx-h"];
    cell.nameLab.text =@"名称：端茶倒水";
    cell.classifyLab.text =@"类型：鼎折餗覆是不舍得";
    cell.ageLab.text =@"年龄：3岁";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(80);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return AdaptedHeight(5);
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex:[indexPath section]];
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]                     withRowAnimation:UITableViewRowAnimationAutomatic]; //删除对应数据的cell
    }
}
//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *footerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerCell"];
    if (!footerView) {
        footerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"footerCell"];
    }
    footerView.contentView.backgroundColor =SpacColor;
    return footerView;
}

//***  数据字典初始化  **/
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    }
    return _dataArray;
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
