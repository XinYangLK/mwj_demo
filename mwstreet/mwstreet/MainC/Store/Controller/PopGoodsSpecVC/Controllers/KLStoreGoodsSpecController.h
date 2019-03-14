//
//  KLStoreGoodsSpecController.h
//  mwstreet
//
//  Created by 科pro on 2019/1/31.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AttributeInfoBlock)(NSDictionary * dict);

@interface KLStoreGoodsSpecController : KLBaseViewController

@property (nonatomic,copy) AttributeInfoBlock attributeInfoBlock;
/** 商品ID  */
@property (nonatomic, copy) NSString   * goodsId;
/** 商店ID  */
@property (nonatomic, assign) NSInteger storeId;
/** 商品图片  */
@property (nonatomic, copy) NSString   * goodsImg;
//***立即购买 YES 、 购物车 NO   **/
@property (nonatomic, assign) BOOL fromBuyNow;

@end

NS_ASSUME_NONNULL_END
