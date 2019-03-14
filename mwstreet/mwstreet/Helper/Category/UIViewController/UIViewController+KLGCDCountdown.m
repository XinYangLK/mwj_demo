//
//  UIViewController+KLGCDCountdown.m
//  mwstreet
//
//  Created by 科pro on 2019/1/23.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "UIViewController+KLGCDCountdown.h"

@interface UIViewController ()

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation UIViewController (KLGCDCountdown)

+ (void)getTimeWithArr:(NSArray *)timeStrArr and:(NSArray *)cellIdArr timerBlock:(TimerBlock)timerBlock countdownOverBlock:(CountdownOverBlock)overBlock countdownOngoingBlock:(CountdownOngoingBlock)ongoingBlock;{
    
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    
    [timeStrArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __block int timeout=[timeStrArr[idx] intValue]; //倒计时时间
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        timerBlock(timer);
        dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        
        dispatch_source_set_event_handler(timer, ^{
            
            if(timeout<0){ //倒计时结束，关闭
                dispatch_source_cancel(timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    overBlock(cellIdArr[idx]);
                    
                });
            }else{
                NSString * timerOut =[NSString stringWithFormat:@"%d",timeout];

                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    ongoingBlock(timerOut,cellIdArr[idx]);
                    
                });
                timeout--;
            }
        });
        dispatch_resume(timer);
    }];
}


+ (void)getTimeWithStr:(NSString *)timeStr and:(NSString *)cellId timerBlock:(TimerBlock)timerBlock countdownOverBlock:(CountdownOverBlock)overBlock countdownOngoingBlock:(CountdownOngoingBlock)ongoingBlock {

    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    
    __block int timeout=[timeStr intValue]; //倒计时时间
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    timerBlock(timer);
    
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(timer, ^{
        
        if(timeout<0){ //倒计时结束，关闭
            
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                overBlock(cellId);
            });
        }else{
            NSString * timerOut =[NSString stringWithFormat:@"%d",timeout];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                ongoingBlock(timerOut,cellId);

            });
            timeout--;
        }
    });
    dispatch_resume(timer);
}

@end
