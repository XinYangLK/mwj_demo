//
//  KLBGoodsDetailMsgCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/27.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLBGoodsDetailMsgCell : UITableViewCell

//***  商品名称  **/
@property (nonatomic, strong) UILabel * goodsTitleLab;
//***  商品价格  **/
@property (nonatomic, strong) UILabel * goodsPriceLab;
//***  商品交易量描述  **/
@property (nonatomic, strong) UILabel * goodsDecLab;


//***  商品名称str  **/
@property (nonatomic, strong) NSString * goodsTitle;

@end

NS_ASSUME_NONNULL_END
