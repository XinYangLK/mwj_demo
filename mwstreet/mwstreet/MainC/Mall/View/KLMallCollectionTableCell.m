//
//  KLMallCollectionTableCell.m
//  mwstreet
//
//  Created by 科pro on 2018/12/29.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLMallCollectionTableCell.h"
#import "KLMallCollectionViewCell.h"

@interface KLMallCollectionTableCell ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
KLMallCollectionViewCellDelegate
>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat heightED;

@end

@implementation KLMallCollectionTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self.heightED = 0;
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.collectionView];
        self.collectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.contentView.frame.size.height);
    }
    return self;
}

#pragma mark ====== UICollectionViewDelegate ======
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataAry.count == 0) {
        return 1;
    } else {
        return self.dataAry.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KLMallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KLMallCollectionViewCell class]) forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.goodName = self.dataAry[indexPath.row];
    cell.addCarBtn.hidden = self.btnHidden;
    cell.line.hidden = cell.oldPriceLab.hidden = self.oldPriceHidden;
    [self updateCollectionViewHeight:self.collectionView.collectionViewLayout.collectionViewContentSize.height];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:withContent:)]) {
        [self.delegate didSelectItemAtIndexPath:indexPath withContent:self.dataAry[indexPath.row]];
    }
}


//***  加入购物车回调  **/
- (void)didAddShoppingCarBtnChick:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didAddCarSelectItemAtIndexPath:)]) {
        [self.delegate didAddCarSelectItemAtIndexPath:indexPath];
    }
    
}


- (void)updateCollectionViewHeight:(CGFloat)height {
    if (self.heightED != height) {
        self.heightED = height;
        self.collectionView.frame = CGRectMake(0, 0, self.collectionView.frame.size.width, height);
        
        if (_delegate && [_delegate respondsToSelector:@selector(updateTableViewCellHeight:andheight:andIndexPath:)]) {
            [self.delegate updateTableViewCellHeight:self andheight:height andIndexPath:self.indexPath];
        }
    }
}

#pragma mark ====== init ======
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat spaceW = AdaptedWidth(10);
        CGFloat spaceH = AdaptedHeight(10);
        CGFloat width = (MainWidth - spaceW * 3 -AdaptedWidth(2)) / 2;

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(width, AdaptedHeight(251));
        layout.sectionInset = UIEdgeInsetsMake(spaceH, spaceW, spaceH, spaceW);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[KLMallCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([KLMallCollectionViewCell class])];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (void)setDataAry:(NSArray *)dataAry {
    //    [self.collectionView reloadData];
    self.heightED = 0;
    _dataAry = dataAry;
}


@end
