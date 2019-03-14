//
//  UITextField+KLIndexPath.m
//  mwstreet
//
//  Created by 科pro on 2019/2/20.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "UITextField+KLIndexPath.h"

@implementation UITextField (KLIndexPath)

static char indexPathKey;
- (NSIndexPath *)indexPath{
    return objc_getAssociatedObject(self, &indexPathKey);
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    objc_setAssociatedObject(self, &indexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
