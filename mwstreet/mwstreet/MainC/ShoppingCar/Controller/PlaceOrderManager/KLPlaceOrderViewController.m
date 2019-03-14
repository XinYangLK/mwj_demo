//
//  KLPlaceOrderViewController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/16.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLPlaceOrderViewController.h"
#import "XWDrawerAnimator.h"               //导航push动画
#import "UIViewController+XWTransition.h"
#import "KLPlaceOrderGoodsCell.h"       //商品cell
#import "KLStoreGoodsDescribeCell.h"    //商品配置信息cell
#import "KLStoreGoodsTextFieldMsgCell.h"//买家留言cell
#import "KLPlaceOrderGoodsHeaderView.h" //店铺名header
#import "KLPlaceOrderGoodsFooterView.h" //地址彩条分割footer
#import "KLPayMentViewController.h"     //

@interface KLPlaceOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;      //表
@property (nonatomic, strong) UILabel     * totalPriceLab;  //订单总价格
@property (nonatomic, strong) UIButton    * submitOrderBtn; //提交订单按钮
@property (nonatomic, strong) UIView      * backView;       //蒙板View
@property (nonatomic, strong) NSArray     * payTypeArr;     //支付菜单类型array
@property (nonatomic, strong) NSString    * totalMoney;     //订单总价格
@end

@implementation KLPlaceOrderViewController

- (NSMutableAttributedString *)setTitle{
    return [self changeTitle:@"订单结算"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SpacColor ;
    
    self.payTypeArr = @[@{@"pic":@"grthj",@"title":@"支付宝",@"type":@"alipay"},
                        @{@"pic":@"rtyhhu",@"title":@"微信",@"type":@"wxpay"},
                        @{@"pic":@"ijhg",@"title":@"银行卡",@"type":@"IDs"}];
    
    self.totalMoney = @"1888.00";
    
    [self configerUI];
}


/**
 * 提交订单处理
 * @param  type    支付类型
 * @param  money   支付金额
 */
#pragma mark - 提交订单 处理
- (void)submitOrderHandle:(NSString *)type Money:(NSString *)money{
    
     NSLog(@"选择了支付方式:%@\n需要支付金额:%@",type,money);
}




#pragma mark - lazy --UI
- (void)configerUI {
    [self.view addSubview:self.tableView];
    [self totalPriceLab];
    [self submitOrderBtn];
    self.view.backgroundColor =[UIColor whiteColor];
}

//***  待支付总金额lab  **/
- (UILabel *)totalPriceLab {
    if (!_totalPriceLab){
        _totalPriceLab = [UILabel zj_labelWithFontSize:14
                                                 lines:1
                                                  text:@"   待支付：￥"
                                             superView:self.view
                                           constraints:^(MASConstraintMaker *make) {
                                               make.left.offset =0;
                                               make.width.offset = MainWidth/2;
                                               make.bottom.offset = - TabbarSafeBottomMargin;
                                               make.height.offset = AdaptedHeight(49);
                                           }];
    }
    return _totalPriceLab;
}
//***  提交订单Btn  **/
- (UIButton *)submitOrderBtn {
    if (!_submitOrderBtn){
        klWeakSelf;
        _submitOrderBtn = [UIButton zj_buttonWithTitle:@"提交订单"
                                            titleColor:[UIColor whiteColor]
                                             backColor:MainColor fontSize:14
                                                isBold:NO
                                          cornerRadius:0
                                               supView:self.view
                                           constraints:^(MASConstraintMaker *make) {
                                               make.right.offset =0;
                                               make.width.bottom.height.mas_equalTo(self.totalPriceLab);
                                           } touchUp:^(id sender) {
                                               [weakSelf payOrderMethodMentSheetView];
                                           }];
    }
    return _submitOrderBtn;
}
//***  背景蒙版  **/
- (UIView *)backView {
    if (!_backView){
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
        [tap setNumberOfTapsRequired:1];
        [_backView addGestureRecognizer:tap];
        _backView.backgroundColor =RGBA(33, 33, 33, 0.3);
    }
    return _backView;
}


//***  lazy tableView  **/
- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat height = MainHeight - StatusBarAndNavigationBarHeight - AdaptedHeight(49) -TabbarSafeBottomMargin;
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, height)
                                                style:UITableViewStyleGrouped];
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 34)];
        _tableView.mCustomClass([UITableViewCell class]);
        _tableView.mCustomClass([KLPlaceOrderGoodsCell class]);
        _tableView.mCustomClass([KLStoreGoodsDescribeCell class]);
        _tableView.mCustomClass([KLStoreGoodsTextFieldMsgCell class]);
        _tableView.mCustomFooterHeaderClass([KLPlaceOrderGoodsHeaderView class]);
        _tableView.mCustomFooterHeaderClass([KLPlaceOrderGoodsFooterView class]);
    }
    return _tableView;
}

