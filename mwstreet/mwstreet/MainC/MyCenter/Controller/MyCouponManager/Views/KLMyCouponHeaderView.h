//
//  KLMyCouponHeaderView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/11.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ExchangeBlock)(UIButton * sender);

@interface KLMyCouponHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton * exchangeBtn;
@property (nonatomic,copy) ExchangeBlock exchangeBlock;
@end

NS_ASSUME_NONNULL_END
