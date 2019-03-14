//
//  KLGoodsSpecPopupController.h
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLGoodsSpecPopupController : KLBaseViewController

@property (nonatomic, strong) NSDictionary *skuData;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
