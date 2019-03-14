//
//  KLShopCartTool.m
//  mwstreet
//
//  Created by 科pro on 2019/2/28.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLShopCartTool.h"
#import "KLGoodsAttributeModel.h"
@implementation KLShopCartTool

+ (void)fetchGoodsAttributeDataSuccess:(void (^)(NSMutableArray *colorArr
                                                 ,NSMutableArray *sizeArr))success
                           codeFailure:(void (^)(NSString *codeErr))codeFailure
                               failure:(void (^)(NSError *err))failure{
    
    NSDictionary *colorDic =
    @{
      @"code":@"1",
      @"msg":@"\u8bdd\u9898\u8be6\u60c5",
      @"result":
          @[
              @{
                  @"attr_price" : @"",
                  @"attr_value" : @"红色",
                  @"goods_attr_id" : @263,
                  },
              @{
                  @"attr_price" : @"",
                  @"attr_value" : @"紫色",
                  @"goods_attr_id" : @262,
                  },
              @{
                  @"attr_price" : @"",
                  @"attr_value" : @"灰色",
                  @"goods_attr_id" : @259,
                  },
              @{
                  @"attr_price" : @"",
                  @"attr_value" : @"粉色",
                  @"goods_attr_id" : @1422,
                  },
              @{
                  @"attr_price" : @"",
                  @"attr_value" : @"蓝色",
                  @"goods_attr_id" : @1423,
                  },
              ]
      };
    
    NSDictionary *sizeDic =
    @{
      @"code":@"1",
      @"msg":@"\u8bdd\u9898\u8be6\u60c5",
      @"result":
          @[
              @{
                  @"attr_price" : @"",
                  @"attr_value" : @"X",
                  @"goods_attr_id" : @263,
                  },
              @{
                  @"attr_price" : @"",
                  @"attr_value" : @"L",
                  @"goods_attr_id" : @262,
                  },
              @{
                  @"attr_price" : @"",
                  @"attr_value" : @"XXL",
                  @"goods_attr_id" : @259,
                  },
              @{
                  @"attr_price" : @"",
                  @"attr_value" : @"M",
                  @"goods_attr_id" : @1422,
                  },
              @{
                  @"attr_price" : @"",
                  @"attr_value" : @"XXXL",
                  @"goods_attr_id" : @1423,
                  },
              ]
      };
    
    /* 这里推荐用mj进行解析， 为了直观这里就先手动解析吧*/
    
    
//    KLGoodsAttributeModel * colorModel = [KLGoodsAttributeModel mj_objectWithKeyValues:colorDic[@"result"]];
//    NSMutableArray *arr1 = [NSMutableArray array];
//    [colorModel enumerateObjectsUsingBlock:^(KLGoodsAttributeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [arr1 addObject:colorModel];
//    }];
    
    // 颜色
    NSMutableArray *arr1 = [NSMutableArray array];
    for (NSMutableDictionary *dic in colorDic[@"result"]) {
        KLGoodsAttributeModel *colorModel = [[KLGoodsAttributeModel alloc]init];
        colorModel.attr_value    = dic[@"attr_value"];
        colorModel.attr_price    = dic[@"attr_price"];
        colorModel.goods_attr_id = dic[@"goods_attr_id"];
        [arr1 addObject:colorModel];
    }
    // 尺寸
    NSMutableArray *arr2 = [NSMutableArray array];
    for (NSMutableDictionary *dic in sizeDic[@"result"]) {
        KLGoodsAttributeModel *colorModel = [[KLGoodsAttributeModel alloc]init];
        colorModel.attr_value    = dic[@"attr_value"];
        colorModel.attr_price    = dic[@"attr_price"];
        colorModel.goods_attr_id = dic[@"goods_attr_id"];
        [arr2 addObject:colorModel];
    }
    
    success(arr1,arr2);
}
@end
