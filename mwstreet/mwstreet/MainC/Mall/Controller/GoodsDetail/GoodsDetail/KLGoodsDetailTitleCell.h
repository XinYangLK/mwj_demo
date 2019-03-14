//
//  KLGoodsDetailTitleCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLGoodsDetailTitleCell : UITableViewCell

//***  商品名称  **/
@property (nonatomic, strong) UILabel  * goodsTitle;
//***  分享按钮  **/
@property (nonatomic, strong) UIButton * shareBtn;
//***  商品价格  **/
@property (nonatomic, strong) UILabel  * goodsPrice;
//***  商品原始价  **/
@property (nonatomic, strong) UILabel  * oldPrice;
//***  删除线  **/
@property (nonatomic, strong) UIView   * line;
//***  商品描述  **/
@property (nonatomic, strong) UILabel  * decLab;

@end

NS_ASSUME_NONNULL_END
