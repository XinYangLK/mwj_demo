//
//  KLActivityButton.h
//  mwstreet
//
//  Created by 科pro on 2018/12/20.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//活动btn类型枚举
typedef NS_ENUM(NSInteger, ActivityType) {
    ActivityHorizontalType, //水平布局btn类型
    ActivityVerticalType,   //垂直布局btn类型
};

@interface KLActivityButton : UIButton

@property (nonatomic, strong) UILabel     * titleLab; //标题
@property (nonatomic, strong) UILabel     * decLable; //活动描述
@property (nonatomic, strong) UIImageView * bigImg;   //活动图片

//***  初始化按钮类型  **/
- (instancetype)initActivityType:(ActivityType)type;

@end

NS_ASSUME_NONNULL_END
