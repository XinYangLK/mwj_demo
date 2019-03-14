//
//  KLBHomeHeaderFooterView.h
//  mwstreet
//
//  Created by 科pro on 2019/2/26.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClassifyTitleBlock)(UIButton * sender);

@interface KLBHomeHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIImageView * leftImg;
@property (nonatomic, strong) UILabel     * titleLab;
@property (nonatomic, strong) UIImageView * rightImg;

@property (nonatomic, copy  ) ClassifyTitleBlock titleBlock;

@property (nonatomic, assign) NSInteger markNumber;     // 标记
- (void)setDataArray:(NSArray *)dataArray;

@end

NS_ASSUME_NONNULL_END
