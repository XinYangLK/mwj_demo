//
//  KLOrderTypeManagerCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/15.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLOrderTypeManagerCell : UITableViewCell
//***  商品图片  **/
@property (nonatomic, strong) NSString * goodsImg;
//***  商品b名称  **/
@property (nonatomic, strong) NSString * goodsTitle;
//***  商品价格  **/
@property (nonatomic, strong) NSString * goodsPrice;
//***  商品描述  **/
@property (nonatomic, strong) NSString * goodsDes;
//***  订单状态  **/
@property (nonatomic, strong) NSString * goodsStatus;

@end

NS_ASSUME_NONNULL_END
