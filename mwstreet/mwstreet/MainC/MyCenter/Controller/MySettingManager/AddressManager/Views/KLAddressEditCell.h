//
//  KLAddressEditCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/21.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQXSwitch.h"
NS_ASSUME_NONNULL_BEGIN

@interface KLAddressEditCell : UITableViewCell

@property (nonatomic, strong) UILabel     * titleLab;
@property (nonatomic, strong) UITextField * inputField;

@end



@interface KLAddressChangeCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UILabel * textLab;
@property (nonatomic, strong) UIImageView * angleImg;

@end



@interface KLAddressSwitchCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleLab;

@property (nonatomic, strong) LQXSwitch * switc;

@end

NS_ASSUME_NONNULL_END
