//
//  KLPetHotTableViewCell.h
//  mwstreet
//
//  Created by 科pro on 2019/2/18.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLHotPetButton : UIButton

@property (nonatomic, strong) UIImageView * petImgV;
@property (nonatomic, strong) UILabel     * petNameLab;
@end


typedef void(^HotPetBlock)(KLHotPetButton * sender);

@interface KLPetHotTableViewCell : UITableViewCell

@property (nonatomic,copy) HotPetBlock hotPetBlock;
/**
 * 自定义 cell初始化
 * @param  tableView     表
 * @param  hotPetArray  热门城市数组
 */
+ (KLPetHotTableViewCell *)initWith:(UITableView *)tableView hotPetArray:(NSArray *)hotPetArray;

@end

NS_ASSUME_NONNULL_END
