//
//  KLStorePetTableViewCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/30.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface KLStorePetViewBtn : UIButton

@property (nonatomic, strong) NSString * petImg;
@property (nonatomic, strong) NSString * petName;
@property (nonatomic, strong) NSString * petAge;
@property (nonatomic, strong) NSString * petPrice;

@end


typedef void(^PitTitleBlock)(UIButton * button,id cell);
typedef void(^GoodsBlock)(UIButton * button);

@interface KLStorePetTableViewCell : UITableViewCell

@property (nonatomic, copy)   PitTitleBlock    btnChick;
@property (nonatomic, copy)   GoodsBlock       goodsChick;
@property (nonatomic, strong) NSArray        * titleArray;
@property (nonatomic, assign) NSInteger        markCount;
@property (nonatomic, strong) UIScrollView   * scrollView;
@property (nonatomic, strong) NSMutableArray * itemsArray;

@end

NS_ASSUME_NONNULL_END
