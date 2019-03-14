//
//  KLNumberButton.h
//  mwstreet
//
//  Created by 科pro on 2019/1/24.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NumBlock)(UILabel * numLab);

@interface KLNumberButton : UIView

@property (nonatomic, strong) UILabel * minusLab;
@property (nonatomic, strong) UILabel * numLab;
@property (nonatomic, strong) UILabel * plusLab;

@property (nonatomic, copy) NumBlock numberBlock;

@end

NS_ASSUME_NONNULL_END
