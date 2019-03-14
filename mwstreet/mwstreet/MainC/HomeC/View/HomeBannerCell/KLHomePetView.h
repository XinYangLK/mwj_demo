//
//  KLHomePetView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLHomePetView : UIView

@property (nonatomic, strong) UIImageView *backImg;
@property (nonatomic, strong) UIImageView *petImg;
@property (nonatomic, strong) UILabel * nickNameLab;
@property (nonatomic, strong) UILabel * nameLab;
@property (nonatomic, strong) UILabel * ageLab;

@end

NS_ASSUME_NONNULL_END
