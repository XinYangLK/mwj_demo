//
//  KLActivityAreaCell.h
//  mwstreet
//
//  Created by 科pro on 2018/12/20.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLActivityButton.h"
#import "KLCountdownView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^countDownZeroBlock)(void);

@protocol KLActivityAreaCellDelegate <NSObject>

@optional //选实现
- (void)didActivityBtnChick:(UIButton *)sender;//活动方法回调

@required //必实现

@end


@class KLCountdownModel;

@interface KLActivityAreaCell : UITableViewCell
//// 时间源
//@property (nonatomic, strong) KLCountdownModel * model;
//// 可能有的不需要倒计时,如倒计时时间已到, 或者已经过了
//@property (nonatomic, assign) BOOL               needCountDown;
//// 倒计时到0时回调
//@property (nonatomic, copy) countDownZeroBlock   countDownZero;
//背景图
@property (nonatomic, strong) UIButton         * backBtn;
//标题
@property (nonatomic, strong) UILabel          * titleLab;
//活动描述
@property (nonatomic, strong) UILabel          * decLable;
//活动图片
@property (nonatomic, strong) UIImageView      * bigImg;
//倒计时view
@property (nonatomic, strong) KLCountdownView  * countdownView;
// 今日特价
@property (nonatomic, strong) KLActivityButton * specialBtn;
// 砍价
@property (nonatomic, strong) KLActivityButton * bargainBtn;
// 9.9特价
@property (nonatomic, strong) KLActivityButton * activeBtn;

@property (nonatomic,weak) id<KLActivityAreaCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
