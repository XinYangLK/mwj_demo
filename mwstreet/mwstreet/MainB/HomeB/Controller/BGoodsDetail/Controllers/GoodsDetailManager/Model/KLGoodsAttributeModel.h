//
//  KLGoodsAttributeModel.h
//  mwstreet
//
//  Created by 科pro on 2019/2/28.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLGoodsAttributeModel : NSObject
#pragma mark - 颜色相关
// 价格
@property (nonatomic ,strong) NSString *attr_price;
// 属性
@property (nonatomic ,strong) NSString *attr_value;
// id
@property (nonatomic ,strong) NSString *goods_attr_id;


@end

NS_ASSUME_NONNULL_END
