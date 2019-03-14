//
//  KLShopCartTool.h
//  mwstreet
//
//  Created by 科pro on 2019/2/28.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLShopCartTool : NSObject

+ (void)fetchGoodsAttributeDataSuccess:(void (^)(NSMutableArray *colorArr
                                                 ,NSMutableArray *sizeArr))success
                           codeFailure:(void (^)(NSString *codeErr))codeFailure
                               failure:(void (^)(NSError *err))failure;


@end

NS_ASSUME_NONNULL_END
