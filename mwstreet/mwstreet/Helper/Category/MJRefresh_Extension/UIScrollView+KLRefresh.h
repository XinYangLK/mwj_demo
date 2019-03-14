//
//  UIScrollView+KLRefresh.h
//  mwstreet
//
//  Created by 科pro on 2018/12/25.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLMJRefreshDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (KLRefresh)

#pragma mark - 添加方法
/**
 *  增加一个header
 *
 *  @param headerClassName 自定义的header刷新样式类的名称，如果为nil则为默认的刷新样式
 *  @param beginRefresh    是不是要在第一次进入的时候自动开始刷新
 *  @param delegate        刷新回调的代理
 *  @param animation       是不是要在第一次进入的时候显示动画（必须beginRefresh为YES的情况下才有效）
 */
- (void)addHeaderWithHeaderClass:(NSString *)headerClassName beginRefresh:(BOOL)beginRefresh delegate:(id<KLMJRefreshDelegate>)delegate animation:(BOOL)animation;
/**
 *  增加一个footer
 *
 *  @param footerClassName      自定义的footer刷新样式类的名称，如果为nil则为默认的刷新样式
 *  @param automaticallyRefresh 是不是要在滑动到底部的时候自动加载更多
 *  @param delegate             刷新回调的代理
 */
- (void)addFooterWithFooterClass:(NSString *)footerClassName automaticallyRefresh:(BOOL)automaticallyRefresh delegate:(id<KLMJRefreshDelegate>)delegate;

#pragma mark - 开始刷新
/** 开始刷新header*/
- (void)beginHeaderRefresh;
/** 开始刷新footer*/
- (void)beginFooterRefresh;

#pragma mark - 结束刷新
/** 结束刷新header*/
- (void)endHeaderRefresh;

/** 结束刷新Footer*/
-(void)endFooterRefresh;

#pragma mark - 结束刷新 && 要使用pageNum,通过控制change属性来改变pagenum
/** 结束刷新Header，并且是不是要改变pageIndex（eg:刷新失败的时候就不用改变）*/
-(void)endHeaderRefreshWithChangePageIndex:(BOOL)change;

/** 结束刷新footer，并且是不是要改变pageIndex（eg:刷新失败的时候就不用改变）*/
- (void)endFooterRefreshWithChangePageIndex:(BOOL)change;

#pragma mark - 没有数据
/** 显示@"已经全部加载完毕"，并且不会再有下拉加载更多功能*/
- (void)noMoreData;
/** 重置@"已经全部加载完毕"*/
- (void)resetNoMoreData;

#pragma mark - 移除刷新
/** 移除刷新Header*/
- (void)removeHeaderRefresh;
/** 移除刷新Footer*/
- (void)removeFooterRefresh;

/** pagenum重新计数*/
- (void)resetPageNum;

@end

NS_ASSUME_NONNULL_END
