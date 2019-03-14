//
//  KLStoreGoodsListController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/19.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreGoodsListController.h"
#import "KLNavigationSearchBtn.h"     //伪导航
#import "KLMenuChangeView.h"          //菜单
#import "KLStoreGoodsListCollectionCell.h"  //宠物列表 cell
#import "KLMallCollectionViewCell.h"        //商品列表 cell
#import "KLStoreClassifyListController.h"   //分类'
#import "KLGoodsDetailController.h"         //商品详情
#import "KLStorePetDetailController.h"      //宠物详情
@interface KLStoreGoodsListController ()
<
UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate,
UICollectionViewDataSource,
KLMenuChangeViewDelegate
>
@property (nonatomic, strong) UICollectionView * collectionView; //列表
@property (nonatomic, strong) UICollectionViewFlowLayout * layout;
@property (nonatomic, strong) NSMutableArray   * dataArray; //商品列表数据
@property (nonatomic, assign) BOOL               showType;  //列表显示类型

@property (nonatomic, strong) KLNavigationSearchBtn * searchBtn; //导航搜索按钮
@property (nonatomic, strong) KLMenuChangeView      * menuView;  //菜单按钮

@end

@implementation KLStoreGoodsListController

//***  每次离开移除导航上搜索框 并置空，防止导航titleView保留影响上下级导航界面 **/
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBtn removeFromSuperview];
    self.searchBtn = nil;
}
//*** 由于前级界面导航代理隐藏显示原因--> 需在该界面视图view开始布局时(晚于 viewWillAppear)加载导航搜索框  **/
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //***  放在 viewWillAppear 里加载然后前置 会出现闪现情况 **/
    [self.navigationController.view addSubview:self.searchBtn];
}
//***  视图加载完成 将导航搜索框前置  **/
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.view addSubview:self.searchBtn];
    [self.navigationController.view bringSubviewToFront:self.searchBtn];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self menuView];
    [self.view addSubview:self.collectionView];

}


#pragma mark ------ 搜索
- (void)searchBtnChick:(KLNavigationSearchBtn *)sender {
    KLLog(@"-------%@",_searchBtn);
}

- (void)right_button_event:(UIButton *)sender {
    
    KLStoreClassifyListController *vc =[[KLStoreClassifyListController alloc]init];
    vc.navTitle = self.holderStr;
    [self.navigationController pushViewController:vc animated:YES];
    KLLog(@"---分类----");
    
}


//***  菜单delegate  **/
- (void)didChange:(KLMenuChangeView *)changeView actionBtnChick:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
            KLLog(@"综合");
            break;
        case 101:
            if (sender.selected) {
                KLLog(@"销量 上");
            }else{
                KLLog(@"销量 下");
            }
            break;
        case 102:
            if (sender.selected) {
                KLLog(@"价格 上");
            }else{
                KLLog(@"价格 下");
            }
            
            break;
        case 103:
            
            self.showType = sender.selected;
            if (!self.showType) {
                //***  collect 宠物、商品列表布局 及注册  **/
                [self AutomaticCollectTypeLayoutItem:self.layout];
                [self RegisterCollectTypeCell];

            }else{
                //***  table 宠物、商品列表布局 及注册  **/
                [self AutomaticTableTypeLayoutItem:self.layout];
                [self RegisterTableTypeCell];
            }
            [self.collectionView reloadData];
            
            break;
            
        default:
            break;
    }
}