#pragma mark - tableView Delagete && Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
        
    }else if(section == 1){
        
        return 5;
        
    }else {
        
        return 3;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
        
        return cell;
        
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            KLPlaceOrderGoodsCell * cell = kCellIdentifier(KLPlaceOrderGoodsCell);
            cell.imgName =@"goods_3";
            cell.goodsName =@"发顺丰四十我if汉文化服务一而后无法维护费IE回复IE和";
            cell.goodsPrice =@"￥18889";
            cell.goodsNumber =@"×99";
            return cell;
            
        }else if(indexPath.row == 4){
           
            KLStoreGoodsTextFieldMsgCell * cell = kCellIdentifier(KLStoreGoodsTextFieldMsgCell);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else {
            
            KLStoreGoodsDescribeCell * cell = kCellIdentifier(KLStoreGoodsDescribeCell);

           
            if (indexPath.row == 3) {
                cell.textLab.textColor = RedColor;
                cell.angleImg.hidden = NO;
            }else{
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLab.textColor = TextColor;
                cell.angleImg.hidden = YES;
            }
            
            cell.title = @[@"配送方式",@"运费",@"优惠券"][indexPath.row -1];
            cell.text = @[@"快递    包邮",@"￥0.00",@"已选￥10优惠"][indexPath.row -1];

            return cell;
        }
        
    }else {
        
        KLStoreGoodsDescribeCell * cell = kCellIdentifier(KLStoreGoodsDescribeCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.angleImg.hidden = YES;
        cell.title = @[@"商品金额",@"运费",@"优惠抵扣"][indexPath.row];
        cell.text = @[@"￥65.8",@"￥0.00",@"-￥10"][indexPath.row];
        cell.textLab.textColor = RedColor;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return AdaptedHeight(60);
        
    }else if(indexPath.section ==1 && indexPath.row == 0){
        
        return AdaptedHeight(93);
        
    }else if(indexPath.section == 2){
        
        return AdaptedHeight(40);
        
    }else {
        
        return AdaptedHeight(48);
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    if (section == 1) {
        
        return AdaptedHeight(50);
        
    }else{
        
        return CGFLOAT_MIN;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   
    if (section == 0 || section ==1) {
        
        return AdaptedHeight(5);
        
    }else{
        
        return CGFLOAT_MIN;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    if (section == 1) {
        
        KLPlaceOrderGoodsHeaderView * headerView = kHeaderFooterIdentifier(KLPlaceOrderGoodsHeaderView);
        headerView.headerTitle =@"派多格宠物店";
        
        return headerView;
        
    }else{
        
        UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
        if (!headerView) {
            headerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerCell"];
        }
        return headerView;
    }
}

//***  设置区尾 **/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
  
    if (section == 0) {
        
        KLPlaceOrderGoodsFooterView * footerView  = kHeaderFooterIdentifier(KLPlaceOrderGoodsFooterView);
        
        return footerView;
    
    }else {
        UITableViewHeaderFooterView *footerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerCell"];
        if (!footerView) {
            footerView =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"footerCell"];
        }
        footerView.contentView.backgroundColor = SpacColor;
        return footerView;
    }
}

// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        //分割线两端封头
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
            [cell setSeparatorInset:UIEdgeInsetsMake(0, MainWidth, 0, 0)];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
            [cell setLayoutMargins:UIEdgeInsetsMake(0, MainWidth, 0, 0)];
    }else{
        //分割线两端封头
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
            [cell setSeparatorInset:UIEdgeInsetsZero];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
            [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}




#pragma mark - 支付菜单选择及蒙板动画
//***  pop 支付方式选择菜单控制器  **/
- (void)payOrderMethodMentSheetView {
    KLPayMentViewController * vc = [[KLPayMentViewController alloc] initTotalPay:self.totalMoney vc:self dataSource:self.payTypeArr];
    //***  加载蒙板动画  **/
    [self payMothMethodMaskViewAnimations];
    [self setUpAlterViewControllerWith:vc WithDistance:MainHeight * 0.4  WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:NO WithFlipEnable:NO];
    klWeakSelf;
    vc.payType = ^(NSString *type,NSString *balance) {
        if (![type isEqualToString:@"取消"]) {
            [weakSelf submitOrderHandle:type Money:balance];
        }
        //***  退出界面  **/
        [weakSelf event:nil];
    };
}

//***  加载蒙板动画  **/
- (void)payMothMethodMaskViewAnimations{
    UIWindow *widow = [UIApplication sharedApplication].keyWindow;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backView.frame = CGRectMake(0, 0, MainWidth, MainHeight * 0.6);
        [widow addSubview:self.backView];
    }];
}

#pragma 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance WithDirection:(XWDrawerAnimatorDirection)vcDirection WithParallaxEnable:(BOOL)parallaxEnable WithFlipEnable:(BOOL)flipEnable {
    [self dismissViewControllerAnimated:YES completion:nil]; //以防有控制未退出
    XWDrawerAnimatorDirection direction = vcDirection;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.scaleRatio =1;
    animator.parallaxEnable = parallaxEnable;
    animator.flipEnable = flipEnable;
    animator.toDuration = 0.2;
    animator.backDuration = 0.2;
    animator.needInteractiveTimer = YES;
    [self xw_presentViewController:vc withAnimator:animator];
    __weak typeof(self)weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf event:nil];
    }];
}
#pragma 退出界面
- (void)event:(UITapGestureRecognizer *)tap{
    [self.backView removeFromSuperview];
    self.backView = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
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
