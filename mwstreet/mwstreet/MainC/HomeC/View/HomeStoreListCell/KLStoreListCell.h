//
//  KLStoreListCell.h
//  mwstreet
//
//  Created by 科pro on 2018/12/21.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLStoreListCell : UITableViewCell
//商品图
@property (nonatomic, strong) UIImageView      * goodsImg;
//商品名称
@property (nonatomic, strong) UILabel          * titleLab;
//评价星数
@property (nonatomic, strong) SYStarRatingView * starView;
//距离
@property (nonatomic, strong) UILabel          * distanceLab;
//图标
@property (nonatomic, strong) UIImageView      * locImg;
//地址
@property (nonatomic, strong) UILabel          * addressLab;
//分割y条
@property (nonatomic, strong) UIView           * botomLine;
@end

NS_ASSUME_NONNULL_END
