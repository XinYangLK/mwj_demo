//
//  KLAdvertisingBannerCell.h
//  mwstreet
//
//  Created by 科pro on 2018/12/21.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SGAdvertScrollView/SGAdvertScrollView.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLAdvertisingBannerCell : UITableViewCell

@property (nonatomic, strong) SDCycleScrollView  * adCarouselView; //广告横向轮播图

@property (nonatomic, strong) UIImageView * adImg;                 //广告滚动图标
@property (nonatomic, strong) UIView      * line;                  //广告滚动分割线
@property (nonatomic, strong) SGAdvertScrollView * adScrollView;   //广告滚动头条

@end

NS_ASSUME_NONNULL_END
