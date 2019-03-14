//
//  KLRefundDetailCell.h
//  mwstreet
//
//  Created by 科pro on 2019/3/4.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLRefundDetailCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) NSString * content;

@end

NS_ASSUME_NONNULL_END
