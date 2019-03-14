//
//  KLBargainDetailCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLCellHeaderView.h"
#import "KLBargainGoodsView.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLBargainDetailCell : UITableViewCell 

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSString    * cellID;
@property (nonatomic, strong) UILabel     * timerLab;
@property (nonatomic, strong) UIButton    * shareBtn;
@property (nonatomic, strong) KLCellHeaderView   * headerView;
@property (nonatomic, strong) KLBargainGoodsView * bargainGoodsView;

- (void)didPagessViewAnimationDelay:(CGFloat)delayTime Ratio:(CGFloat)ratio;

@end

NS_ASSUME_NONNULL_END
