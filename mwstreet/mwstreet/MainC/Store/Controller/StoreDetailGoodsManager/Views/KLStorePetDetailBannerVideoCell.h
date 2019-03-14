//
//  KLStorePetDetailBannerVideoCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/19.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSVideoPlayback.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZFTableViewCellDelegate <NSObject>

- (void)zf_playTheVideoAtIndexPath:(NSIndexPath *)indexPath;

@end

typedef void(^PlaerCellPauseBlock)(BOOL plaerStatus);

@interface KLStorePetDetailBannerVideoCell : UITableViewCell

@property (nonatomic,strong) TSVideoPlayback *video;

@property (nonatomic, copy) void(^playCallback)(void);
//***  滚动出轮播，视频停止  **/
@property (nonatomic, copy) PlaerCellPauseBlock plaerCellPauseBlock;

- (void)setDelegate:(id<ZFTableViewCellDelegate>)delegate withIndexPath:(NSIndexPath *)indexPath;


@end







#pragma mark - 宠物名称，价格
@interface KLPetNamePriceCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UILabel * priceLab;


@end




#pragma mark - 宠物信息
@interface KLPetDetailMsgCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UILabel * textLab;

@end





typedef void(^PushStoreBlock)(UIButton * sender);
@interface KLPetStoreCell : UITableViewCell

//进入店铺点击回调
@property (nonatomic,copy) PushStoreBlock pushStoreBlock;
//店铺图片
@property (nonatomic, strong) UIImageView      * storeImg;
//店铺名称
@property (nonatomic, strong) UILabel          * titleLab;
//评价星数
@property (nonatomic, strong) SYStarRatingView * starView;
//评分
@property (nonatomic, strong) UILabel          * scoreLab;
//距离
@property (nonatomic, strong) UILabel          * distanceLab;
//进入店铺
@property (nonatomic, strong) UIButton         * pushBtn;

@end



@interface KLPetLikeListCell : UITableViewCell

@property (nonatomic, strong) NSString *goodsImg;

@property (nonatomic, strong) NSString *goodsName;

@property (nonatomic, strong) NSString *goodsDes;

@property (nonatomic, strong) NSString *goodsPrice;


@end

NS_ASSUME_NONNULL_END
