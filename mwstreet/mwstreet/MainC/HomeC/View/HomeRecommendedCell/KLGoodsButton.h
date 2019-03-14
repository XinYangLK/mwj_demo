//
//  KLGoodsButton.h
//  mwstreet
//
//  Created by 科pro on 2018/12/21.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLGoodsButton : UIButton
//***  商品图片  **/
@property (nonatomic, strong) NSString *goodsImg;
//***  商品价格  **/
@property (nonatomic, strong) NSString *goodsPrice;
//***  商品原始价格  **/
@property (nonatomic, strong) NSString *goodsOldPrice;

@end

NS_ASSUME_NONNULL_END
