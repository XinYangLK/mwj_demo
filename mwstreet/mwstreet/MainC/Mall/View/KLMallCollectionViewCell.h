//
//  KLMallCollectionViewCell.h
//  mwstreet
//
//  Created by 科pro on 2018/12/29.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KLMallCollectionViewCellDelegate <NSObject>

@optional //选实现
- (void)didAddShoppingCarBtnChick:(NSIndexPath *)indexPath;//加入购物车方法回调

@required //必实现

@end


@interface KLMallCollectionViewCell : UICollectionViewCell

//***  商品名称  **/
@property (nonatomic, strong) NSString    * goodName;

//***  商品旧价格  **/
@property (nonatomic, strong) UILabel     * oldPriceLab;
//***  删除线  **/
@property (nonatomic, strong) UIView      * line;

@property (nonatomic, strong) NSIndexPath * indexPath ;

//***  加入购物车  **/
@property (nonatomic, strong) UIButton   * addCarBtn;
@property (nonatomic,weak) id<KLMallCollectionViewCellDelegate> delegate;

@end







@interface KLMallTableViewCell : UICollectionViewCell

//***  商品名称  **/
@property (nonatomic, strong) NSString    * goodName;
//***  商品旧价格  **/
@property (nonatomic, strong) NSString    * oldPrice;
//***  删除线  **/
@property (nonatomic, strong) UIView      * line;
//***  商品旧价格  **/
@property (nonatomic, strong) UILabel     * oldPriceLab;
//***  加入购物车  **/
@property (nonatomic, strong) UIButton   * addCarBtn;

@property (nonatomic, strong) NSIndexPath * indexPath ;

@property (nonatomic,weak) id<KLMallCollectionViewCellDelegate> delegate;

@end


NS_ASSUME_NONNULL_END
