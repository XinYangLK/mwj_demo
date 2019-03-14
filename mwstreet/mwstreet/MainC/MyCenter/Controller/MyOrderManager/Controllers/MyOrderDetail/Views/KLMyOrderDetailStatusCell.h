//
//  KLMyOrderDetailStatusCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLMyOrderDetailStatusCell : UITableViewCell
//***  订单状态  **/
@property (nonatomic, strong) UILabel * titleLab;
//***  订单描述  **/
@property (nonatomic, strong) UILabel * textLab;

@end


@interface KLMyOrderDetailAddressCell : UITableViewCell

//***  收货人  **/
@property (nonatomic, strong) UILabel * nameLab;
//***  地址  **/
@property (nonatomic, strong) UILabel * addressLab;

@end




@interface KLMyOrderDetailMsgCell : UITableViewCell

//***  标题  **/
@property (nonatomic, strong) UILabel * titleLab;
//***  信息  **/
@property (nonatomic, strong) UILabel * msgLab;

@end



NS_ASSUME_NONNULL_END
