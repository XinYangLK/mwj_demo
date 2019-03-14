//
//  KLMyDisInputView.h
//  mwstreet
//
//  Created by 科pro on 2019/2/2.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLMyDisInputConfigure.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^SexChangeBlock)(UIButton * button);

@interface KLMyDisInputView : UIView

@property (nonatomic, strong) UITextField * textField;

@property (nonatomic,copy) SexChangeBlock sexChangeBlock;

- (instancetype)initWithConfigure:(KLMyDisInputConfigure *)configure;


@end

NS_ASSUME_NONNULL_END
