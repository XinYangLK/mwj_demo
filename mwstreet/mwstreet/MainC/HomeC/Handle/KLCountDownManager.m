//
//  KLCountDownManager.m
//  mwstreet
//
//  Created by 科pro on 2018/12/20.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLCountDownManager.h"

@interface KLCountDownManager ()


@end

@implementation KLCountDownManager

+ (instancetype)manager {
    static KLCountDownManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KLCountDownManager alloc]init];
    });
    return manager;
}

- (void)start {
    // 启动定时器
    [self timer];
    
}
- (void)stop{
    //关闭倒计时
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)reload {
    // 刷新只要让时间差为0即可
    _timeInterval = 0;
}

- (void)timerAction {
    // 时间差+1
    self.timeInterval ++;
    // 发出通知--可以将时间差传递出去,或者直接通知类属性取
    [[NSNotificationCenter defaultCenter] postNotificationName:kCountDownNotification object:nil userInfo:@{@"TimeInterval" : @(self.timeInterval)}];
}

- (NSTimer *)timer {
    
    if (_timer == nil) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
        [_timer setFireDate:[NSDate distantPast]];
    }
    return _timer;
}

@end
