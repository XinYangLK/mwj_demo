//
//  KLStoreGoodsCell.h
//  mwstreet
//
//  Created by 科pro on 2019/1/30.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLStoreGoodsViewBtn : UIButton
@property (nonatomic, strong) NSString * goodsImg;
@property (nonatomic, strong) NSString * goodsName;
@property (nonatomic, strong) NSString * goodsPrice;
@property (nonatomic, strong) NSString * goodsOldPrice;
@end



typedef void(^GoodsTitleBlock)(UIButton * button,id cell);
typedef void(^GoodsBlock)(UIButton * button);

@interface KLStoreGoodsCell : UITableViewCell

@property (nonatomic, strong) NSArray        * titleArray;
@property (nonatomic, copy)   GoodsTitleBlock  btnChick;
@property (nonatomic, copy)   GoodsBlock       goodsChick;

@property (nonatomic, assign) NSInteger        markCount;
@property (nonatomic, strong) UIScrollView   * scrollView;
@property (nonatomic, strong) NSMutableArray * itemsArray;

@end


NS_ASSUME_NONNULL_END
