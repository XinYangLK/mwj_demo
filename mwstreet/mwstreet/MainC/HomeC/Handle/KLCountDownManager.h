//
//  KLCountDownManager.h
//  mwstreet
//
//  Created by 科pro on 2018/12/20.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 使用单例
#define kCountDownManager [KLCountDownManager manager]
/// 倒计时的通知
#define kCountDownNotification @"CountDownNotification"

@interface KLCountDownManager : NSObject

//***  时间差(单位:秒)  **/
@property (nonatomic, assign) NSInteger timeInterval;

@property (nonatomic, strong) NSTimer *timer;

//***  使用单例  **/
+ (instancetype)manager;

//***  开始倒计时  **/
- (void)start;

//***  关闭倒计时  **/
- (void)stop;

//***  刷新倒计时  **/
- (void)reload;

@end

NS_ASSUME_NONNULL_END
