//
//  KLMallClassifyCell.h
//  mwstreet
//
//  Created by 科pro on 2018/12/29.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^Block)(UIButton * sender);
@interface KLMallClassifyCell : UITableViewCell

@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, assign) NSInteger markNumber;     // 标记
@property (nonatomic,copy)    Block     classifyBlock;
/**
 * 商城分类 items创建
 * @param  mallArray       分类标题数据
 */
- (void)setMallArray:(NSArray *)mallArray;

@end

NS_ASSUME_NONNULL_END
