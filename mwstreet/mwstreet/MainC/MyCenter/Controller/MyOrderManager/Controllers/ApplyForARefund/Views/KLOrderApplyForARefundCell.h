//
//  KLOrderApplyForARefundCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLOrderApplyForARefundCell : UITableViewCell
//***  商品图片  **/
@property (nonatomic, strong) UIImageView * goodsImg;
//***  商品标题  **/
@property (nonatomic, strong) UILabel * goodsNameLab;
//***  商品规格  **/
@property (nonatomic, strong) UILabel * specLab;


@property (nonatomic, strong) NSString * goodsName;

@end

NS_ASSUME_NONNULL_END
