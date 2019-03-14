//
//  KLMyDistributionCenterCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/1.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLMultipleColumnsTVCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLMyDistributionCenterCell : UITableViewCell

@property (nonatomic, strong) KLMultipleColumnsTVCell * tvCellView;

@property (nonatomic,strong) NSArray     * dataArray;

@property (nonatomic,strong) NSArray     * imgArray;


@property (nonatomic,strong) NSIndexPath * indexPath;

@end

NS_ASSUME_NONNULL_END
