//
//  KLHomePresent.h
//  mwstreet
//
//  Created by 科pro on 2018/12/19.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLHomeProtocol.h"
typedef void(^successBlock)(NSArray * array);
NS_ASSUME_NONNULL_BEGIN

@interface KLHomePresent : NSObject<KLHomeProtocol>

@property (nonatomic,copy) successBlock successBlock;

//***  加载数据  **/
- (void)loadData;

@end

NS_ASSUME_NONNULL_END
