//
//  KLEvaluationDetailController.m
//  mwstreet
//
//  Created by 科pro on 2019/3/12.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLEvaluationDetailController.h"
#import "KLEvaluationDetailCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "KLEvaluationDetailBottomView.h"
#import "LayoutTextView.h"
#import "UITextView+KLPlaceholder.h"

@interface KLEvaluationDetailController ()<
UITableViewDelegate,
UITableViewDataSource,
SDCycleScrollViewDelegate>
@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) KLEvaluationDetailBottomView * bottomView;
@property (nonatomic, strong) LayoutTextView *layoutTextView;
@end

@implementation KLEvaluationDetailController

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"评价详情"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self bottomView];
    [self layoutTextView];
}

- (LayoutTextView *)layoutTextView {
    if (!_layoutTextView){
        CGFloat layoutTextHeight = AdaptedHeight(60);
        _layoutTextView = [[LayoutTextView alloc]initWithFrame:CGRectMake(0, MainHeight - layoutTextHeight, MainWidth, layoutTextHeight)];
        [self.view addSubview:_layoutTextView];
        _layoutTextView.textView.placeholder =@"请输入您的看法..";
        _layoutTextView.textView.placeholderAttributes = @{NSFontAttributeName:AdaptedSYSFontSize(14),NSForegroundColorAttributeName:RGBSigle(208)};
        [_layoutTextView setSendBlock:^(UITextView *textView) {

            NSLog(@"->>>> %@",textView.text);
        }];
    }
    return _layoutTextView;
}



- (KLEvaluationDetailBottomView *)bottomView {
    if (!_bottomView){
        _bottomView = [[KLEvaluationDetailBottomView alloc]init];
        @weakify(self)
        _bottomView.msgBlock = ^(UIButton * _Nonnull sender) {
            @strongify(self)
            [self.layoutTextView.textView becomeFirstResponder];
            KLLog(@"---1111---%@",sender.titleLabel.text);
                       
        };
        _bottomView.praiseBlock = ^(UIButton * _Nonnull sender) {
          
            KLLog(@"---2222--%@",sender.titleLabel.text);

        };
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset = 0;
            make.bottom.offset = -TabbarSafeBottomMargin;
            make.height.offset =AdaptedHeight(49);
        }];
    }
    return _bottomView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight - AdaptedHeight(49) - TabbarSafeBottomMargin;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([KLEvaluationDetailCell class]);
        _tableView.mCustomClass([KLEvaluationDetailBannerCell class]);
        _tableView.mCustomClass([KLEvaluationDetailGoodsCell class]);
        _tableView.mCustomClass([UITableViewCell class]);
        _tableView.mCustomClass([KLEvaluationDetailListCell class]);
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 2;
        
    }else if (section ==1){
        
        return 1;
    }
    
    return 3 + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        KLEvaluationDetailCell *cell = kCellIdentifier(KLEvaluationDetailCell);
        [cell.starView setScore:0.5 withAnimation:YES];
        cell.contentStr = @"本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~";
        return cell;
        
    }else if(indexPath.section == 0 && indexPath.row == 1){
        
        KLEvaluationDetailBannerCell * cell = kCellIdentifier(KLEvaluationDetailBannerCell);
        cell.carouselView.imageURLStringsGroup = self.goodsBannerImgArray;
        cell.carouselView.delegate =self;
        
        return cell;
        
    }else if(indexPath.section == 1 && indexPath.row == 0){
        
        KLEvaluationDetailGoodsCell *cell = kCellIdentifier(KLEvaluationDetailGoodsCell);
        cell.goodName = @"新款嘟贝贝 全拆洗狗床蓝色 S 70*58*38CM";
        cell.priceLab.text =@"￥138.00";
        return cell;
        
    }else if(indexPath.section == 2 && indexPath.row == 0){
        
        UITableViewCell * cell = kCellIdentifier(UITableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"全部评论（3）";
        cell.textLabel.textColor = RGBSigle(51);
        cell.textLabel.mj_x =AdaptedWidth(10);
        cell.textLabel.font =kFont_14;
        return cell;
        
    }else{
        
        KLEvaluationDetailListCell * cell = kCellIdentifier(KLEvaluationDetailListCell);
        cell.contentStr = @"本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~";
        return cell;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        CGFloat height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([KLEvaluationDetailCell class]) cacheByIndexPath:indexPath configuration:^(KLEvaluationDetailCell * cell) {
            cell.contentStr = @"本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~";
        }];
        return height;
        
    }else if (indexPath.section == 0 && indexPath.row == 1){
        
        return AdaptedHeight(350);
        
    }else if(indexPath.section == 1 && indexPath.row == 0){
        
       return AdaptedHeight(115);
        
    }else if(indexPath.section == 2 && indexPath.row == 0){
     
        return AdaptedHeight(40);
        
    }else {
        
        CGFloat height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([KLEvaluationDetailListCell class]) cacheByIndexPath:indexPath configuration:^(KLEvaluationDetailListCell * cell) {
            cell.contentStr = @"本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~本是抱着试试的心态买的，狗狗挑食，没想带这个狗狗非常喜欢而且不油腻，色泽好~";
        }];
        return height;
    }
    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return section == 1 ? AdaptedHeight(5) : CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   
    return section == 1 ? AdaptedHeight(5) : CGFLOAT_MIN;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
    if (!headerView) {
        headerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerCell"];
    }
    headerView.contentView.backgroundColor = SpacColor;
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



#pragma mark - 数据源

- (NSMutableArray *)goodsBannerImgArray {
    if (!_goodsBannerImgArray){
        _goodsBannerImgArray = [NSMutableArray arrayWithObjects:@"1_sdgvxc",@"2_sdgvxc",@"3_sdgvxc", nil];
    }
    return _goodsBannerImgArray;
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
