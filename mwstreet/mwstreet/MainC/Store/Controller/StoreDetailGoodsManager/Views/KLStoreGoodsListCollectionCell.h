//
//  KLStoreGoodsListCollectionCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/30.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLStoreGoodsListCollectionCell : UICollectionViewCell

@property (nonatomic, strong) NSString *goodsImg;

@property (nonatomic, strong) NSString *goodsName;

@property (nonatomic, strong) NSString *goodsDes;

@property (nonatomic, strong) NSString *goodsPrice;

@end


@interface KLStoreGoodsListTableCell : UICollectionViewCell

@property (nonatomic, strong) NSString *goodsImg;

@property (nonatomic, strong) NSString *goodsName;

@property (nonatomic, strong) NSString *goodsDes;

@property (nonatomic, strong) NSString *goodsPrice;

@end

NS_ASSUME_NONNULL_END
