//
//  KLGoodsDetailEvaHeaderCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLGoodsDetailEvaHeaderCell : UITableViewCell
//***  评价数量  **/
@property (nonatomic, strong) UILabel *titleLab;
//***  好评比  **/
@property (nonatomic, strong) UILabel * evaRatioLab;
//***  导航三角  **/
@property (nonatomic, strong) UIImageView *angleImg;

@end

NS_ASSUME_NONNULL_END
