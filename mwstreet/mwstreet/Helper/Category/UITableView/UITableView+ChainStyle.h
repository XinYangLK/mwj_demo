//
//  UITableView+ChainStyle.h
//  mwstreet
//
//  Created by 科pro on 2018/12/18.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (ChainStyle)

- (UITableView *(^)(__unsafe_unretained Class))mCustomClass;

- (UITableView *(^)(__unsafe_unretained Class))mCustomFooterHeaderClass;

@end

NS_ASSUME_NONNULL_END
