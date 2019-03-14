//
//  KLMyOrderResultsStatusController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyOrderResultsStatusController.h"
#import "KLMallCollectionViewCell.h"
#import "KLMyOrderResultsReusableView.h"

@interface KLMyOrderResultsStatusController ()

<UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate,
UICollectionViewDataSource,
UINavigationControllerDelegate,
UIGestureRecognizerDelegate
>

@property (nonatomic, strong) UICollectionView * collectionView; //列表
@property (nonatomic, strong) NSMutableArray   * dataArray; //商品列表数据

@end


@implementation KLMyOrderResultsStatusController

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if ([viewController isKindOfClass:[self class]]) {
        [navigationController.navigationBar navBarBackGroundColor:MainColor image:nil isOpaque:YES];
        [navigationController.navigationBar navBarBottomLineHidden:YES];
        
    }else {
        
        [navigationController.navigationBar navBarBackGroundColor:[UIColor whiteColor] image:nil isOpaque:NO];
        [navigationController.navigationBar navBarBottomLineHidden:NO];
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar navBarBackGroundColor:MainColor image:nil isOpaque:YES];
    [self.navigationController.navigationBar navBarBottomLineHidden:YES];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.view addSubview:self.collectionView];
}

- (void)left_button_event:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)set_leftButton {
    UIButton  *leftBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //解决偏移问题:
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(-7,0,0, 0);
    return leftBtn;
}

- (NSMutableAttributedString *)setTitle {
    self.navTitleColor = [UIColor whiteColor];
    return [self changeTitle:@"支付成功"];
}



#pragma mark ------ lazy -- UI
//***  商品列表初始化  **/
- (UICollectionView *)collectionView {
    
    if (!_collectionView){
        
        CGFloat spaceW = AdaptedWidth(10);
        CGFloat spaceH = AdaptedHeight(10);
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - spaceW * 3) / 2;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(width, AdaptedHeight(251));
        layout.sectionInset = UIEdgeInsetsMake(spaceH, spaceW, spaceH, spaceW);
        layout.minimumInteritemSpacing =AdaptedWidth(10);
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0 ,MainWidth, MainHeight - StatusBarAndNavigationBarHeight) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[KLMallCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([KLMallCollectionViewCell class])];
        [_collectionView registerClass:[KLMyOrderResultsReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([KLMyOrderResultsReusableView class])];
        
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
    KLMallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KLMallCollectionViewCell class]) forIndexPath:indexPath];
    cell.goodName =self.dataArray[indexPath.row];
    return cell;
    
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    KLMyOrderResultsReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([KLMyOrderResultsReusableView class]) forIndexPath:indexPath];
    
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
        size = CGSizeMake(MainWidth, AdaptedHeight(195));
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
