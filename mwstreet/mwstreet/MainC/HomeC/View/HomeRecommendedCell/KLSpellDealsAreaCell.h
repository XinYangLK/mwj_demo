//
//  KLSpellDealsAreaCell.h
//  mwstreet
//
//  Created by 科pro on 2018/12/21.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KLScrollActivityView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CellMoreBlock)(UIButton * button,NSIndexPath *indexPath);
typedef void(^GoodsBlock)(UIButton * button,NSIndexPath *indexPath);

@interface KLSpellDealsAreaCell : UITableViewCell

//***  更多 ->按钮点击事件  **/
@property (nonatomic,copy) CellMoreBlock   cellMoreBlock;
//***  滑动商品 ->按钮点击事件  **/
@property (nonatomic,copy) GoodsBlock  goodsBlock;

//***  cell-- UI View  **/
@property (nonatomic, strong) KLScrollActivityView * activityView;

@property (nonatomic, strong) NSIndexPath * indexPath;

//***  创建 cell  **/
+ (KLSpellDealsAreaCell *)initWith:(UITableView *)tableView title:(NSString *)title text:(NSString *)text goodsArray:(NSArray *)goodsArray hidden:(BOOL)hidden;


@end
NS_ASSUME_NONNULL_END
