//
//  KLGoodsDetailController.h
//  mwstreet
//
//  Created by 科pro on 2019/1/4.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLGoodsDetailController : KLBaseViewController
//***  0常规商品详情   2限时抢购商品详情  3拼团商品详情**/
@property (nonatomic, assign) NSInteger detailType;

@end

NS_ASSUME_NONNULL_END
