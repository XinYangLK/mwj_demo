//
//  NSDate+Extension.m
//  mwstreet
//
//  Created by 科pro on 2019/1/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

//***  传入当前年份差 年  **/
+ (NSDate *)getDate:(NSInteger)year {
   
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:[NSDate date]];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:year];
    [adcomps setMonth:0];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    NSDate * date =[dateFormatter dateFromString:beforDate];
    
    return date;
}
@end
