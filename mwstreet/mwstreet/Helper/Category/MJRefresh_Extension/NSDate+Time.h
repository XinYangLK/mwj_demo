//
//  NSDate+Time.h
//  mwstreet
//
//  Created by 科pro on 2018/12/25.
//  Copyright © 2018 xunben. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Time)

/**
 * 刷新时间格式化
 * @param  timeInterval 时间
 */
+ (NSString *)timeStringWithTimeInterval:(NSDate *)timeInterval;


@end

NS_ASSUME_NONNULL_END
