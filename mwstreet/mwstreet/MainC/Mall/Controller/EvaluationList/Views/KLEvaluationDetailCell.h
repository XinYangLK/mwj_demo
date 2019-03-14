//
//  KLEvaluationDetailCell.h
//  mwstreet
//
//  Created by 科pro on 2019/3/12.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLEvaluationDetailCell : UITableViewCell
//***  图像  **/
@property (nonatomic, strong) UIImageView *imgV;
//***  名称  **/
@property (nonatomic, strong) UILabel * nameLab;
//***  评价时间 ..描述  **/
@property (nonatomic, strong) UILabel * desLab;
//***  评价星数  **/
@property (nonatomic, strong) SYStarRatingView * starView;
//***  评价内容  **/
@property (nonatomic, strong) UILabel  * contentLab;
//***  评价内容  **/
@property (nonatomic, strong) NSString * contentStr;

@end




@interface KLEvaluationDetailBannerCell : UITableViewCell

@property (nonatomic, strong) SDCycleScrollView * carouselView;


@end


@interface KLEvaluationDetailGoodsCell : UITableViewCell
//***  商品图片  **/
@property (nonatomic, strong) UIImageView  * goodsImgV;
//***  商品名称  **/
@property (nonatomic, strong) UILabel      * titleLab;
@property (nonatomic, strong) NSString     * goodName;
//***  商品价格  **/
@property (nonatomic, strong) UILabel      * priceLab;

@end





typedef void(^SecondaryPraiseBlock)(UIButton * sender ,NSIndexPath * indexPath);

@interface KLEvaluationDetailListCell : UITableViewCell
//***  图像  **/
@property (nonatomic, strong) UIImageView *imgV;
//***  名称  **/
@property (nonatomic, strong) UILabel * nameLab;
//***  评价时间 ..描述  **/
@property (nonatomic, strong) UILabel * timeLab;
//***  点赞按钮  **/
@property (nonatomic, strong) UIButton    * praiseBtn;
//***  点赞按钮当前cell  **/
@property (nonatomic, strong) NSIndexPath * indexPath;
//***  点赞按钮回调  **/
@property (nonatomic, copy)   SecondaryPraiseBlock  secondaryPraiseBlock;
//***  评价内容  **/
@property (nonatomic, strong) UILabel  * contentLab;
//***  评价内容  **/
@property (nonatomic, strong) NSString * contentStr;


@end

NS_ASSUME_NONNULL_END
