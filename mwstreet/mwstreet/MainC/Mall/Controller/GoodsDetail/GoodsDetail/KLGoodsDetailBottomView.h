//
//  KLGoodsDetailBottomView.h
//  mwstreet
//
//  Created by 科pro on 2019/1/10.
//  Copyright © 2019 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KLGoodsDetailBottomViewDelegate <NSObject>

@optional //选实现
- (void)didActionBtnChick:(UIButton *)sender;//底部按钮View方法回调

@end


@interface KLGoodsDetailBottomView : UIView
//***  联系客服  **/
@property (nonatomic, strong) UIButton * serviceBtn;
//***  分割线  **/
@property (nonatomic, strong) UIView   * line;
//***  收藏  **/
@property (nonatomic, strong) UIButton * collectBtn;
//***  加入购物车  **/
@property (nonatomic, strong) UIButton * addShopCarBtn;
//***  立即下单  **/
@property (nonatomic, strong) UIButton * placeOrderBtn;

@property (nonatomic,weak) id<KLGoodsDetailBottomViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
