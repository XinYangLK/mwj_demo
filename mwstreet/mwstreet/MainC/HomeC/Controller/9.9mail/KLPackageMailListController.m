//
//  KLPackageMailListController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLPackageMailListController.h"
#import "KLMallCollectionViewCell.h"
#import "KLCollectionReusableView.h"
#import "KLGoodsDetailController.h" //商品详情

@interface KLPackageMailListController ()
<UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, strong) UICollectionView * collectionView; //列表
@property (nonatomic, strong) UICollectionViewFlowLayout * layout;
@property (nonatomic, strong) NSMutableArray   * dataArray; //商品列表数据
@property (nonatomic, assign) BOOL showType;
@end

@implementation KLPackageMailListController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.collectionView];
}

- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:self.navTitle];
}

//***  导航右边按钮  **/
- (UIButton *)set_rightButton{
    UIButton  *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightBtn setImage:[UIImage imageNamed:@"gev"] forState:UIControlStateNormal];
    return rightBtn;
}

- (void)right_button_event:(UIButton *)sender {
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




#pragma mark ------ lazy -- UI
//***  商品列表初始化  **/
- (UICollectionView *)collectionView {
    
    if (!_collectionView){
        
//        CGFloat spaceW = AdaptedWidth(10);
//        CGFloat spaceH = AdaptedHeight(10);
//        CGFloat width = ([UIScreen mainScreen].bounds.size.width - spaceW * 3) / 2;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.layout = layout;
        [self AutomaticCollectTypeLayoutItem:layout];
        
//        layout.itemSize = CGSizeMake(width, AdaptedHeight(251));
//        layout.sectionInset = UIEdgeInsetsMake(spaceH, spaceW, spaceH, spaceW);
//        layout.minimumInteritemSpacing =AdaptedWidth(10);
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0 ,MainWidth, MainHeight - StatusBarAndNavigationBarHeight) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self RegisterCollectTypeCell];

        [_collectionView registerClass:[KLCollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([KLCollectionReusableView class])];
      
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
        cell.goodName =self.dataArray[indexPath.row];
        return cell;
    }else{
        KLMallTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KLMallTableViewCell class]) forIndexPath:indexPath];
        cell.goodName =self.dataArray[indexPath.row];
        cell.oldPrice =[NSString stringWithFormat:@"￥%u", arc4random()%100000];
        return cell;
    }
    
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KLGoodsDetailController *vc =[[KLGoodsDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    KLCollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([KLCollectionReusableView class]) forIndexPath:indexPath];

    headerView.headerImg.image =[UIImage imageNamed:@"ad_1"];
    return headerView;
    
}
//***  添加区尾34高度  **/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize size = CGSizeZero;
    if (section == 0) {
        size = CGSizeMake(MainWidth, 34);
    }
    return size;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    CGSize size = CGSizeZero;
    if (section == 0) {
        size = CGSizeMake(MainWidth, AdaptedHeight(279));
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
