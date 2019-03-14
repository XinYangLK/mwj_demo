//
//  KLClassifyTableViewCell.h
//  mwstreet
//
//  Created by 科pro on 2018/12/20.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLHomeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLClassifyTableViewCell : UITableViewCell

@property (nonatomic,weak) id<KLHomeProtocol> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;   //cell indexPath

@property (nonatomic, assign) NSInteger markNumber;     // 标记

/**
 * 首页分类 items创建
 * @param  btnArray       分类标题数据
 */
- (void)setBtnArray:(NSArray *)btnArray;


@end

NS_ASSUME_NONNULL_END
