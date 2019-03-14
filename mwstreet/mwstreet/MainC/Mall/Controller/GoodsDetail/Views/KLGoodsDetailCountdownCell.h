//
//  KLGoodsDetailCountdownCell.h
//  mwstreet
//
//  Created by 科pro on 2019/3/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLCountdownView.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLGoodsDetailCountdownCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleLab;
//***  分割线  **/
@property (nonatomic, strong) UIView  * line;

//***  倒计时view  **/
@property (nonatomic, strong) KLCountdownView  * countdownView;
@end

NS_ASSUME_NONNULL_END
