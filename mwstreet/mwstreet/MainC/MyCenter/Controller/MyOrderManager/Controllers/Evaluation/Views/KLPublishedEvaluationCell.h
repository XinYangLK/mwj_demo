//
//  KLPublishedEvaluationCell.h
//  mwstreet
//
//  Created by 科pro on 2019/3/13.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLEvaluationScoreView.h"
NS_ASSUME_NONNULL_BEGIN

@interface KLPublishedEvaluationCell : UITableViewCell

//***  描述相符  **/
@property (nonatomic, strong) KLEvaluationScoreView * desScoreView;
//***  物流服务  **/
@property (nonatomic, strong) KLEvaluationScoreView * logScoreView;
//***  服务态度  **/
@property (nonatomic, strong) KLEvaluationScoreView * serScoreView;
//***  评价输入框  **/
@property (nonatomic, strong) UITextView * remarksView ;
@end

NS_ASSUME_NONNULL_END
