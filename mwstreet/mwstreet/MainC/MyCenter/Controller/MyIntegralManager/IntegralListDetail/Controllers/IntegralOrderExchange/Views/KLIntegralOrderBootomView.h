//
//  KLIntegralOrderBootomView.h
//  mwstreet
//
//  Created by 科pro on 2019/2/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConfirmBlock)(UIButton * sender);
@interface KLIntegralOrderBootomView : UIView

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, copy  ) ConfirmBlock confirmBlock;
@end

NS_ASSUME_NONNULL_END
