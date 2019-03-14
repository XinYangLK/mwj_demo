//
//  KLFlashManagerCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/28.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLFlashManagerCell : UITableViewCell

//***  商品图片  **/
@property (nonatomic, strong) NSString *goodsImg;
//***  商品名称  **/
@property (nonatomic, strong) NSString *goodsTitle;
//***  商品价格  **/
@property (nonatomic, strong) NSString *goodsPrice;
//***  商品原价格  **/
@property (nonatomic, strong) NSString *goodsOldPrice;
//***  商品限量  **/
@property (nonatomic, strong) NSString *goodsLimited;
//***  商品抢购按钮title **/
@property (nonatomic, strong) NSString *goodsFlash;


@end

NS_ASSUME_NONNULL_END
