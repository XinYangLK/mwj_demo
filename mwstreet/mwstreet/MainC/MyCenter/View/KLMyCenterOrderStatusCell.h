//
//  KLMyCenterOrderStatusCell.h
//  mwstreet
//
//  Created by 科pro on 2018/12/27.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KLMyCenterOrderStatusCelldelegate <NSObject>

@optional //选实现
- (void)didOrderStatusBtnChick:(UIButton *)sender;//订单状态方法回调

@end

@interface KLMyCenterOrderStatusCell : UITableViewCell

@property (nonatomic, assign) NSInteger markNumber;     // 标记
@property (nonatomic,weak) id<KLMyCenterOrderStatusCelldelegate> delegate;
@property (nonatomic, assign) NSInteger type; //1 个户 ，2 商户 

- (void)setDataArray:(NSArray *)dataArray;

@end

NS_ASSUME_NONNULL_END
