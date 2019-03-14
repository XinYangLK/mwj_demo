//
//  KLStoreDetailViewController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/29.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreDetailViewController.h"

#import "KLStoreDetailNavigationView.h"    //门店详情导航view
#import "KLStoreDetailHeaderView.h"        //区头

#import "KLStoreBannerCell.h"              //门店banner cell
#import "KLStoreIntroCell.h"               //门店简介 cell
#import "KLStoreAddressCell.h"             //地址 cell
#import "KLStoreServiceCell.h"             //特惠服务cell
#import "KLStoreSecvierMoreCell.h"         //更多特惠服务cell
#import "KLStorePetTableViewCell.h"        //在售宠物cell
#import "KLStoreGoodsCell.h"               //在售商品cell
#import "KLStoreClinicMsgCell.h"           //诊疗信息cell
#import "KLStoreBusinessinfoCell.h"        //营业信息cell

//#import "KLStoreDetailGoodsManager.h"      //店铺商品列表vc
#import "KLStoreGoodsListController.h"     //店铺更多商品列表

#import "KLStoreServiceDetailController.h" //服务详情vc
#import "KLStoreGoodsSpecController.h"     //规格选择vc
#import "KLStoreServerOrderController.h"   //门店服务订单页vc
#import "KLGoodsDetailController.h"        //商品详情vc

#import "UITableView+FDTemplateLayoutCell.h" //cell 自动行高适配三方扩展
#import "XWDrawerAnimator.h"                 //导航push动画
#import "UIViewController+XWTransition.h"

#import "KLStorePetDetailController.h"//宠物详情

#import "UIScrollView+KLRefresh.h"

@interface KLStoreDetailViewController ()<
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate,
UINavigationControllerDelegate,
UIGestureRecognizerDelegate,
KLStoreDetailNavigationViewDelegate,
KLMJRefreshDelegate
>

@property (nonatomic, strong) KLStoreDetailNavigationView *navigationView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *imgArray;
@end

@implementation KLStoreDetailViewController

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //***  判断进入此界面隐藏导航栏  **/
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"门店详情"];
}
//***  导航返回按钮响应 **/
- (void)popViewControllerBtnChick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configerUI];

}



