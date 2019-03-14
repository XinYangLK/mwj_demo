//
//  KLPetClassifyController.m
//  mwstreet
//
//  Created by 科pro on 2019/2/18.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLPetClassifyController.h"
#import "KLPetClassifyCollectionCell.h"
#import "KLPetIndexListController.h"
@interface KLPetClassifyController ()
<UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic, strong) UICollectionView * collectionView; //列表
@property (nonatomic, strong) UICollectionViewFlowLayout * layout;
@property (nonatomic, strong) NSMutableArray   * dataArray; //商品列表数据

@end

@implementation KLPetClassifyController


//***  数据字典初始化  **/
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray arrayWithObjects:@"狗狗",@"猫咪",@"小宠",@"水族",@"爬行", nil];
    }
    return _dataArray;
}


- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"添加宠物"];
}

//***  导航右边按钮  **/
- (UIButton *)set_rightButton{
    UIButton  *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [rightBtn setTitleColor:MainColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font =kFont_14;
    return rightBtn;
}

- (void)right_button_event:(UIButton *)sender {
 
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];

}

#pragma mark ------ lazy -- UI
//***  商品列表初始化  **/
- (UICollectionView *)collectionView {
    
    if (!_collectionView){
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        CGFloat spaceW = AdaptedWidth(70);
        CGFloat spaceH = AdaptedHeight(70);
        CGFloat space  = AdaptedHeight(70);
        CGFloat width = (MainWidth - spaceW * 2 - space) / 2;
        layout.itemSize = CGSizeMake(width, AdaptedHeight(160));
        layout.sectionInset = UIEdgeInsetsMake(0, spaceW, spaceH, spaceW);
        layout.minimumInteritemSpacing = space;
        CGFloat h = MainHeight - StatusBarAndNavigationBarHeight;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0 ,MainWidth, h ) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[KLPetClassifyCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([KLPetClassifyCollectionCell class])];
        
//        [_collectionView registerClass:[KLCollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([KLCollectionReusableView class])];
        
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
    KLPetClassifyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KLPetClassifyCollectionCell class]) forIndexPath:indexPath];
//    cell.contentView.backgroundColor =[UIColor cyanColor];
    cell.title = self.dataArray[indexPath.item];
    cell.img   = @[@"组1",@"组2",@"xaiochongchong",@"shuizushuizu",@"wugui"][indexPath.item];
    return cell;
    
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KLPetIndexListController *vc =[[KLPetIndexListController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    KLLog(@"-------%@",self.dataArray[indexPath.item]);
    
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
