//
//  KLGoodsDetailCouponsCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLGoodsDetailCouponsCell : UITableViewCell

@property (nonatomic, strong) UILabel     * titleLab;
@property (nonatomic, strong) UIImageView * angleImg;
@property (nonatomic, assign) NSInteger     markCount;
@property (nonatomic, strong) NSArray     * couponImgArray;
@end

NS_ASSUME_NONNULL_END
