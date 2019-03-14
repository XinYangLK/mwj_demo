//
//  KLShoppingCarTableCell.h
//  mwstreet
//
//  Created by 科pro on 2018/12/29.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class KLShoppingCarTableCell;

@protocol KLShoppingCarTableCellDelegate <NSObject>

/**
 cell上选中按钮代理
 @param cell self
 @param isSelected 是否是选中状态
 @param indexPath 当前cell对应的indexPath
 */
- (void)selectCell:(KLShoppingCarTableCell *)cell selected:(BOOL)isSelected indexPath:(NSIndexPath *)indexPath;

@end




@class PPTableViewModel;


typedef void(^CellNumBlock)(UILabel * numLab,NSIndexPath * indexPath);


@interface KLShoppingCarTableCell : UITableViewCell

@property (nonatomic,copy) CellNumBlock cellNumBlock;

//***  选择按钮  **/
@property (nonatomic, strong) UIButton    * selectBtn;
//***  商品图片  **/
@property (nonatomic, strong) UIImageView * goodsImg;
//***  商品名称  **/
@property (nonatomic, strong) UILabel     * goodsName;
//***  商品规格  **/
@property (nonatomic, strong) UILabel     * goodsSpec;
//***  商品价格  **/
@property (nonatomic, strong) UILabel     * goodsPrice;

@property (nonatomic, weak) id <KLShoppingCarTableCellDelegate> delegate;
//cell对应的indexPath
@property (nonatomic, strong) NSIndexPath *indexPath;
//是否是选中对应的商品
@property (nonatomic, assign) BOOL select;


@property (nonatomic, strong) PPTableViewModel *model;

@end
NS_ASSUME_NONNULL_END



NS_ASSUME_NONNULL_BEGIN

@interface PPTableViewModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger number;
@end

NS_ASSUME_NONNULL_END

