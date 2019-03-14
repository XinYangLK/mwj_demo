//
//  KLLivingClassifyController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/21.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLLivingClassifyController.h"
#import "KLNavigationSearchBtn.h"        //伪导航
#import "UIButton+EnlargeTouchArea.h"    //导航按钮点击区域设置
#import "KLClassifyCollectionViewCell.h" //分类 CollectionCell
#import "KLBrandCollectionViewCell.h"    //品牌 CollectionCell
#import "KLClassifyHeaderReusableView.h" //分类 / 品牌 Collection header /footer
#import "KLClassifyTopView.h"            //顶部大分类
#import "KLSearchViewController.h"       //搜索界面

@interface KLLivingClassifyController ()<
UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
{
    NSInteger _selectIndex;
}
@property (nonatomic, strong) KLNavigationSearchBtn * searchBtn; //导航搜索按钮
@property (nonatomic, strong) UITableView       * tableView;
@property (nonatomic, strong) UICollectionView  * collectionView;
@property (nonatomic, strong) UIView            * lineView;
@property (nonatomic, strong) NSMutableArray    * dataArray;
@property (nonatomic, strong) NSMutableArray    * tableTitleArray;
@property (nonatomic, strong) KLClassifyTopView * headerView;
@end

@implementation KLLivingClassifyController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBtn removeFromSuperview];
    self.searchBtn = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.view addSubview:self.searchBtn];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.lineView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset =0;
        make.height.offset =AdaptedHeight(44);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(95);
        make.bottom.offset =0;
        make.top.offset =AdaptedHeight(44);
        make.width.offset =0.5;
    }];
}

#pragma mark - 查看全部响应事件
- (void)didLookAllBtnChick:(UIButton *)sender {
   
    if ([sender.titleLabel.text isEqualToString:@"查看全部"]) {
        
        KLLog(@"查看全部分类");
        
    }else{
        
        KLLog(@"查看全部品牌");
    }

}


