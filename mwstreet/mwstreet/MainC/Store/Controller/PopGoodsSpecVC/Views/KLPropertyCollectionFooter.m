//
//  KLPropertyCollectionFooter.m
//  mwstreet
//
//  Created by 科pro on 2019/1/31.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLPropertyCollectionFooter.h"

@implementation KLPropertyCollectionFooter

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = [UIColor whiteColor];
        [self line];
    }
    return self;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.bottom.right.offset(0);
                                     make.height.offset(1);
                                 }];
    }
    return _line;
}


@end
