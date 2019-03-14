//
//  KLGoodsDetailProtocol.h
//  mwstreet
//
//  Created by 科pro on 2018/12/25.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KLGoodsDetailProtocol <NSObject>

@optional //选实现
/**
 * 导航返回按钮
 */
- (void)popViewController;

/**
 * 商品详情导航view 商品，评价，详情 按钮响应
 * sender.tag ==>> 1~3;
 */
- (void)navigationViewBtnChick:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END
