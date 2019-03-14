//
//  KLMJRefreshDelegate.h
//  mwstreet
//
//  Created by 科pro on 2018/12/25.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KLMJRefreshDelegate <NSObject>

/**
 *    下拉 重新加载数据
 */
- (void)onRefreshing:(id)control;

@optional
/**
 *    上拉 加载更多数据
 */
- (void)onLoadingMoreData:(id)control pageNum:(NSNumber *)pageNum;

@end

NS_ASSUME_NONNULL_END
