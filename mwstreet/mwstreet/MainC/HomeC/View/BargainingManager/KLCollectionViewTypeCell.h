//
//  KLCollectionViewTypeCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/14.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLCollectionViewTypeCell : UICollectionViewCell

@property (nonatomic, strong) NSString * goodsImg;
@property (nonatomic, strong) NSString * goodsTitle;
@property (nonatomic, strong) NSString * goodsPrice;
@property (nonatomic, strong) NSString * goodsOldPrice;
@property (nonatomic, strong) NSString * goodsDes;
@property (nonatomic, strong) NSString * goodsBtnTitle;

@end

NS_ASSUME_NONNULL_END
