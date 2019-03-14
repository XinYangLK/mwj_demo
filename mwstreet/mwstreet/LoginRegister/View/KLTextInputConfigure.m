//
//  KLTextInputConfigure.m
//  mwstreet
//
//  Created by 科pro on 2019/1/17.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLTextInputConfigure.h"

@implementation KLTextInputConfigure

- (instancetype)init {
    if (self = [super init]) {
        [self initialization];
    }
    return self;
}
- (void)initialization {
    _security = NO;
}

+ (instancetype)textInputConfigure {
    return [[self alloc] init];
}


- (UIColor *)boxColor {
    if (!_boxColor) {
        _boxColor = MainColor;
    }
    return _boxColor;
}


@end
