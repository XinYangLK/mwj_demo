//
//  KLMyCouponListCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/11.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^UseCouponBlock)(UIButton * sender, NSIndexPath * indexPath);

@interface KLMyCouponListCell : UITableViewCell

//***  背景图大  **/
@property (nonatomic, strong) UIImageView * bigImgView;
//***  优惠券金额  **/
@property (nonatomic, strong) UILabel     * priceLab;
//***  限制条件  **/
@property (nonatomic, strong) UILabel     * limitLab;
//***  背景线  **/
@property (nonatomic, strong) UIView      * line;
//***  背景图小  **/
@property (nonatomic, strong) UIImageView * smallImgView;
//***  满减金额  **/
@property (nonatomic, strong) UILabel     * totalLab;
//***  立即使用按钮  **/
@property (nonatomic, strong) UIButton    * useCouponBtn;
//***  时效限制  **/
@property (nonatomic, strong) UILabel     * timeLab;

@property (nonatomic, strong) NSIndexPath * indexPath;

@property (nonatomic,  copy ) UseCouponBlock useCouponBlock;

@end

NS_ASSUME_NONNULL_END
