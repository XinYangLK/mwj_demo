//
//  KLHotCityTableViewCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HotCityBlock)(UIButton * sender);

@interface KLHotCityTableViewCell : UITableViewCell

@property (nonatomic,copy) HotCityBlock hotCityBlock;
/**
 * 自定义 cell初始化
 * @param  tableView     表
 * @param  hotCityArray  热门城市数组
 */
+ (KLHotCityTableViewCell *)initWith:(UITableView *)tableView hotCityArray:(NSArray *)hotCityArray;

@end

NS_ASSUME_NONNULL_END
