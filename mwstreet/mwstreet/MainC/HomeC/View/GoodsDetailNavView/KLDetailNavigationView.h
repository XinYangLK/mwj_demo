//
//  KLDetailNavigationView.h
//  mwstreet
//
//  Created by 科pro on 2018/12/25.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLGoodsDetailProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLDetailNavigationView : UIView

@property (nonatomic, strong) UIView   * backView; //背景Viewz阻击点击层
@property (nonatomic, strong) UIButton * backBtn;  //返回按钮
@property (nonatomic, strong) UIButton * leftBtn;  //商品按钮
@property (nonatomic, strong) UIButton * centerBtn;//评价按钮
@property (nonatomic, strong) UIButton * rightBtn; //详情按钮
@property (nonatomic, strong) UIView   * line;     //指示线

@property (nonatomic,weak) id<KLGoodsDetailProtocol> delegate;

@end

NS_ASSUME_NONNULL_END
