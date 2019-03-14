//
//  KLAccoutEditController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/20.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLAccoutEditController.h"
#import "KLAccoutEditCell.h"
#import "KLTableFooterView.h"

@interface KLAccoutEditController ()<
UITableViewDelegate,
UITableViewDataSource,
UITextViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KLTableFooterView *footerView;

@property (nonatomic , strong)NSMutableArray *arrayDataSouce;
@property (nonatomic, strong) NSString * nickName;//昵称
@end

@implementation KLAccoutEditController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"个人资料"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    self.nickName = [NSString isBlankString:@""]?@"":@"--";
    [self.arrayDataSouce addObject:self.nickName];
}

//***  保存编辑  **/
- (void)saveChick:(UIButton *)sender {
    KLLog(@"保存");
}

#pragma mark ------ 获取备注
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>100) {
        [EasyTextView showErrorText:@"最多可输入100个字"];
    }
}



//***  获取昵称  **/
- (void)textFieldEditChanged:(UITextField *)textField {
    // 数据源赋值
    self.nickName = textField.text;
    NSIndexPath *indexPath = textField.indexPath;
    [self.arrayDataSouce replaceObjectAtIndex:indexPath.row-1 withObject:textField.text];
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
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.mCustomClass([KLAccoutEditCell class]);
        _tableView.mCustomClass([KLAccoutNickNameEditCell class]);
        _tableView.mCustomClass([KLAccoutSexBothdayEditCell class]);
        _tableView.mCustomClass([KLAccoutRemarksEditCell class]);

    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        KLAccoutEditCell *cell =kCellIdentifier(KLAccoutEditCell);
        cell.titleLab.text =@"头像";
        return cell;
    }else if (indexPath.row == 1){
        KLAccoutNickNameEditCell *cell =kCellIdentifier(KLAccoutNickNameEditCell);
        cell.titleLab.text =@"昵称";
        [cell.nickField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        // 核心方法
        if (self.arrayDataSouce.count>0) {//避免textField输入字符随cell复用改变
            [cell setDataString:self.arrayDataSouce[indexPath.row-1] andIndexPath:indexPath];
        }
        return cell;
        
    }else if (indexPath.row == 2 || indexPath.row ==3){
        KLAccoutSexBothdayEditCell *cell =kCellIdentifier(KLAccoutSexBothdayEditCell);
        cell.titleLab.text =@[@"性别",@"生日"][indexPath.row -2];
        return cell;
    }else {
        KLAccoutRemarksEditCell * cell =kCellIdentifier(KLAccoutRemarksEditCell);
        cell.titleLab.text =@"简介";
//        cell.remarksView.text =[NSString isBlankString:self.dataModel.descript]?nil:self.dataModel.descript;
        cell.remarksView.delegate =self;
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row == 4) {
        return AdaptedHeight(130);
    }
    
    return AdaptedHeight(56);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
//        @weakify(self)
        //edit:照片需要裁剪:传YES,不需要裁剪传NO(默认NO)
        [self showCanEdit:YES photo:^(UIImage *photo) {
//         @strongify(self)
            [EasyLoadingView showLoadingText:@"正在上传图像..."];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [EasyLoadingView hidenLoading];
            });
//            [RequestHttp updataImg:photo Complete:^(NSDictionary *dic) {
//                AccoutInfoModel *model =[AccoutInfoModel mj_objectWithKeyValues:dic];
//
//                if (model.status ==1) {
//                    weakSelf.dataModel.img = model.data.path;
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
            KLAccoutEditCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.accoutImg.image = photo;
            
//                    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//                }
//                if (![NSString isBlankString:model.msg]) {
//                    [EasyShowTextView showText:model.msg];
//                }
//            } unfinished:^(NSError *error) {
//
//            }];
        }];
    }else if (indexPath.row == 2) {
        
        KLAccoutSexBothdayEditCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [ZJNormalPickerView zj_showStringPickerWithTitle:@"请选择性别"
                                              dataSource:@[@"男",@"女",@"未知"]
                                         defaultSelValue:@"男"
                                            isAutoSelect:NO
                                               rowHeight:AdaptedHeight(35)
                                               lineColor:MainColor
                                    confirmBtnTitleColor:MainColor
                                     cancelBtnTitleColor:TextColor
                                     selecteRowTextColor:TitleColor
                                        selectRowBGColor:RGBSigle(255)
                                            leftBtnTitle:@"取消"
                                           rightBtnTitle:@"确定"
                                             resultBlock:^(id selectValue, NSInteger index) {
                                                 cell.textLab.text = selectValue;
                                                 NSLog(@"index---%ld",index);
                                             } cancelBlock:^{
                                                 
                                             }];
        
    }else if (indexPath.row ==3){
        KLAccoutSexBothdayEditCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [ZJDatePickerView zj_showDatePickerWithTitle:@"请选择生日"
                                            dateType:ZJDatePickerModeYMD
                                     defaultSelValue:nil
                                             minDate:[NSDate getDate:-200]
                                             maxDate:[NSDate getDate:9]
                                        isAutoSelect:NO
                                           lineColor:MainColor
                                           rowHeight:AdaptedHeight(35)
                                   leftBtnTitleColor:TextColor
                                  rightBtnTitleColor:MainColor
                                 selecteRowTextColor:TitleColor
                                    selectRowBGColor:RGBSigle(255)
                                         resultBlock:^(NSString *selectValue) {
                                             cell.textLab.text = selectValue;
                                         } cancelBlock:^{
                                             
                                         }];
        
    }
}

// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //分割线两端封头
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        [cell setSeparatorInset:UIEdgeInsetsZero];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        [cell setLayoutMargins:UIEdgeInsetsZero];
}





- (NSMutableArray *)arrayDataSouce{
    if (!_arrayDataSouce) {
        _arrayDataSouce = [NSMutableArray array]; // 注意：初始化时，一定要注意占位，否则第一次去的时候为nil，奔溃
    }
    return _arrayDataSouce;
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return CGFLOAT_MIN;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return CGFLOAT_MIN;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    UIView * headerView = [UIView new];
//    return headerView;
//}
//
////***  设置区尾 **/
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView * footerView = [UIView new];
//    return footerView;
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
