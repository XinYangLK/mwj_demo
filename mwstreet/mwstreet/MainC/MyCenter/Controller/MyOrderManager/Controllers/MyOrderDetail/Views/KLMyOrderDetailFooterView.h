//
//  KLMyOrderDetailFooterView.h
//  mwstreet
//
//  Created by 科pro on 2019/2/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BootomBlock)(UIButton * sender);
@interface KLMyOrderDetailFooterView : UIView

@property (nonatomic, strong) UIButton * leftBtn;
@property (nonatomic, strong) UIButton * centerBtn;
@property (nonatomic, strong) UIButton * rightBtn;
@property (nonatomic, copy  ) BootomBlock bootomBlock;
@end

NS_ASSUME_NONNULL_END
