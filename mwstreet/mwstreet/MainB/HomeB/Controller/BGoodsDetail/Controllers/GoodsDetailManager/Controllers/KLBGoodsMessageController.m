//
//  KLBGoodsMessageController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/27.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBGoodsMessageController.h"
#import "KLMallBannerCell.h"
#import "KLBGoodsDetailMsgCell.h"
#import "KLGoodsDetailAddressOrSpecCell.h"
#import "KLGoodsDetailSecurityCell.h"
#import "KLGoodsDetailBottomView.h"

#import "KLAddView.h" // 规格弹窗
@interface KLBGoodsMessageController ()<
UITableViewDelegate,
UITableViewDataSource,
SDCycleScrollViewDelegate,
KLGoodsDetailBottomViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * goodsBannerImgArray;
//***  底部view  **/
@property (nonatomic, strong) KLGoodsDetailBottomView *bottemView;
@property (nonatomic, strong) KLAddView * addCartView;

//***  选中规格  **/
@property (nonatomic, strong) NSString * specText;
@end

@implementation KLBGoodsMessageController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    [self bottemView];
    [self addCartView];
}
//***  弹出规格选择  **/
- (void)popUpSpecChangeAnimationMethod {
    [UIView animateWithDuration:0.2 animations:^{
        [self.addCartView setFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    }];
}


- (KLAddView *)addCartView {
    if (!_addCartView){
        _addCartView = [[KLAddView alloc]initWithGoodsid:@""];
        [_addCartView setFrame:CGRectMake(0, MainHeight, MainWidth, MainHeight)];
        [self.view addSubview:_addCartView];
        @weakify(self)
        _addCartView.disBtnClick = ^{
            @strongify(self)
            [UIView animateWithDuration:0.2 animations:^{
                [self.addCartView setFrame:CGRectMake(0, MainHeight, MainWidth, MainHeight)];
            }];
        };
        _addCartView.specChangeBlock = ^(NSString * _Nonnull text) {
           @strongify(self)
            
            NSIndexPath * indexPath =[NSIndexPath indexPathForRow:2 inSection:0];
            KLGoodsDetailAddressOrSpecCell * cell =[self.tableView cellForRowAtIndexPath:indexPath];
            self.specText = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            cell.specText = [NSString isBlankString:self.specText] ? @"请选择规格" : self.specText;
            
        };
    }
    return _addCartView;
}



//***  底部view  **/
- (KLGoodsDetailBottomView *)bottemView {
    if (!_bottemView){
        _bottemView = [[KLGoodsDetailBottomView alloc]init];
        _bottemView.delegate = self;
        [_bottemView.addShopCarBtn setTitle:@"加入进货单" forState:UIControlStateNormal];
        [_bottemView.placeOrderBtn setTitle:@"立即下单" forState:UIControlStateNormal];
        [self.view addSubview:_bottemView];
        [_bottemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset = 0;
            make.top.mas_equalTo(self.tableView.mas_bottom);
            make.height.offset = TabbarHeight;
        }];
    }
    return _bottemView;
}

- (void)didActionBtnChick:(UIButton *)sender {
    
    if ([NSString isBlankString:self.specText]) {
        [self popUpSpecChangeAnimationMethod];
    }else{
        if (sender.tag ==202) {//加入进货单
            
            KLLog(@"---加入进货单---");
            
        }else{                 // 立即下单
            
            KLLog(@"---立即下单---");
            
        }
    }
}


- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight - TabbarHeight;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, h) style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.mCustomClass([KLMallBannerCell class]);
        _tableView.mCustomClass([KLBGoodsDetailMsgCell class]);
        _tableView.mCustomClass([KLGoodsDetailAddressOrSpecCell class]);
        _tableView.mCustomClass([KLGoodsDetailSecurityCell class]);
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        KLMallBannerCell * cell = kCellIdentifier(KLMallBannerCell);
        cell.carouselView.imageURLStringsGroup = self.goodsBannerImgArray;
        cell.carouselView.delegate =self;
        return cell;
        
    }else if(indexPath.row == 1){
        
        KLBGoodsDetailMsgCell * cell = kCellIdentifier(KLBGoodsDetailMsgCell);
        cell.goodsTitle = @"快宠泰迪幼犬狗粮贵宾吉娃娃中小型犬5kg~10kg美毛去泪腺通用型10~20斤";
        cell.goodsPriceLab.text = @"￥65.8~128.9/袋";
        cell.goodsDecLab.text   = @"成交50袋";
        return cell;
        
    }else if(indexPath.row == 2){
        
        KLGoodsDetailAddressOrSpecCell * cell =kCellIdentifier(KLGoodsDetailAddressOrSpecCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = @"已选:";
        cell.textLab.text  = @"请选择规格";
        return cell;
        
    }else{
        
        KLGoodsDetailSecurityCell * cell =kCellIdentifier(KLGoodsDetailSecurityCell);
        cell.securityBtnArray =@[@"正品保障",@"48小时内发货",@"7天无忧退换"];
        cell.spacLab.hidden = YES;
        return cell;
       
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return AdaptedHeight(375);
        
    }else if (indexPath.row == 1){
        
         return AdaptedHeight(104);
        
    }else {
        
         return AdaptedHeight(55);
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row ==2) {
        [self popUpSpecChangeAnimationMethod];
    }
    
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


#pragma mark - 轮播图点击事件delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    [self lookImageArray:self.goodsBannerImgArray index:index];
}
#pragma mark - 评价列表 图片点击查看
- (void)didBtnChick:(UIButton *)sender {
    [self lookImageArray:self.goodsBannerImgArray index:sender.tag-120];
}

//*** 将图片数组加入图片浏览器  **/
- (void)lookImageArray:(NSMutableArray *)imageArray index:(NSInteger)index{
    NSMutableArray *items = @[].mutableCopy;
    for (int i = 0; i < imageArray.count; i++) {
        NSString *urlStr = [imageArray[i] stringByReplacingOccurrencesOfString:@"bmiddle" withString:@"large"];
        //KSPhotoItem *item = [KSPhotoItem itemWithSourceView:nil imageUrl:[NSURL URLWithString:urlStr]];
        KSPhotoItem *item =[KSPhotoItem itemWithSourceView:nil image:[UIImage imageNamed:urlStr]];
        [items addObject:item];
    }
    [self ks_photoBrowser:items index:index];
}
#pragma mark - 加载图片浏览器
- (void)ks_photoBrowser:(NSMutableArray *)itemsArray index:(NSInteger)index{
    
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:itemsArray selectedIndex:index];
    browser.dismissalStyle = KSPhotoBrowserInteractiveDismissalStyleRotation;
    browser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlur;
    browser.loadingStyle = KSPhotoBrowserImageLoadingStyleIndeterminate;
    browser.pageindicatorStyle = KSPhotoBrowserPageIndicatorStyleDot;
    browser.bounces = YES;
    [browser showFromViewController:self];
}

// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //分割线两端封头
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        [cell setSeparatorInset:UIEdgeInsetsZero];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        [cell setLayoutMargins:UIEdgeInsetsZero];
    
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
