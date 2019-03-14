//
//  KLEvaluationScoreView.h
//  mwstreet
//
//  Created by 科pro on 2019/3/14.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLEvaluationScoreView : UIView

//***  描述相符表题  **/
@property (nonatomic, strong) UILabel * titleLab;
//***  描述评价星数  **/
@property (nonatomic, strong) SYStarRatingView * starView;

@end

NS_ASSUME_NONNULL_END
