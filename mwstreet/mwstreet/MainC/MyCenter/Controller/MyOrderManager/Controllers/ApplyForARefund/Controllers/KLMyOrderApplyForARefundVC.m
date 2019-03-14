//
//  KLMyOrderApplyForARefundVC.m
//  mwstreet
//
//  Created by 科pro on 2019/2/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyOrderApplyForARefundVC.h"
#import "KLOrderApplyForARefundCell.h"
#import "KLAccoutEditCell.h"
#import "KLMyOrderDetailStatusCell.h"
#import "UITextView+KLPlaceholder.h"
#import "KLEditPhotoView.h"

@interface KLMyOrderApplyForARefundVC ()<UITableViewDelegate,UITableViewDataSource,KLEditPhotoViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) KLEditPhotoView * editPhotoView;
@property (nonatomic, strong) UIButton * submitBtn;
@end

@implementation KLMyOrderApplyForARefundVC

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"申请退款"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.tableView];
    [self submitBtn];
}


#pragma mark -   lazy  UI
- (UIButton *)submitBtn {
    
    if (!_submitBtn){
        _submitBtn = [UIButton createBtnTitle:@"提交"
                                  titleColor:RGBSigle(255)
                                        font:kFont_14
                                   imageName:@""
                              backgrounColor:MainColor
                                      action:^(UIButton * _Nonnull button) {
                                          KLLog(@"提交");
                                      }];
        [self.view addSubview:_submitBtn];
        [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset = 0;
            make.bottom.offset     = -TabbarSafeBottomMargin;
            make.height.offset     = AdaptedHeight(49);
        }];
    }
    return _submitBtn;
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight-AdaptedHeight(49)- TabbarSafeBottomMargin;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
//        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor =[UIColor whiteColor];
        KLEditPhotoView *editPhotoView = [KLEditPhotoView editPhotoView];
        editPhotoView.pageIndex = 9;
        editPhotoView.titleStr  = @"上传凭证";
        editPhotoView.frame = CGRectMake(0, 0, MainWidth, AdaptedHeight(300));
        editPhotoView.delegate = self;
        self.editPhotoView = editPhotoView;
        _tableView.tableFooterView = self.editPhotoView;
        _tableView.mCustomClass([KLOrderApplyForARefundCell class]);
        _tableView.mCustomClass([KLAccoutSexBothdayEditCell class]);
        _tableView.mCustomClass([KLAccoutRemarksEditCell class]);
        _tableView.mCustomClass([KLMyOrderDetailMsgCell class]);

    }
    return _tableView;
}
#pragma mark - 上传图片
- (void)editPhotoViewToOpenAblum:(KLEditPhotoView *)editView {
    
    //edit:照片需要裁剪:传YES,不需要裁剪传NO(默认NO)
    [self showCanEdit:YES photo:^(UIImage *photo) {
        
        [editView addOneImage:photo];
        
    }];
}
- (void)fetchPhotosNumber:(NSInteger)picCount editView:(KLEditPhotoView *)editView{
    NSLog(@"===%ld===\n==%@",picCount,[editView fetchPhotos]);
}
- (void)previewPhotosBtn:(UIButton *)sender img:(UIImage *)img editView:(KLEditPhotoView *)editView block:(PreviewBlock)photosBlock{
    
    NSMutableArray * array = [NSMutableArray arrayWithArray:[editView fetchPhotos]];
    [self lookImageArray:array index:sender.tag-46];
}

#pragma mark - 加载图片浏览器
//*** 将图片数组加入图片浏览器  **/
- (void)lookImageArray:(NSMutableArray *)imageArray index:(NSInteger)index{
    NSMutableArray *items = @[].mutableCopy;
    
    for (int i = 0; i < imageArray.count; i++) {

        KSPhotoItem *item =[KSPhotoItem itemWithSourceView:nil image:imageArray[i]];
        [items addObject:item];
    }
    [self ks_photoBrowser:items index:index];
}
//*** 加载图片浏览器  **/
- (void)ks_photoBrowser:(NSMutableArray *)itemsArray index:(NSInteger)index{
    
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:itemsArray selectedIndex:index];
    browser.dismissalStyle = KSPhotoBrowserInteractiveDismissalStyleRotation;
    browser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlur;
    browser.loadingStyle = KSPhotoBrowserImageLoadingStyleIndeterminate;
    browser.pageindicatorStyle = KSPhotoBrowserPageIndicatorStyleDot;
    browser.bounces = YES;
    [browser showFromViewController:self];
}


#pragma mark - tableView delegate && datascoure
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        KLOrderApplyForARefundCell *cell = kCellIdentifier(KLOrderApplyForARefundCell);
        cell.goodsName =@"是地方是那地方是迭代法v 动车上档次是地方是那地方是迭代法v 动车上档次";
        cell.specLab.text =@"规格：5kg";
        return cell;
        
    }else if (indexPath.section == 1 && indexPath.row == 0){
        
        KLAccoutSexBothdayEditCell *cell =kCellIdentifier(KLAccoutSexBothdayEditCell);
        cell.titleLab.text = @"退款原因";
        return cell;
        
    }else if (indexPath.section == 1 && indexPath.row == 1){
        
        KLMyOrderDetailMsgCell *cell = kCellIdentifier(KLMyOrderDetailMsgCell);
        cell.titleLab.text = @"退款金额";
        cell.msgLab.text = @"￥65.8";
        cell.msgLab.textColor = RedColor;
        return cell;
        
    }else{
        
        KLAccoutRemarksEditCell * cell =kCellIdentifier(KLAccoutRemarksEditCell);
        cell.titleLab.text =@"退款说明";
        cell.remarksView.maxInputLength = 1000;
        cell.remarksView.placeholder =@"退款说明(选填)";
        cell.remarksView.placeholderAttributes = @{NSFontAttributeName:AdaptedSYSFontSize(14),NSForegroundColorAttributeName:RGBSigle(208)};
        return cell;
        
    }

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0) {
        
        return AdaptedHeight(92);
        
    }else if(indexPath.section == 1 && indexPath.row == 2){
        
        return AdaptedHeight(130);
    }
    
    return AdaptedHeight(56);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 0 ? AdaptedHeight(5) : CGFLOAT_MIN;
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
    footerView.contentView.backgroundColor = SpacColor;
    return footerView;
}


// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //分割线两端封头
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        [cell setSeparatorInset:UIEdgeInsetsZero];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        [cell setLayoutMargins:UIEdgeInsetsZero];
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
