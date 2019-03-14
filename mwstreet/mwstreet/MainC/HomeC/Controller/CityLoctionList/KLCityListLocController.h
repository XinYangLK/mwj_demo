//
//  KLCityListLocController.h
//  mwstreet
//
//  Created by 科pro on 2018/12/24.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
//***  选择城市回调  **/
typedef void(^ SelectLocBlock)(NSString * city);

@interface KLCityListLocController : KLBaseViewController

@property (nonatomic,copy) SelectLocBlock selectLocBlock;

@end

NS_ASSUME_NONNULL_END
