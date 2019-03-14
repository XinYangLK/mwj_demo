//
//  KLBMallGoodsListController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/28.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBMallGoodsListController.h"
#import "KLMallCollectionViewCell.h"
#import "KLStoreGoodsListCollectionCell.h"
#import "KLCollectionReusableView.h"
#import "KLBGoodsDetailManager.h"
//#import "KLBGoodsMeunView.h"//菜单
#import "SQFiltrateView.h"
#import "KLSearchViewController.h"

@interface KLBMallGoodsListController ()
<UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, strong) UICollectionView * collectionView; //列表
@property (nonatomic, strong) UICollectionViewFlowLayout * layout;
@property (nonatomic, strong) NSMutableArray   * dataArray; //商品列表数据
@property (nonatomic, assign) BOOL               showType;  //列表显示类型
@property (nonatomic, strong) SQFiltrateView   * filtrateView;  //菜单
@property (nonatomic, strong) UIButton * searchBtn;
@end

@implementation KLBMallGoodsListController
- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:self.navTitle];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [self.filtrateView hideAllItemView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self searchBtn];
    [self.view addSubview:self.collectionView];
    [self CreatMeunView];
}

- (void)CreatMeunView {
    
    SQFiltrateItem *item1 = [[SQFiltrateItem alloc]init];
    item1.listType   = OptionListType_Tag;
    item1.numberType = OptionNumberType_Many;
    item1.optionData = @[@"全部",@"select2",@"select3",@"select4",@"select5",@"select6",@"select1",@"select2",@"select3",@"select4",@"select5",@"select6",@"select1",@"select2",@"select3",@"select4",@"select5",@"select6",@"select1",@"select2",@"select3",@"select4",@"select5",@"select6",@"select1",@"select2",@"select3",@"select4",@"select5",@"select6",@"select1",@"select2",@"select3",@"select4",@"select5",@"select6",@"select1",@"select2",@"select3",@"select4",@"select5",@"select6",@"select1",@"select2",@"select3",@"select4",@"select5",@"select6",@"select1",@"select2",@"select3",@"select4",@"select5",@"select6",@"select1",@"select2",@"select3",@"select4",@"select5",@"select6",@"select1",@"select2",@"select3",@"select4",@"select5",@"select6",@"select1",@"select2"];
    item1.title = @"品牌";
    
    
    SQFiltrateItem *item2 = [[SQFiltrateItem alloc]init];
    item2.listType   = OptionListType_Tag;
    item2.numberType = OptionNumberType_Many;//OptionNumberType_Single;
    item2.optionData = @[@"全部",@"select2",@"select3",@"select4",@"select5",@"select6",@"select1",@"select2",@"select3",@"select4",@"select5",@"select6",@"select1",@"select2",@"select3",@"select4",@"select5",@"select6",@"select1",@"select2",@"select3",@"select4",@"select5",@"select6"];
    item2.title = @"分类";
    
    
    SQFiltrateItem *item3 = [[SQFiltrateItem alloc]init];
    item3.listType   = OptionListType_Tag;
    item3.numberType = OptionNumberType_Many;
    item3.optionData = @[@"全部",@"select2",@"select3",@"select4",@"select5",@"select6"];
    item3.title = @"品种";
    
    
    SQFiltrateItem *item4 = [[SQFiltrateItem alloc]init];
    item4.listType   = OptionListType_Tag;
    item4.numberType = OptionNumberType_Many;
    item4.optionData = @[@"全部",@"select2",@"select3",@"select4",@"select5",@"select6"];
    item4.title = @"筛选";
    
    
    SQFiltrateView *filtrateView = [[SQFiltrateView alloc]initWithFrame:CGRectMake(0, AdaptedHeight(44), MainWidth, AdaptedHeight(44)) filtrateItems:@[item1,item2,item3,item4]];
    [filtrateView touchBlock:^(SQFiltrateView * _Nonnull view, SQFiltrateItem * _Nonnull item) {
        NSLog(@"%@:%@",item.title,item.choseSet);
    }];
    self.filtrateView = filtrateView;
    [self.view addSubview:filtrateView];
}



//***  导航右边按钮响应  **/
- (void)right_button_event:(UIButton *)sender {
    [self.filtrateView hideAllItemView];
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"gev"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"grf"] forState:UIControlStateNormal];
    }
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
}



//***  导航右边按钮  **/
- (UIButton *)set_rightButton{
    UIButton  *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightBtn setImage:[UIImage imageNamed:@"gev"] forState:UIControlStateNormal];
    return rightBtn;
}



//***  collect 宠物、商品列表布局 及注册  **/
- (void)RegisterCollectTypeCell {
    
    [_collectionView registerClass:[KLMallCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([KLMallCollectionViewCell class])];

}
//***  table 宠物、商品列表布局 及注册  **/
- (void)RegisterTableTypeCell {
    
     [_collectionView registerClass:[KLMallTableViewCell class] forCellWithReuseIdentifier:NSStringFromClass([KLMallTableViewCell class])];
}

//***  collect Type Item布局  **/
- (void)AutomaticCollectTypeLayoutItem:(UICollectionViewFlowLayout *)layout {
    
    CGFloat spaceW = AdaptedWidth(10);
    CGFloat spaceH = AdaptedHeight(10);
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - spaceW * 3) / 2;
    layout.itemSize = CGSizeMake(width, AdaptedHeight(251));
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


- (UIButton *)searchBtn {
    if (!_searchBtn){
        @weakify(self)
        _searchBtn = [UIButton createBtnTitle:@"请输入商品名称或品牌" titleColor:RGBSigle(153) font:kFont_14 imageName:@"search" backgrounColor:BackgroundColor SSImagePositionType:SSImagePositionTypeLeft spacing:4 action:^(UIButton * _Nonnull button) {
            KLLog(@"搜索响应");
            @strongify(self)
            KLSearchViewController *vc = [[KLSearchViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [_searchBtn setLayerCornerRadius:AdaptedHeight(15)];
        [self.view addSubview:_searchBtn];
        [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset   = AdaptedWidth(10);
            make.right.offset  = AdaptedWidth(-10);
            make.height.offset = AdaptedHeight(30);
            make.top.offset    = AdaptedHeight(9);
        }];
    }
    return _searchBtn;
}

//***  商品列表初始化  **/
- (UICollectionView *)collectionView {
    
    if (!_collectionView){
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.layout = layout;
        [self AutomaticCollectTypeLayoutItem:layout];
        
        CGFloat y = AdaptedHeight(88) + 1;
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
    if (!self.showType) {
        
        KLMallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KLMallCollectionViewCell class]) forIndexPath:indexPath];
        cell.oldPriceLab.hidden =cell.line.hidden =cell.addCarBtn.hidden =YES;
        cell.goodName =self.dataArray[indexPath.row];
        return cell;
        
    }else{
        KLMallTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KLMallTableViewCell class]) forIndexPath:indexPath];
        cell.goodName =self.dataArray[indexPath.row];
        cell.oldPriceLab.hidden =cell.line.hidden =cell.addCarBtn.hidden =YES;

        cell.oldPrice =[NSString stringWithFormat:@"￥%u", arc4random()%100000];
        return cell;
    }
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //*** 商品详情  **/
    KLBGoodsDetailManager *vc =[[KLBGoodsDetailManager alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
