//
//  UIViewController+KLGCDCountdown.h
//  mwstreet
//
//  Created by 科pro on 2019/1/23.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TimerBlock)(id timer);
typedef void(^CountdownOverBlock)(NSString *dicKey);
typedef void(^CountdownOngoingBlock)(NSString * timeOut,NSString *dicKey);

@interface UIViewController (KLGCDCountdown)

+ (void)getTimeWithArr:(NSArray *)timeStrArr and:(NSArray *)cellIdArr timerBlock:(TimerBlock)timerBlock countdownOverBlock:(CountdownOverBlock)OverBlock countdownOngoingBlock:(CountdownOngoingBlock)OngoingBlock;


+ (void)getTimeWithStr:(NSString *)timeStr and:(NSString *)cellId timerBlock:(TimerBlock)timerBlock countdownOverBlock:(CountdownOverBlock)overBlock countdownOngoingBlock:(CountdownOngoingBlock)ongoingBlock;

@end

NS_ASSUME_NONNULL_END
