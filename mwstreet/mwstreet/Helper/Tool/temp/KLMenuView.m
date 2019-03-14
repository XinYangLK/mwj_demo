//
//  KLMenuView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/4.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMenuView.h"
#import "KLMenuCollectionCell.h"

@interface KLMenuView ()<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, strong) NSArray   * dataArray;
@property (nonatomic, strong) NSDictionary * cellDic;//设置cell的identifier，防止重用

@end

@implementation KLMenuView


- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor= RGBA(0, 0, 0, 0.3);
        self.dataArray = dataArray;
        
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self fadeOut];
    _showBlock(YES);
}


- (void)showInView:(UIView *)aView animated:(BOOL)animated {
    [aView addSubview:self];
    if (animated) {
        [self fadeIn];
    }
}

#pragma mark - Private Methods
- (void)fadeIn{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.collectionView.frame = CGRectMake(0, 0, MainWidth, AdaptedHeight(130));
    }];
}

- (void)fadeOut{

    klWeakSelf;
    [UIView animateWithDuration:.25 animations:^{
        weakSelf.alpha = 0.0;
        weakSelf.collectionView.frame = CGRectMake(0, 0, MainWidth, 0);
    }completion:^(BOOL finished) {
        if (finished){
            [weakSelf removeFromSuperview];
        }
    }];
}



#pragma mark ====== init ======
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat spaceW = AdaptedWidth(10);
        CGFloat spaceH = AdaptedHeight(10);
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - spaceW * 4) / 3;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(width, AdaptedHeight(30));
        layout.sectionInset = UIEdgeInsetsMake(spaceH, spaceW, spaceH, spaceW);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 0) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}


#pragma mark ====== UICollectionViewDelegate ======
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataArray.count == 0) {
        return 1;
    } else {
        return self.dataArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    NSString *identifier = [self.cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    if (identifier == nil) {
        NSString * cellId = NSStringFromClass([KLMenuCollectionCell class]);
        identifier = [NSString stringWithFormat:@"%@%@", cellId, [NSString stringWithFormat:@"%@", indexPath]];
        [self.cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
        [_collectionView registerClass:[KLMenuCollectionCell class]  forCellWithReuseIdentifier:identifier];
    }
    KLMenuCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
  
    [cell.selectBtn setTitle:self.dataArray[indexPath.item] forState:UIControlStateNormal];
    
    if ([self.chooseContent isEqualToString:cell.selectBtn.titleLabel.text]) {
        
        [cell UpdateCellWithState:YES];
        
    }else{
        
        [cell UpdateCellWithState:NO];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self fadeOut];
    
    if (_currentSelectIndex!=nil&&_currentSelectIndex != indexPath) {
        KLMenuCollectionCell * cell = (KLMenuCollectionCell *)[collectionView cellForItemAtIndexPath:_currentSelectIndex];
        [cell UpdateCellWithState:NO];
    }
    KLMenuCollectionCell * cell = (KLMenuCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell UpdateCellWithState:!cell.isSelected];
    _currentSelectIndex = indexPath;
    self.chooseContent = cell.selectBtn.titleLabel.text;
    
    _block(self.chooseContent,indexPath);
    
}

//***  数据字典初始化  **/
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSArray array];
    }
    return _dataArray;
}


@end
