//
//  KLTabBarController.h
//  mengWuStreet
//
//  Created by 科pro on 2018/12/14.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

//类型枚举
typedef NS_ENUM(NSInteger, MerchantsType) {
    MerchantsTypeC, //C 端控制器类型
    MerchantsTypeB, //B 端控制器类型
};

@interface KLTabBarController : UITabBarController

//***  B 端界面 tabbar 控制器  **/
+ (instancetype)ShareTabbarMerchantsTypeB:(MerchantsType)type;
//***  C 端界面 tabbar 控制器  **/
+ (instancetype)ShareTabbarMerchantsTypeC:(MerchantsType)type;

@end

NS_ASSUME_NONNULL_END