#pragma mark - 规格选择弹出层
- (void)specChangeAlertVC {
    //***  规格选择弹出层  **/
    KLStoreGoodsSpecController *vc =[[KLStoreGoodsSpecController alloc]init];
    vc.fromBuyNow = YES;

    //***  选择规格回调  **/
    @weakify(self)
    vc.attributeInfoBlock = ^(NSDictionary * _Nonnull dict) {
        @strongify(self)
        
        KLLog(@"======- %@",dict);
         //***  商品订单页 **/
        KLStoreServerOrderController *vc =[[KLStoreServerOrderController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    [self pushSpecVC:vc];
}


#pragma mark - 宠物类型选择
- (void)didSelectPetTypeChick:(UIButton *)sender withCell:(KLStorePetTableViewCell *)cell {
  
    cell.markCount = 0;
    //***  移除之前数据，加载新类别数据  **/
    [self.imgArray removeAllObjects];
    //***  移除之前加载的按钮，避免重叠加载  **/
    for (UIView *views in cell.scrollView.subviews) {
        if ([views isKindOfClass:[UIButton class]]) {
            [views removeFromSuperview];
        }
    }
    switch (sender.tag) {
        case 200:
            [self.imgArray addObjectsFromArray:@[@"gipjd_1",@"gipjd_1",@"gipjd_1",@"gipjd_1",@"gipjd_1",@"gipjd_1"]];
            
            break;
        case 201:
            [self.imgArray addObjectsFromArray:@[@"ad_1",@"ad_1",@"ad_1",@"ad_1",@"ad_1",@"ad_1"]];
            
            break;
        case 202:
            [self.imgArray addObjectsFromArray:@[@"bannnnnrtyyh",@"bannnnnrtyyh",@"bannnnnrtyyh",@"bannnnnrtyyh",@"bannnnnrtyyh",@"bannnnnrtyyh"]];

            
            break;
        case 203:
            [self.imgArray addObjectsFromArray:@[@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc"]];
            
            break;
        default:
            break;
    }
    cell.itemsArray = self.imgArray;
    
}


#pragma mark - 商品类型选择
- (void)didSelectGoodsTypeChick:(UIButton *)sender withCell:(KLStoreGoodsCell *)cell {

    cell.markCount = 0;
    //***  移除之前数据，加载新类别数据  **/
    [self.imgArray removeAllObjects];
    //***  移除之前加载的按钮，避免重叠加载  **/
    for (UIView *views in cell.scrollView.subviews) {
        if ([views isKindOfClass:[UIButton class]]) {
            [views removeFromSuperview];
        }
    }
    switch (sender.tag) {
        case 300:
            [self.imgArray addObjectsFromArray:@[@"goods_1",@"goods_2",@"goods_3",@"goods_4",@"goods_4",@"goods_5"]];
            
            break;
        case 301:
            [self.imgArray addObjectsFromArray:@[@"ad_1",@"ad_1",@"ad_1",@"ad_1",@"ad_1",@"ad_1"]];
            
            break;
        case 302:
            [self.imgArray addObjectsFromArray:@[@"pic_10",@"pic_11",@"pic_12",@"pic_13",@"pic_14",@"pic_15",@"pic_16",@"pic_17"]];
            
            break;
        case 303:
            [self.imgArray addObjectsFromArray:@[@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc",@"3_sdgvxc"]];
            
            break;
        default:
            break;
    }
    cell.itemsArray = self.imgArray;
    
}

- (NSMutableArray *)imgArray {
    if (!_imgArray){
        _imgArray = [NSMutableArray arrayWithObjects:@"gipjd_1",@"gipjd_1",@"gipjd_1",@"gipjd_1",@"gipjd_1",@"gipjd_1", nil];
    }
    return _imgArray;
}


#pragma mark - lazy UI
- (void)configerUI {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset = 0;
        make.height.offset = StatusBarAndNavigationBarHeight;
    }];
    
     [self.tableView addHeaderWithHeaderClass:@"KLRefreshHeader" beginRefresh:NO delegate:self animation:YES];
}


#pragma mark ------ 下拉刷新
- (void)onRefreshing:(id)control {
    
    [self requestNetWorkingWithPageNum:1 isHeader:YES];
}

- (void)onLoadingMoreData:(id)control pageNum:(NSNumber *)pageNum {
    [self requestNetWorkingWithPageNum:pageNum.integerValue isHeader:NO];
}

- (void)requestNetWorkingWithPageNum:(NSInteger)pageNum isHeader:(BOOL)isHeader {
    klWeakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView endHeaderRefresh];
    });
}



//***  伪导航  **/
- (KLStoreDetailNavigationView *)navigationView {
    if (!_navigationView){
        _navigationView = [[KLStoreDetailNavigationView alloc]init];
        _navigationView.delegate = self;
        _navigationView.titleLab.text = @"派多格宠物生活馆";
    }
    return _navigationView;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight) style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.mCustomClass([KLStoreBannerCell class]);
        _tableView.mCustomClass([KLStoreIntroCell class]);
        _tableView.mCustomClass([KLStoreAddressCell class]);
        _tableView.mCustomClass([KLStoreServiceCell class]);
        _tableView.mCustomClass([KLStorePetTableViewCell class]);
        _tableView.mCustomClass([KLStoreGoodsCell class]);
        _tableView.mCustomClass([KLStoreClinicMsgCell class]);
        _tableView.mCustomClass([KLStoreBusinessinfoCell class]);
        _tableView.mCustomClass([KLStoreSecvierMoreCell class]);

    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3;
    }else if (section ==1){
        return 4;
    }else{
        return 1;
    }
    
//    }else if (section ==2 || section ==3){
//        return 1;
//    }else if (section ==4 ){
//        return 1;
//    }else{
//        return 1;
//    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            KLStoreBannerCell * cell = kCellIdentifier(KLStoreBannerCell);
            cell.imgArray = @[@"banner_2",@"banner",@"dianmian"];
            return cell;
           
        }else if (indexPath.row == 1){
            
            KLStoreIntroCell *cell = kCellIdentifier(KLStoreIntroCell);
            cell.items = @[@"美容",@"寄养",@"造型",@"疫苗",@"宠物售卖",@"驱虫",@"洗澡",@"绝育",@"住院服务"];
            return cell;
           
        }else {
            
            KLStoreAddressCell *cell =kCellIdentifier(KLStoreAddressCell);
            return cell;
            
        }
    }else if (indexPath.section == 1){
      
        
        if (indexPath.row < 3) {
            
            KLStoreServiceCell  *cell =kCellIdentifier(KLStoreServiceCell);
            @weakify(self)
            cell.payBlock = ^(UIButton * _Nonnull sender) {
                @strongify(self)
                //***  服务购买 规格选择弹出层  **/
                [self specChangeAlertVC];
            };
            return cell;
            
        }else{
            
            KLStoreSecvierMoreCell *cell =kCellIdentifier(KLStoreSecvierMoreCell);
            cell.textLabel.text =@"更多服务";
            cell.textLabel.textColor =TitleColor;
            cell.textLabel.font = kFont_14;
            cell.textLabel.textAlignment =NSTextAlignmentCenter;
            return cell;
        }
        
    }else if (indexPath.section == 2){
        
        KLStorePetTableViewCell  *cell =kCellIdentifier(KLStorePetTableViewCell);
        cell.titleArray =@[@"狗狗",@"猫咪",@"小宠",@"水族"];
        @weakify(self)
        cell.btnChick = ^(UIButton * _Nonnull button, KLStorePetTableViewCell *  _Nonnull cell) {
            @strongify(self)
            [self didSelectPetTypeChick:button withCell:cell];
        };
        cell.goodsChick = ^(UIButton * _Nonnull button) {
            @strongify(self)
            KLStorePetDetailController *vc =[[KLStorePetDetailController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        cell.itemsArray =self.imgArray;
        return cell;
        
    
    }else if (indexPath.section == 3){
       
        KLStoreGoodsCell  *cell =kCellIdentifier(KLStoreGoodsCell);
        cell.titleArray =@[@"狗狗",@"猫咪",@"小宠",@"水族",@"狗狗",@"猫咪",@"小宠",@"水族"];
         @weakify(self)
        cell.btnChick = ^(UIButton * _Nonnull button, KLStoreGoodsCell * _Nonnull cell) {
             @strongify(self)
            [self didSelectGoodsTypeChick:button withCell:cell];
        };
        cell.goodsChick = ^(UIButton * _Nonnull button) {
             @strongify(self)
            KLGoodsDetailController *vc =[[KLGoodsDetailController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        cell.itemsArray = self.imgArray;
        return cell;
        
        
    }else if (indexPath.section == 4){
        
        
        KLStoreClinicMsgCell  *cell =kCellIdentifier(KLStoreClinicMsgCell);
        cell.msgStr =@"诊疗动物：猫、狗、兔子、乌龟、鼠、其他 \n诊疗科室：内科、外科、心内科、骨科、肿瘤科、皮肤科、影像科、眼科、耳鼻喉科、检验科、耳鼻喉科、检验科、耳鼻喉科、检验科、耳鼻喉科、检验科、耳鼻喉科、检验科、耳鼻喉科、检验科、耳鼻喉科、检验科、耳鼻喉科、检验科、耳鼻喉科、检验科、耳鼻喉科、检验科\n诊疗资格：传染病疫苗注射、狂犬病疫苗注射";
        return cell;
        
    }else{
        
        
        KLStoreBusinessinfoCell  *cell =kCellIdentifier(KLStoreBusinessinfoCell);
        cell.msgStr = @"营业时间：周一至周日 06:00-22:00";
        return cell;
        
    }
    
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section ==1 && indexPath.row < 3) {

        KLStoreServiceDetailController *vc =[[KLStoreServiceDetailController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
             return AdaptedHeight(150) + StatusBarHeight;
            
        }else if (indexPath.row ==1){
            
            float height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([KLStoreIntroCell class]) cacheByIndexPath:indexPath configuration:^(KLStoreIntroCell * cell) {
                cell.items = @[@"美容",@"寄养",@"造型",@"疫苗",@"宠物售卖",@"驱虫",@"洗澡",@"绝育",@"住院服务"];
            }];
            return height;
            
        }else {
            return AdaptedHeight(55);
        }
    }else if(indexPath.section == 1){
        
        if (indexPath.row < 3) {
            
            return AdaptedHeight(72);
            
        }else {
            
            return AdaptedHeight(50);
        }
    
    }else if(indexPath.section ==2 || indexPath.section ==3  ){
        
         return AdaptedHeight(220);
        
    }else if(indexPath.section == 4){
        
        float height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([KLStoreClinicMsgCell class]) cacheByIndexPath:indexPath configuration:^(KLStoreClinicMsgCell * cell) {
            cell.msgStr =@"诊疗动物：猫、狗、兔子、乌龟、鼠、其他 \n诊疗科室：内科、外科、心内科、骨科、肿瘤科、皮肤科、影像科、眼科、耳鼻喉科、检验科、耳鼻喉科、检验科、耳鼻喉科、检验科、耳鼻喉科、检验科、耳鼻喉科、检验科、耳鼻喉科、检验科、耳鼻喉科、检验科、耳鼻喉科、检验科、耳鼻喉科、检验科、耳鼻喉科、检验科\n诊疗资格：传染病疫苗注射、狂犬病疫苗注射";
        }];
        return height;
        
    }else if(indexPath.section == 5){
        
        float height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([KLStoreBusinessinfoCell class]) cacheByIndexPath:indexPath configuration:^(KLStoreBusinessinfoCell * cell) {
            cell.msgStr =@" 营业时间：周一至周日 06:00-22:00";
        }];
        return height;
        
    }else{
        
        return AdaptedHeight(72);
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? CGFLOAT_MIN : AdaptedHeight(40);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return AdaptedHeight(5);
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  
    if (section == 0) {
        UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
        if (!headerView) {
            headerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerCell"];
        }
        return headerView;
    }else{
        BOOL hidden;
        if (section ==2 || section == 3) {
            hidden = NO;
        }else{
            hidden = YES;
        }
        NSArray *titleArray =@[@"特惠服务（5）",@"在售宠物",@"在售商品",@"诊疗信息",@"营业信息"];
        
        KLStoreDetailHeaderView *headerView = [KLStoreDetailHeaderView initWith:tableView title:titleArray[section - 1] moreHidden:hidden lineHidden:YES];
        headerView.section = section;
        
        klWeakSelf;
        headerView.lookMoreBlock = ^(UIButton * _Nonnull sender, NSInteger section) {
            
            KLStoreGoodsListController *vc =[[KLStoreGoodsListController alloc]init];
            vc.holderStr = section == 2 ? @"宠物":@"商品";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        return headerView;
    }
   
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *footerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerCell"];
    if (!footerView) {
        footerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"footerCell"];
    }
    return footerView;
}


#pragma mark ------ 滑动表 scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat top = scrollView.contentInset.top;
    
    CGFloat y =  scrollView.contentOffset.y;
    
    CGFloat offsetY = top + y;
    
    CGFloat progressChange = offsetY /190.00;
    
    self.navigationView.hidden = (y < 0) ? YES : NO;
    self.navigationView.line.hidden = (y < 0) ? YES : NO;
    self.navigationView.titleLab.hidden = (y < 0) ? YES : NO;
    if (progressChange <= 0) {
        
        self.navigationView.backgroundColor = [UIColor clearColor];
        self.navigationView.line.backgroundColor = [UIColor clearColor];
        self.navigationView.titleLab.textColor = [UIColor clearColor];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
    }else{
        self.navigationView.backgroundColor = WhiteAlphaColor(progressChange);
        self.navigationView.line.backgroundColor = AlphaColor(220,progressChange);
        self.navigationView.titleLab.textColor = AlphaColor(51, progressChange);
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}



#pragma mark - 弹出-<规格>-选择
- (void)pushSpecVC:(UIViewController *)vc{
    //***  规格选择弹出层  **/
    ///读取数据
//    NSString * path = [[NSBundle mainBundle]pathForResource:@"dataSource" ofType:@"txt"];
//    NSString * string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
//    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    
//    vc = [[KLStoreGoodsSpecController alloc]initWithDic:obj[@"result"]];
    UIWindow *widow = [UIApplication sharedApplication].keyWindow;
    widow.backgroundColor = [UIColor blackColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    [self setUpAlterViewControllerWith:vc WithDistance:MainHeight * 0.5  WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:NO WithFlipEnable:YES];
}

#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance WithDirection:(XWDrawerAnimatorDirection)vcDirection WithParallaxEnable:(BOOL)parallaxEnable WithFlipEnable:(BOOL)flipEnable {
    [self dismissViewControllerAnimated:YES completion:nil]; //以防有控制未退出
    XWDrawerAnimatorDirection direction = vcDirection;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.scaleRatio =0.9;
    animator.parallaxEnable = parallaxEnable;
    animator.flipEnable = flipEnable;
    animator.toDuration = 0.5;
    animator.backDuration = 0.5;
    animator.needInteractiveTimer = YES;
    [self xw_presentViewController:vc withAnimator:animator];
    __weak typeof(self)weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        
        KLLog(@"=========退出");
        
        [weakSelf selfAlterViewback];
    }];
}
#pragma 退出界面
- (void)selfAlterViewback {
    [self dismissViewControllerAnimated:YES completion:^{
        UIWindow *widow = [UIApplication sharedApplication].keyWindow;
        widow.backgroundColor = [UIColor whiteColor];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }];
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
