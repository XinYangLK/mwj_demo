//
//  KLSpellGroupGoodsDetailCell.h
//  mwstreet
//
//  Created by 科pro on 2019/3/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^JoinGroundBlock)(UIButton * sender , NSIndexPath * indexPath);

@interface KLSpellGroupGoodsDetailCell : UITableViewCell

//***  数据源  **/
@property (nonatomic, strong) NSMutableArray *dataAry;

//***  分割条  **/
@property (nonatomic, strong) UIView *speaLine;
//***  标题  **/
@property (nonatomic, strong) UILabel *titleLab;

//***  团单列表  **/
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,copy) JoinGroundBlock joinGroundBlock;

@end

NS_ASSUME_NONNULL_END