//***  搜索框点击响应  **/
- (void)searchBtnChick:(KLNavigationSearchBtn *)sender{
    KLSearchViewController *vc =[[KLSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


//***  导航按钮响应  **/
- (void)left_button_event:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)right_button_event:(UIButton *)sender {
    self.tabBarController.selectedIndex =3;
}



#pragma mark ------ UI 构建
//***  导航右边按钮  **/
- (UIButton *)set_rightButton{
    UIButton  * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightBtn setImage:[UIImage imageNamed:@"gouwuche"] forState:UIControlStateNormal];
    //解决偏移问题:
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(-7,0,0, 0);
    //解决响应事件的触发范围:
    [rightBtn setEnlargeEdgeWithTop:0 right:0 bottom:0 left:0];
    return rightBtn;
}
//***  导航返回按钮  **/
- (UIButton *)set_leftButton {
    
    UIButton  *leftBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    //解决偏移问题:
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(-7,0,0, 0);
    //解决响应事件的触发范围:
    [leftBtn setEnlargeEdgeWithTop:0 right:0 bottom:0 left:0];
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
        _searchBtn.searchLab.text =@"野兽派";
        [_searchBtn addTarget:self action:@selector(searchBtnChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

//***  一级菜单  **/
- (KLClassifyTopView *)headerView {
    if (!_headerView){
        _headerView = [[KLClassifyTopView alloc]init];
        _headerView.titleArray =@[@"狗狗",@"喵咪",@"小宠",@"水族"];
    }
    return _headerView;
}

- (UIView *)lineView {
    if (!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor =LineColor;
    }
    return _lineView;
}

#pragma mark - lazy TableView UI

- (UITableView *)tableView{
    if (!_tableView) {
        
        CGFloat  h =  MainHeight - StatusBarAndNavigationBarHeight -AdaptedHeight(44);
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, AdaptedHeight(44), AdaptedWidth(95),  h) style:UITableViewStylePlain];
        _tableView.separatorStyle =UITableViewCellSelectionStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.tableFooterView =[UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.mCustomClass([UITableViewCell class]);
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.tableTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor =RGBSigle(51);
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;//字体自适应宽度
    cell.textLabel.font = kFont_15;
    //设置选中cell颜色
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:MainColor]];
    if (indexPath.row ==0) {
        //设置cell默认选中状态
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }else{
//        classifyData *dataList =self.tableTitleArray[indexPath.row-1];
//        cell.textLabel.text =dataList.cateName;
        
    }
    cell.textLabel.text = self.tableTitleArray[indexPath.row];

    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(49);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndex = indexPath.row;
    [self.collectionView reloadData];
}






- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.headerReferenceSize =CGSizeMake(self.view.mj_w,AdaptedHeight(50));

        CGFloat  h =  MainHeight - StatusBarAndNavigationBarHeight - AdaptedHeight(44);
        CGFloat  w =  MainWidth - AdaptedWidth(95);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(AdaptedWidth(95),AdaptedHeight(44), w, h) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        
        //注册cell
        [_collectionView registerClass:[KLClassifyCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([KLClassifyCollectionViewCell class])];
        [_collectionView registerClass:[KLBrandCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([KLBrandCollectionViewCell class])];

        [_collectionView registerClass:[KLClassifyHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([KLClassifyHeaderReusableView class])];
        [_collectionView registerClass:[KLClassifyFooterReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([KLClassifyFooterReusableView class])];

    }
    return _collectionView;
}


#pragma mark - UICollectionView DataSource Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (_selectIndex ==0) {
        return 2;
    }else{
//        classifyData *child = self.tableTitleArray[_selectIndex-1];
//        return child.child.count;
        return 2;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (_selectIndex ==0) {
        return self.dataArray.count;
    }else{
//        classifyData *child = self.tableTitleArray[_selectIndex-1];
//        classifyChild *childs = child.child[section];
//        return childs.child.count;
        return 3 + arc4random()%10;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        KLClassifyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KLClassifyCollectionViewCell class]) forIndexPath:indexPath];
        cell.classifyImg.image =[UIImage imageNamed:@"pic_2"];
        cell.classifyTitle.text =@"进口狗粮";
        
        return cell;
    }else {
        KLBrandCollectionViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KLBrandCollectionViewCell class]) forIndexPath:indexPath];
        cell.brandImg.image =[UIImage imageNamed:@"dsfd"];
        cell.brandLab.text =@"枫树大道Maples";
        
        return cell;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CGFloat spaceW = AdaptedWidth(10);
        CGFloat width = (MainWidth - spaceW * 4 -AdaptedWidth(112)) / 3;
        return CGSizeMake(width,AdaptedHeight(96));

    }else{
        CGFloat spaceW = AdaptedWidth(9);
        CGFloat width = (MainWidth - spaceW * 3 -AdaptedWidth(97)) / 2;
        return CGSizeMake(width, AdaptedHeight(80));
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        CGFloat spaceW = AdaptedWidth(10);
        CGFloat spaceH = AdaptedHeight(10);
        return UIEdgeInsetsMake(spaceH, spaceW, spaceH, spaceW);
    }else {
        CGFloat spaceW = AdaptedWidth(7);
        CGFloat spaceH = AdaptedHeight(10);
        return UIEdgeInsetsMake(spaceH, AdaptedWidth(10), spaceH, spaceW);
    }
}


//区头视图/标题
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
   
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        
        KLClassifyFooterReusableView *footerView =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([KLClassifyFooterReusableView class]) forIndexPath:indexPath];
        footerView.section = indexPath.section;
        if (indexPath.section == 1) {
            [footerView.lookAllBtn setTitle:@"查看所有品牌" forState:UIControlStateNormal];
        }
        
        klWeakSelf;
        footerView.lookAllBlock = ^(UIButton * _Nonnull button, NSInteger section) {
            [weakSelf didLookAllBtnChick:button];
        };
        
        return footerView;
    }else {
        
        
        KLClassifyHeaderReusableView *headsCell =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([KLClassifyHeaderReusableView class]) forIndexPath:indexPath];
        if (indexPath.section == 0) {
            headsCell.titleLab.text =self.tableTitleArray[_selectIndex];
        }else {
            headsCell.titleLab.text =@"热门品牌";
        }
        return headsCell;
    }
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(MainWidth-AdaptedWidth(95), 0);

    }else {
        return CGSizeMake(MainWidth-AdaptedWidth(95), AdaptedHeight(50) + TabbarSafeBottomMargin);
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
 
}


//***  数据字典初始化  **/
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray arrayWithObjects:@"粮食系列",@"生活用品",@"零食系列",@"医疗系列",@"保健系列",@"美容系列",@"玩具系列",@"出行装备", nil];
    }
    return _dataArray;
}
//***  数据字典初始化  **/
- (NSMutableArray *)tableTitleArray{
    if (!_tableTitleArray) {
        _tableTitleArray =[NSMutableArray arrayWithObjects:@"粮食系列",@"生活用品",@"零食系列",@"医疗系列",@"保健系列",@"美容系列",@"玩具系列",@"出行装备", nil];
    }
    return _tableTitleArray;
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
