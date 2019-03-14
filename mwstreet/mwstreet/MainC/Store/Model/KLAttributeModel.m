//
//  KLAttributeModel.m
//  mwstreet
//
//  Created by 科pro on 2019/1/31.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLAttributeModel.h"


@implementation AttributeInfo

@end

@implementation Attribute

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"info": @"AttributeInfo"
             };
}
@end


@implementation AttributeCategery

@end



@implementation KLAttributeModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"spec": @"AttributeCategery",
             @"list": @"Attribute",
             };
}

@end
