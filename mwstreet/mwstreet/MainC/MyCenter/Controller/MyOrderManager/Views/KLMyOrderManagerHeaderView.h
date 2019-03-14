//
//  KLMyOrderManagerHeaderView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/15.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLMyOrderManagerHeaderView : UITableViewHeaderFooterView
//***  店铺名称  **/
@property (nonatomic, strong) NSString *storeName;
//***  下单时间  **/
@property (nonatomic, strong) NSString *orderTime;
//***  订单状态  **/
@property (nonatomic, strong) NSString *orderStatus;


@end

NS_ASSUME_NONNULL_END
