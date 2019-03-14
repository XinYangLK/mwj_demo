//
//  UITableView+ChainStyle.m
//  mwstreet
//
//  Created by 科pro on 2018/12/18.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "UITableView+ChainStyle.h"

@implementation UITableView (ChainStyle)

- (UITableView *(^)(__unsafe_unretained Class))mCustomClass{
    return ^id(id Class){
        [self registerClass:Class forCellReuseIdentifier:NSStringFromClass(Class)];
        return self;
    };
}

- (UITableView *(^)(__unsafe_unretained Class))mCustomFooterHeaderClass{
    return ^id(id Class){
        [self registerClass:Class forHeaderFooterViewReuseIdentifier:NSStringFromClass(Class)];
        return self;
    };
}
@end
