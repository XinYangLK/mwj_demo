//
//  KLCarouselBannerCell.h
//  mwstreet
//
//  Created by 科pro on 2018/12/19.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWCarousel.h"
#import "KLHomePetView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol KLCarouselBannerCellDelegate <NSObject>

@optional //选实现
- (void)tapBtnChick;//悬浮view方法回调

@required //必实现


@end


@interface KLCarouselBannerCell : UITableViewCell<CWCarouselDatasource,CWCarouselDelegate>
@property (nonatomic, assign) NSInteger     markIndex; //执行标记
@property (nonatomic, strong) NSArray     * imageArr;  //轮播图数组
@property (nonatomic, strong) CWCarousel  * carousel;  //轮播图组件
@property (nonatomic, strong) KLHomePetView * cerView;   //悬浮view
@property (nonatomic,weak) id<KLCarouselBannerCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
