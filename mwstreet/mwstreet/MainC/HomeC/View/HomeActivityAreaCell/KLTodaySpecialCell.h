//
//  KLTodaySpecialCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLTodaySpecialCell : UITableViewCell
//***  商品图片  **/
@property (nonatomic, strong) UIImageView * goodsImg;
//***  商品名称  **/
@property (nonatomic, strong) UILabel     * goodsName;
//***  商品价格  **/
@property (nonatomic, strong) UILabel     * goodsPrice;
//***  加入购物车  **/
@property (nonatomic, strong) UIButton    * addBtn;
//***  商品原始价格  **/
@property (nonatomic, strong) UILabel     * goodsOldPrice;
//***  删除线  **/
@property (nonatomic, strong) UIView      * line;
//***  商品已售件数  **/
@property (nonatomic, strong) UILabel     * goodsSoldNum;

@end

NS_ASSUME_NONNULL_END
