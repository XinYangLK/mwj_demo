//
//  KLCellHeaderView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICountingLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLCellHeaderView : UIView

@property (nonatomic, strong) NSString * priceStr;
@property (nonatomic, strong) NSString * targetPriceStr;

@property (nonatomic, strong) UIView  * sliderBackView;
@property (nonatomic, strong) UIView  * sliderShowView;
@property (nonatomic, strong) UICountingLabel * showLable ;
@property (nonatomic, strong) UIImageView * showAngle ;




@end

NS_ASSUME_NONNULL_END
