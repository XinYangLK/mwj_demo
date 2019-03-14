//
//  KLEvaluationHeaderView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/24.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLEvaluationHeaderView : UITableViewHeaderFooterView


+ (KLEvaluationHeaderView *)initWith:(UITableView *)tableView tagArray:(NSArray *)tagArray;

- (CGFloat)headerForHeight;
@end

NS_ASSUME_NONNULL_END
