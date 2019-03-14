//
//  KLBargainingListController.m
//  mwstreet
//
//  Created by 科pro on 2019/1/14.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBargainingListController.h"

#import "KLCollectionReusableView.h"
#import "KLTableViewTypeCell.h"
#import "KLCollectionViewTypeCell.h"

@interface KLBargainingListController ()
<UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, strong) UICollectionView * collectionView; //列表
@property (nonatomic, strong) UICollectionViewFlowLayout * layout;
@property (nonatomic, strong) NSMutableArray   * dataArray; //商品列表数据
@property (nonatomic, assign) BOOL showType;
@end

@implementation KLBargainingListController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.collectionView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTypeNotification:) name:@"BargainingShowType" object:nil];
}

- (void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BargainingShowType" object:nil];
}


//***  通知切换  **/
- (void)showTypeNotification:(NSNotification *)notifition {
   
    self.showType = [notifition.userInfo[@"showType"] boolValue];
    
    if (self.showType) {

        CGFloat spaceW = AdaptedWidth(10);
        CGFloat spaceH = AdaptedHeight(10);
        CGFloat width = (MainWidth - spaceW * 3 - AdaptedWidth(2)) / 2;
        _layout.itemSize = CGSizeMake(width, AdaptedHeight(251));
        _layout.sectionInset = UIEdgeInsetsMake(spaceH, spaceW, spaceH, spaceW);
        [_collectionView registerClass:[KLCollectionViewTypeCell class] forCellWithReuseIdentifier:NSStringFromClass([KLCollectionViewTypeCell class])];
    }else{
        
        _layout.itemSize = CGSizeMake(MainWidth, AdaptedHeight(154));
        _layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_collectionView registerClass:[KLTableViewTypeCell class] forCellWithReuseIdentifier:NSStringFromClass([KLTableViewTypeCell class])];
    }
    
    [self.collectionView reloadData];
}



#pragma mark ------ lazy -- UI
//***  商品列表初始化  **/
- (UICollectionView *)collectionView {
    
    if (!_collectionView){
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;

        layout.itemSize = CGSizeMake(MainWidth, AdaptedHeight(154));
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _layout = layout;
    
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight -AdaptedHeight(40);
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0 ,MainWidth, h ) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[KLTableViewTypeCell class] forCellWithReuseIdentifier:NSStringFromClass([KLTableViewTypeCell class])];
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
    if (self.showType) {
        
        KLCollectionViewTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KLCollectionViewTypeCell class]) forIndexPath:indexPath];
        
        cell.goodsTitle =@"顺丰速递防水防汗四都是跌三方我文化服务IE发我i";
        cell.goodsPrice =@"￥9823.00";
        cell.goodsOldPrice = @"￥19823.00";
        cell.goodsImg = [NSString stringWithFormat:@"goods_%ld",indexPath.row+1];
        cell.goodsDes = @"1201人参与砍价";
        cell.goodsBtnTitle = @"砍价9折购";

        return cell;
    }else{
        
        KLTableViewTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KLTableViewTypeCell class]) forIndexPath:indexPath];
        cell.title    = self.dataArray[indexPath.row];
        cell.price    = @"￥9823.00";
        cell.goodsDes = @"98201人参与砍价";
        cell.btnTitle = @"砍价9折购";
        cell.imgView  = [NSString stringWithFormat:@"goods_%ld",indexPath.row+1];
        return cell;
    }
  
    
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
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
        size = CGSizeMake(MainWidth, 54);
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
