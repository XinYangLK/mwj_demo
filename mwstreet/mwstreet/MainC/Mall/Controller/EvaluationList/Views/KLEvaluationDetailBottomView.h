//
//  KLEvaluationDetailBottomView.h
//  mwstreet
//
//  Created by 科pro on 2019/3/12.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MsgBlock)(UIButton *sender);
typedef void(^PraiseBlock)(UIButton *sender);

@interface KLEvaluationDetailBottomView : UIView

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic,copy) MsgBlock msgBlock;
@property (nonatomic,copy) PraiseBlock praiseBlock;

@end

NS_ASSUME_NONNULL_END
