//
//  KLFilterMenuView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLFilterMenuView.h"
#import "KLFilterMenuCollectionCell.h"

@interface KLFilterMenuView ()<
UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource
>
{
    NSInteger _selectIndex;
}
@property (nonatomic, strong) NSDictionary * cellDic;//设置cell的identifier，防止重用
@property (nonatomic, assign) CGFloat KL_height;
@property (nonatomic, assign) CGFloat KL_y;

@end
@implementation KLFilterMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {

        [self configerUI];
        
    }
    return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self fadeOut];

}


- (void)showInView:(UIView *)aView animated:(BOOL)animated {
    [aView addSubview:self];
    if (animated) {
        [self fadeIn];
        _showBlock(YES);
    }
}


- (CGFloat)KL_height {
    return MainHeight - StatusBarAndNavigationBarHeight - AdaptedHeight(88) - TabbarSafeBottomMargin;
}

- (CGFloat)KL_y {
    return MainHeight - AdaptedHeight(88) - TabbarSafeBottomMargin -StatusBarAndNavigationBarHeight;
}

#pragma mark - Private Methods
- (void)fadeIn{
    
    klWeakSelf;
    CGFloat h = weakSelf.KL_height + 34 + AdaptedHeight(44);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        weakSelf.backView.frame = CGRectMake(0, 0, MainWidth, h);
    }];
}

- (void)fadeOut{
    
    klWeakSelf;
    CGFloat h = weakSelf.KL_height + 34 + AdaptedHeight(44);
    
    [UIView animateWithDuration:.25 animations:^{

        weakSelf.backView.frame = CGRectMake(MainWidth, 0, 0, h);
        
    }completion:^(BOOL finished) {
        
        if (finished){
            
            [weakSelf removeFromSuperview];
        }
    }];
}


#pragma mark ------ lazy UI
- (void)configerUI {
    
    [self addSubview:self.backView];
    [self.backView addSubview:self.tableView];
    [self.backView addSubview:self.collectionView];
    [self.backView addSubview:self.remakeBtn];
    [self.backView addSubview:self.confirmBtn];
    [self.backView addSubview:self.line];
    
}


- (UIView *)backView {
    if (!_backView){
        _backView = [[UIView alloc]initWithFrame:CGRectMake(MainWidth, 0, 0, self.KL_height)];
        _backView.backgroundColor =[UIColor whiteColor];
    }
    return _backView;
}

- (UIView *)line {
    if (!_line){
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, self.KL_y, MainWidth, 0.5)];
        _line.backgroundColor = LineColor;
    }
    return _line;
}

- (UIButton *)remakeBtn {
    if (!_remakeBtn){
        _remakeBtn = [UIButton createBtnTitle:@"重置" titleColor:TitleColor font:kFont_15 imageName:@"" backgrounColor:[UIColor whiteColor] action:^(UIButton * _Nonnull button) {
            
            KLLog(@"重置重置重置重置重置重置重置重置重置");
        }];
        _remakeBtn.frame =CGRectMake(0, self.KL_y, MainWidth/2, AdaptedHeight(44));
    }
    return _remakeBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn){
        klWeakSelf;
        _confirmBtn = [UIButton createBtnTitle:@"确认" titleColor:[UIColor whiteColor] font:kFont_15 imageName:@"" backgrounColor:MainColor action:^(UIButton * _Nonnull button) {
            
             [weakSelf fadeOut];
             weakSelf.showBlock(NO);

        }];
        _confirmBtn.frame =CGRectMake(MainWidth/2, self.KL_y, MainWidth/2, AdaptedHeight(44));
    }
    return _confirmBtn;
}





- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, AdaptedWidth(95), self.KL_height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =BackgroundColor;
        _tableView.alwaysBounceVertical = NO;//数据超过屏幕时才允许滑动
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView =[UIView new];
    }
    return _tableView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView){
        _choosedArray = [[NSMutableArray alloc]initWithCapacity:0];

        CGFloat spaceW = AdaptedWidth(10);
        CGFloat spaceH = AdaptedHeight(10);
        CGFloat width = (MainWidth - AdaptedWidth(102) - spaceW * 3) / 2;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(width, AdaptedHeight(30));
        layout.sectionInset = UIEdgeInsetsMake(spaceH, spaceW, spaceH, spaceW);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(AdaptedWidth(100), 0, MainWidth-AdaptedWidth(100), self.KL_height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

#pragma mark ------ UITableViewDelegate,UITableViewDataSource,
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier = [NSString stringWithFormat:@"cellId%ld",(long)indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.contentView.backgroundColor = BackgroundColor;
    cell.textLabel.font = kFont_14;
    cell.textLabel.textColor = RGBSigle(51);
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;//字体自适应宽度

    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    if (indexPath.row == 0) {
        //设置cell默认选中状态
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(44);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    _selectIndex = indexPath.row;
//    [self requestReloadData];

}


//- (void)requestReloadData{
//
//    GoodsCateData *dataList =self.tableTitleArray[_selectIndex];
//
//    [self.collectionView reloadData];
//
//    if (dataList.child.count<=0) {
//        [self configBlankMessage:EMPTY_TEXT image:@"data"];
//    }else{
//        [EasyShowEmptyView hiddenEmptyView:self.collectionView];
//    }
//}

#pragma mark ====== UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"%@%@", NSStringFromClass([KLFilterMenuCollectionCell class]), [NSString stringWithFormat:@"%@", indexPath]];
        [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
        [_collectionView registerClass:[KLFilterMenuCollectionCell class]  forCellWithReuseIdentifier:identifier];
    }
    KLFilterMenuCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    NSString * text =[self.dataArray objectAtIndex:indexPath.row];
    [cell.selectIconBtn setTitle:text forState:UIControlStateNormal];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KLFilterMenuCollectionCell * cell = (KLFilterMenuCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
  
    [cell UpdateCellWithState:!cell.isSelected];
    
    if (cell.isSelected) {
        [self.choosedArray addObject:cell.selectIconBtn.titleLabel.text];
    }
    else{
        [self.choosedArray removeObject:cell.selectIconBtn.titleLabel.text];
    }
    
    _block(cell.titleLab.text,_choosedArray);
}


//***  数据字典初始化  **/
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSMutableArray arrayWithObjects:@"22",@"33",@"fv",@"dfvdfv",@"fvdfv",@"dfvd",@"vdv",@"vefv", nil];
    }
    return _dataArray;
};



@end
