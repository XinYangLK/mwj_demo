//
//  KLStockBillViewCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/26.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLNumberButton.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectBlock)(UIButton * sender);

typedef void(^StockBillNumberBlock)(UILabel * numLab,NSIndexPath * indexPath);

@interface KLStockBillViewCell : UITableViewCell

//***  选择 勾选框  **/
@property (nonatomic, strong) UIButton    * selectBtn;
//***  选择 勾选框回调  **/
@property (nonatomic, copy  ) SelectBlock   selectBlock;
//***  商品图片  **/
@property (nonatomic, strong) UIImageView * goodsImg;
//***  商品标题  **/
@property (nonatomic, strong) UILabel  * goodsTitleLab;
//***  商品规格  **/
@property (nonatomic, strong) UILabel  * specLab;
//***  商品库存  **/
@property (nonatomic, strong) UILabel  * stockLab;
//***  商品价格  **/
@property (nonatomic, strong) UILabel  * priceLab;
//***  加减数量  **/
@property (nonatomic, strong) KLNumberButton * numberButton;
//***  数量点击回调  **/
@property (nonatomic,copy) StockBillNumberBlock numberBlock;

//cell对应的indexPath
@property (nonatomic, strong) NSIndexPath *indexPath;
//是否是选中对应的商品
@property (nonatomic, assign) BOOL select;


@property (nonatomic, strong) NSString *goodsTitle;

@end

NS_ASSUME_NONNULL_END
