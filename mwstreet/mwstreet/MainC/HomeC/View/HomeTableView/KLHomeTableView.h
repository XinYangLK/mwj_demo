//
//  KLHomeTable.h
//  mwstreet
//
//  Created by 科pro on 2018/12/18.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLNavigationSearchView.h"  //导航View

NS_ASSUME_NONNULL_BEGIN

@interface KLHomeTableView : UIView

@property (nonatomic, strong) KLNavigationSearchView * navigationView; //导航View

@property (nonatomic, strong) UITableView * tableView; //表单

+ (instancetype)shareTable;  //单例初始化

@end

NS_ASSUME_NONNULL_END
