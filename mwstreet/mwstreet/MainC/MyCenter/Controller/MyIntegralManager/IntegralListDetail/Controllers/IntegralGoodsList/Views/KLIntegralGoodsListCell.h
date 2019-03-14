//
//  KLIntegralGoodsListCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ExchangeBlock)(NSIndexPath * indexPath);

@interface KLIntegralGoodsListCell : UITableViewCell

@property (nonatomic, strong) UIView *line;
//***  商品图片  **/
@property (nonatomic, strong) UIImageView * ImgV;
//***  商品名称 **/
@property (nonatomic, strong) UILabel     * titleLab;
//***  萌豆标题  **/
@property (nonatomic, strong) UILabel     * textLab;
//***  萌豆数量  **/
@property (nonatomic, strong) UILabel     * numLab;
//***  兑换按钮  **/
@property (nonatomic, strong) UIButton    * exchangeBtn;
//***  兑换回调  **/
@property (nonatomic, copy)   ExchangeBlock exchangeBlock;
//***  点击当前cell indexPath  **/
@property (nonatomic, strong) NSIndexPath * indexPath;

@end

NS_ASSUME_NONNULL_END
