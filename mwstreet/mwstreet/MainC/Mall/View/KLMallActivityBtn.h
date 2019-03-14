//
//  KLMallActivityBtn.h
//  mwstreet
//
//  Created by 科pro on 2018/12/29.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//活动btn类型枚举
typedef NS_ENUM(NSInteger, ActivityType) {
    ActivityHorizontalType, //水平布局btn类型
    ActivityVerticalType,   //垂直布局btn类型
};

@interface KLMallActivityBtn : UIButton

//***  文字底图  **/
@property (nonatomic, strong) UIImageView *imgV;
//***  标题  **/
@property (nonatomic, strong) UILabel *titleLab;
//***  活动描述  **/
@property (nonatomic, strong) UILabel *decLab;
//***  商品图  **/
@property (nonatomic, strong) UIImageView *goodsImg;


@property (nonatomic, assign) ActivityType type;

//***  活动btn类型枚举 **/
- (instancetype)initActivityType:(ActivityType)type ;
@end

NS_ASSUME_NONNULL_END
