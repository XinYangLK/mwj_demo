//
//  KLMallCollectionTableCell.h
//  mwstreet
//
//  Created by 科pro on 2018/12/29.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class KLMallCollectionTableCell;
@protocol KLMallCollectionTableDelegate <NSObject>

/**
 * 动态改变UITableViewCell的高度
 */
- (void)updateTableViewCellHeight:(KLMallCollectionTableCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;

/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content;

/**
 * 点击UICollectionViewCell 加入购物车的代理方法
 */
- (void)didAddCarSelectItemAtIndexPath:(NSIndexPath *)indexPath;


@end


@interface KLMallCollectionTableCell : UITableViewCell

@property (nonatomic, weak) id<KLMallCollectionTableDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSArray *dataAry;

@property (nonatomic, assign) BOOL btnHidden;
@property (nonatomic, assign) BOOL oldPriceHidden;

@end

NS_ASSUME_NONNULL_END