#pragma mark ------ UI 构建
//***  导航右边按钮  **/
- (UIButton *)set_rightButton{
    UIButton  *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightBtn setImage:[UIImage imageNamed:@"fenlei"] forState:UIControlStateNormal];
    //解决偏移问题:
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(-7,0,0, 0);
    //解决响应事件的触发范围:
    //    [rightBtn setEnlargeEdgeWithTop:0 right:0 bottom:0 left:0];
    return rightBtn;
}
//***  导航返回按钮  **/
- (UIButton *)set_leftButton {
    
    UIButton  *leftBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    //解决偏移问题:
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(-7,0,0, 0);
    //解决响应事件的触发范围:
    //    [leftBtn setEnlargeEdgeWithTop:0 right:0 bottom:0 left:0];
    return leftBtn;
}
//***  自定义导航伪搜索框  **/
- (KLNavigationSearchBtn *)searchBtn {
    if (!_searchBtn){
        CGRect mainViewBounds = self.navigationController.view.bounds;
        _searchBtn = [[KLNavigationSearchBtn alloc]init];
        
        CGFloat statusH = (kDevice_Is_iPhoneX) ? 44 : 24;
        CGFloat x = CGRectGetWidth(mainViewBounds)/2- ((CGRectGetWidth(mainViewBounds)-AdaptedWidth(40))/2)+AdaptedWidth(35);
        CGFloat y = CGRectGetMinY(mainViewBounds)+ statusH;
        CGFloat w = CGRectGetWidth(mainViewBounds)-AdaptedWidth(115);
        CGFloat h = (kDevice_Is_iPhoneX) ? 35 : 30 ;
        _searchBtn.frame = CGRectMake(x, y, w, h);
        _searchBtn.searchLab.text =[NSString stringWithFormat:@"搜索本店%@",self.holderStr];
        [_searchBtn addTarget:self action:@selector(searchBtnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}


- (KLMenuChangeView *)menuView {
    if (!_menuView){
        _menuView = [[KLMenuChangeView alloc]init];
        _menuView.delegate = self;
        _menuView.menuArray = @[@"综合",@"销量",@"价格",@""];
        [self.view addSubview:_menuView];
        [_menuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.offset =0;
            make.height.offset =AdaptedHeight(44)+1;
        }];
    }
    return _menuView;
}



//***  collect 宠物、商品列表布局 及注册  **/
- (void)RegisterCollectTypeCell {
    
    if ([self.holderStr isEqualToString:@"宠物"]) {
        [_collectionView registerClass:[KLStoreGoodsListCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([KLStoreGoodsListCollectionCell class])];
    }else {
        
        [_collectionView registerClass:[KLMallCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([KLMallCollectionViewCell class])];
    }
}
//***  table 宠物、商品列表布局 及注册  **/
- (void)RegisterTableTypeCell {
    
    if ([self.holderStr isEqualToString:@"宠物"]) {
        [_collectionView registerClass:[KLStoreGoodsListTableCell class] forCellWithReuseIdentifier:NSStringFromClass([KLStoreGoodsListTableCell class])];
    }else {
        [_collectionView registerClass:[KLMallTableViewCell class] forCellWithReuseIdentifier:NSStringFromClass([KLMallTableViewCell class])];
    }
}

//***  collect Type Item布局  **/
- (void)AutomaticCollectTypeLayoutItem:(UICollectionViewFlowLayout *)layout {
    
    CGFloat spaceW = AdaptedWidth(10);
    CGFloat spaceH = AdaptedHeight(10);
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - spaceW * 3) / 2;
    layout.itemSize = CGSizeMake(width, [self.holderStr isEqualToString:@"宠物"] ?AdaptedHeight(260):AdaptedHeight(251));
    layout.sectionInset = UIEdgeInsetsMake(spaceH, spaceW, spaceH, spaceW);
    layout.minimumInteritemSpacing = spaceW;
    layout.minimumLineSpacing = spaceH;
}

//***  table Type Item布局  **/
- (void)AutomaticTableTypeLayoutItem:(UICollectionViewFlowLayout *)layout {

    layout.itemSize = CGSizeMake(MainWidth, AdaptedHeight(135));
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
}


//***  商品列表初始化  **/
- (UICollectionView *)collectionView {
    
    if (!_collectionView){
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.layout = layout;
        [self AutomaticCollectTypeLayoutItem:layout];
        
        CGFloat y = AdaptedHeight(44)+1;
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight - y;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake( 0, y ,MainWidth, h ) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self RegisterCollectTypeCell];
    }
    return _collectionView;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

//item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.holderStr isEqualToString:@"宠物"]) {
       
        if (!self.showType) {
            
            KLStoreGoodsListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KLStoreGoodsListCollectionCell class]) forIndexPath:indexPath];
            cell.goodsImg   = @"bannnnnrtyyh";
            cell.goodsName  = self.dataArray[indexPath.row];
            cell.goodsDes   = @"2针疫苗，已驱虫";
            cell.goodsPrice = @"19800/只";
            
            return cell;
        }else{
            KLStoreGoodsListTableCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KLStoreGoodsListTableCell class]) forIndexPath:indexPath];
            cell.goodsImg   = @"bannnnnrtyyh";
            cell.goodsName  = self.dataArray[indexPath.row];
            cell.goodsDes   = @"2针疫苗，已驱虫";
            cell.goodsPrice = @"19800/只";
            
            return cell;
        }
        
    }else{
        
        if (!self.showType) {
            
            KLMallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KLMallCollectionViewCell class]) forIndexPath:indexPath];
            cell.goodName =self.dataArray[indexPath.row];
            return cell;
        }else{
            KLMallTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KLMallTableViewCell class]) forIndexPath:indexPath];
            cell.goodName =self.dataArray[indexPath.row];
            cell.oldPrice =[NSString stringWithFormat:@"￥%u", arc4random()%100000];
            return cell;
        }
        
    }
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.holderStr isEqualToString:@"宠物"]) {
        //***  宠物详情  **/
        KLStorePetDetailController *vc =[[KLStorePetDetailController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        //*** 商品详情  **/
        KLGoodsDetailController *vc =[[KLGoodsDetailController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
//***  添加区尾34高度  **/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize size = CGSizeZero;
    if (section == 0) {
        size = CGSizeMake(MainWidth, 54);
    }
    return size;
}

//***  数据字典初始化  **/
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray arrayWithObjects:@"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u", @"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过人托管人托管人通过人托管人托管人通过人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u", @"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u",@"额日光而发热容给 隔日更r", @" 个人隔热成为二次", @"他人个人托管人托管人通过",@"g预计于剑与家园", @"聚一聚与金融业居右与教育局 与机遇与u", nil];
    }
    return _dataArray;
}



@end
