//
//  KLAddView.h
//  mwstreet
//
//  Created by 科pro on 2019/2/28.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SpecChangeBlock)(NSString * text);

@interface KLAddView : UIView

- (instancetype)initWithGoodsid:(NSString *)goodsid;

/** 隐藏选择页面*/
@property (nonatomic ,copy) void(^disBtnClick)(void);

/** 跳转购物车*/
@property (nonatomic ,copy) void(^jumpClick)(NSString *number);

@property (nonatomic,copy) SpecChangeBlock specChangeBlock;
@end

NS_ASSUME_NONNULL_END
