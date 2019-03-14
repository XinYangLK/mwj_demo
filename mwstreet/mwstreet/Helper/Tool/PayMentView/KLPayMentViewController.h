//
//  KLPayMentViewController.h
//  mwstreet
//
//  Created by 科pro on 2019/1/17.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLPayMentViewController : UIViewController

- (instancetype)initTotalPay:(NSString *)totalBalance vc:(UIViewController *)vc dataSource:(NSArray *)dataSource;
//支付方式
@property (nonatomic, copy) void(^payType)(NSString *type ,NSString *balance);

@end

NS_ASSUME_NONNULL_END
